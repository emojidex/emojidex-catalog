module.exports = (grunt) ->
  grunt.initConfig

    # Import package manifest
    pkg: grunt.file.readJSON('package.json')

    # Banner definitions
    meta:
      banner:
        '/*\n' +
        ' *  <%= pkg.title || pkg.name %> - v<%= pkg.version %>\n' +
        ' *  <%= pkg.description %>\n' +
        ' *  <%= pkg.homepage %>\n' +
        ' *\n' +
        ' *  Made by <%= pkg.author %>\n' +
        ' */\n'

    # CoffeeScript compilation
    coffee:
      compile:
        expand: true
        cwd: 'src/coffees/'
        src: ['concatenated.coffee']
        dest: 'src/compiled_js/'
        ext: '.js'

    # Concat definitions
    concat:
      coffee:
        src:[
          'src/coffees/catalog/**/*.coffee'
        ]
        dest: 'src/coffees/concatenated.coffee'

    # Minify definitions
    uglify:
      catalog:
        options:
          banner: '<%= meta.banner %>'
        src: ['src/compiled_js/concatenated.js']
        dest: 'dist/js/emojidex-catalog.min.js'
      bootstrap:
        src: ['node_modules/bootstrap-sass/assets/javascripts/bootstrap.js']
        dest: 'dist/js/bootstrap.min.js'

    # connect definitions
    connect:
      site: {}

    # sass definitions
    sass:
     dist:
       files: [
        expand: true
        cwd: 'src/sass/'
        src: '*.scss'
        dest: 'dist/css/'
        ext: '.css'
       ]

    # slim definitions
    slim:
      options:
        pretty: true;
      demos:
        files: [
          expand: true
          cwd: 'src/slim/'
          src: '*.slim'
          dest: 'dist/'
          ext: '.html'
        ]

    # slim definitions
    copy:
      img:
        expand: true,
        cwd: 'src/img/'
        src: '**/*'
        dest: 'dist/img/'
      lazyload:
        expand: true,
        cwd: 'node_modules/lazyload/'
        src: 'jquery.lazyload.min.js'
        dest: 'dist/js/'

    # Watch definitions
    watch:
      html:
        files:['src/slim/*.slim']
        tasks:['slim']
      coffee:
       files: ['src/coffees/**/*.coffee']
       tasks: ['concat', 'coffee', 'uglify']
      sass:
       files: ['src/sass/*.scss']
       tasks: ['sass']

      options:
        livereload: true

    # Lint definitions
    # jshint:
    #   files: ['src/jquery.emojidex.js']
    #   options:
    #     jshintrc: '.jshintrc'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-slim'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.registerTask 'default', ['slim', 'sass', 'copy', 'concat', 'coffee', 'uglify']
  grunt.registerTask 'dev', ['connect', 'watch']
  # grunt.loadNpmTasks 'grunt-contrib-jshint'
  # grunt.registerTask 'travis', ['jshint']