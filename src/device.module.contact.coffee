###
Contacts API (HTML5 Feature)
Pending to final SPEC
http://www.w3.org/TR/contacts-api/

@namespace  Device
@class      Contact
@author     Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

Device.Contact = do (dvc = Device) ->

  _instance = navigator.contacts or null


  create = (properties) ->
    # id: A globally unique identifier. (DOMString)
    # displayName: The name of this Contact, suitable for display to end-users. (DOMString)
    # name: An object containing all components of a persons name. (ContactName)
    # nickname: A casual name to address the contact by. (DOMString)
    # phoneNumbers: An array of all the contact's phone numbers. (ContactField[])
    # emails: An array of all the contact's email addresses. (ContactField[])
    # addresses: An array of all the contact's addresses. (ContactAddress[])
    # ims: An array of all the contact's IM addresses. (ContactField[])
    # organizations: An array of all the contact's organizations. (ContactOrganization[])
    # birthday: The birthday of the contact. (Date)
    # note: A note about the contact. (DOMString)
    # photos: An array of the contact's photos. (ContactField[])
    # categories: An array of all the contacts user defined categories. (ContactField[])
    # urls: An array of web pages associated to the contact. (ContactField[])
    contact = _instance.create properties
    contact.save()
    @

  update = (id, properties, options) ->
    _instance.find properties, ((success) ->), ((error) ->), options
    @

  delete = ->
    @

  find = ->
    _instance.find properties, ((success) ->), ((error) ->), options
    @



# contacts.create
# contacts.find
# Arguments

# contactFields
# contactSuccess
# contactError
# contactFindOptions
# Objects

# Contact
# ContactName
# ContactField
# ContactAddress
# ContactOrganization
# ContactFindOptions
# ContactError
