module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-mocha-test')

  grunt.initConfig
    watch:
      coffee:
        files: 'src/*.coffee'
        tasks: ['coffee:compile', 'mochaTest']
      tests:
        files: 'test/*.coffee'
        tasks: ['mochaTest']

    coffee:
      compile:
        expand: true,
        flatten: true,
        src: ['src/*.coffee'],
        dest: 'lib/',
        ext: '.js'
    
    mochaTest:
      test:
        options:
          reporter: "spec"
          compilers: "coffee:coffee-script/register"
        src: ["test/**/*.coffee"]
