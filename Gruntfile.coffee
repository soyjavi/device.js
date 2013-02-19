module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package/package.json"

    meta:
      file: 'device'
      banner: """
        /* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("m/d/yyyy") %>
           <%= pkg.homepage %>
           Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */

        """

    resources:
      coffee: ['src/**/*.coffee']
      test: ['spec/**/*.coffee']
      js: ['build/src/**/*.js']

    coffee:
      options:
        bare: true
        preserve_dirs: true
      compile:
        files:
          # 'package/another.js': ['src/**/*.coffee']
          'build/<%= meta.name %>.js': ['<%= resources.coffee %>']
          # 'path/to/result.js': 'path/to/source.coffee'


    uglify:
      options:
        mangle: true
        banner: '<%= meta.banner %>'
      my_target:
        files:
          'package/<%= meta.file %>.js': ['build/<%= meta.file %>.js']


    watch:
      files: ['<%= resources.coffee %>']
      tasks: ['coffee', 'uglify']


  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"

  # Default task(s).
  grunt.registerTask "default", ["coffee", "uglify"]
