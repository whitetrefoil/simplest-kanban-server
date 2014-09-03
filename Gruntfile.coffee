module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      default:
        options:
          sourceMap: true
        files: [
          expand: true
          cwd: 'src/'
          src: '**/*.coffee'
          dest: 'lib/'
          ext: '.js'
          extDot: 'last'
        ]

    watch:
      options:
        forever: true
      coffee:
        files: [ 'src/**/*.coffee' ]
        tasks: [ 'coffee' ]

    clean:
      default: [ 'lib/' ]


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'build', 'Build the application', [
    'clean', 'coffee'
  ]
  grunt.registerTask 'dev', 'Start a watcher of compiling', [
    'build', 'watch'
  ]

  grunt.registerTask 'default', 'UT (when has) & build', [
    'build'
  ]
