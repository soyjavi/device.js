###
WebSQL

@namespace Device
@class DB
@author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.DB = do(dvc = Device) ->
  db = null

  ###
  Initialize the SQLite storage (HTML5 Feature)
  @method init
  @param {object} Configuration for the Database
  ###
  init = (name, version, size, schema) ->
    db = openDatabase name, version, name, size
    if db
      schema_len = schema.length
      return unless schema_len
      i = 0
      while i < schema_len
        current = schema[i]
        _regenerateTable current
        _createTable current.name, current.fields
        i++

    else
      throw new Error "[ERROR] Device.DB: DB unnecesible"


  ###
  Select a data set of a given table and based on a selection object
  @method select
  @param {string} Name of the table in the database
  @param {object} [OPTIONAL] Object selection condition
  @param {Function} Callback when the process is complete
  ###
  select = (table, where_obj, callback) ->
    where = (if (where_obj) then " WHERE " + _convertToSql(where_obj, "AND") else "")
    execute "SELECT * FROM " + table + where, (rs) ->
      result = []
      i = 0
      len = rs.rows.length

      while i < len
        result.push rs.rows.item(i)
        i++
      _callbackResponse callback, result


  ###
  Inserts a data set of a given table and based on a data object
  @method insert
  @param {string} Name of the table in the database
  @param {object} Object (or Array of objects) to insert in table
  ###
  insert = (table, data, callback) ->
    if _toType(data) is "object"
      _insertRow table, data
    else
      for row of data
        _insertRow table, data[row]


  ###
  Updates a data set of a given table and based on a data object and
  an optional selection object
  @method update
  @param {string} Name of the table in the database
  @param {object} Data object to update in table
  @param {object} [OPTIONAL] Object selection condition
  ###
  update = (table, data_obj, where_obj, callback) ->
    sql = "UPDATE " + table + " SET " + _convertToSql(data_obj, ",")
    sql += " WHERE " + _convertToSql(where_obj, "AND")  if where_obj
    execute sql


  ###
  Delete a data set of a given table and based on a selection object
  @method drop
  @param {string} Name of the table in the database
  @param {object} [OPTIONAL] Object selection condition
  ###
  drop = (table, where_obj, callback) ->
    where = (if (where_obj) then " WHERE " + _convertToSql(where_obj, "AND") else "")
    execute "DELETE FROM " + table + where + ";"


  ###
  Executes a SQL statement in the SQLite storage
  @method execute
  @param {string} SQL statement
  @param {Function} Callback when the process is complete
  ###
  execute = (sql, callback) ->
    db.transaction (transaction) ->
      transaction.executeSql sql, [], ((transaction, rs) ->
        _callbackResponse callback, rs
      ), (transaction, error) ->
        transaction.executedQuery = sql
        _throwError.apply null, arguments

  _createTable = (table, fields) ->
    sql_fields = ""
    for field of fields
      if _isOwnProperty(fields, field)
        sql_fields += ", "  if sql_fields
        sql_fields += field + " " + fields[field]
    execute "CREATE TABLE IF NOT EXISTS " + table + " (" + sql_fields + ");"

  _regenerateTable = (table) ->
    _dropTable table.name  if table.drop is true

  _dropTable = (table) ->
    execute "DROP TABLE IF EXISTS " + table

  _convertToSql = (fields, separator) ->
    sql = ""
    for field of fields
      if _isOwnProperty(fields, field)
        value = fields[field]
        sql += " " + separator + " "  if sql
        sql += field + "="
        sql += (if (isNaN(value)) then "\"" + value + "\"" else value)
    sql

  _callbackResponse = (callback, response) ->
    setTimeout callback, 100, response  if _toType(callback) is "function"

  _insertRow = (table, row) ->
    fields = ""
    values = ""
    for field of row
      if _isOwnProperty(row, field)
        value = row[field]
        fields += (if (fields) then ", " + field else field)
        values += ", "  if values
        values += (if (isNaN(value) or value is "") then "\"" + value + "\"" else value)
    execute "INSERT INTO " + table + " (" + fields + ") VALUES (" + values + ")"

  _throwError = (transaction, error) ->
    throw new Error("[ERROR] Device.DB " + error.code + ": " + error.message + " \n Executed query: " + transaction.executedQuery)

  _toType = (obj) -> Object::.toString.call(obj).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()

  _isOwnProperty = (object, property) -> Object::.hasOwnProperty.call object, property

  init: init
  select: select
  insert: insert
  update: update
  drop: drop
  execute: execute
