module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package/component.json"

    meta:
      file: 'device'
      banner: """
        /* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("m/d/yyyy") %>
           <%= pkg.homepage %>
           Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */

        """

    resources:
      coffee: ['src/device.coffee', 'src/device.*.coffee']
      test: ['spec/**/*.coffee']
      js: ['build/src/**/*.js']

    coffee:
      options:
        bare: true
        preserve_dirs: true
      compile:
        files:
          'build/device.js': ['<%= resources.coffee %>']


    uglify:
      options:
        mangle: true
        banner: '<%= meta.banner %>'
      my_target:
        files:
          'package/device.js': ['build/device.js']


    watch:
      files: ['<%= resources.coffee %>']
      tasks: ['coffee', 'uglify']


  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"

  # Default task(s).
  grunt.registerTask "default", ["coffee", "uglify"]
