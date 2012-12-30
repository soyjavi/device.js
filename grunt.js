module.exports = function(grunt) {

  grunt.initConfig({
    pkg: '<json:package/component.json>',

    meta: {
        file: "device",
        banner: '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("m/d/yyyy") %>\n' +
                '   <%= pkg.homepage %>\n' +
                '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
                ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */'
    },

    resources: {
        coffee: ['src/**/*.coffee', 'spec/**/*.coffee'],
        js: ['build/src/**/*.js']
    },

    coffee: {
      app: {
        src: ['<config:resources.coffee>'],
        dest: 'build',
        options: {
            bare: true,
            preserve_dirs: true
        }
      }
    },

    concat: {
      js: {
        src: ['<config:resources.js>'],
        dest: 'package/<%=meta.file%>.js'
      }
    },

    min: {
      js: {
        src: ['<banner>', 'package/<%=meta.file%>.js'],
        dest: 'package/<%=meta.file%>.min.js'
      }
    },

    watch: {
      files: ['<config:resources.coffee>'],
      tasks: 'coffee concat'
    },


    uglify: {}
  });

  grunt.loadNpmTasks('grunt-coffee');

  // Default task.
  grunt.registerTask('default', 'coffee concat min');

};
