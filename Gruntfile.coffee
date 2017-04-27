module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    
    clean: {
      dist: ["dist"]
      build: ["build"]
    }

    concat:
      options:
        separator: ";"
      
      bc_qr_reader:  
        src: [
          'node_modules/jsqrcode/src/grid.js'
          'node_modules/jsqrcode/src/version.js'
          'node_modules/jsqrcode/src/detector.js'
          'node_modules/jsqrcode/src/formatinf.js'
          'node_modules/jsqrcode/src/errorlevel.js'
          'node_modules/jsqrcode/src/bitmat.js'
          'node_modules/jsqrcode/src/datablock.js'
          'node_modules/jsqrcode/src/bmparser.js'
          'node_modules/jsqrcode/src/datamask.js'
          'node_modules/jsqrcode/src/rsdecoder.js'
          'node_modules/jsqrcode/src/gf256poly.js'
          'node_modules/jsqrcode/src/gf256.js'
          'node_modules/jsqrcode/src/decoder.js'
          'node_modules/jsqrcode/src/qrcode.js'
          'node_modules/jsqrcode/src/findpat.js'
          'node_modules/jsqrcode/src/alignpat.js'
          'node_modules/jsqrcode/src/databr.js'
          'build/src/bc-qr-reader.js'
        ]
        dest: "build/bc-qr-reader-concat.js" 
        
    coffee:
      coffee_to_js:
        options:
          bare: true
          sourceMap: false
        expand: true
        flatten: false
        src: ["src/bc-qr-reader.js.coffee"]
        dest: 'build'
        ext: ".js"
        
    surround:
      wraps: 
        options: 
          prepend: '(function() { if (/internet explorer/i.test(window.navigator.userAgent) || /MSIE/i.test(window.navigator.userAgent)) { return; }',
          append: '})()'
        files: [{
          src: 'build/bc-qr-reader-concat.js'
          dest: 'dist/bc-qr-reader.js'
        }]
  
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-surround')
    
  grunt.registerTask "compile", ["coffee"]  
    
  grunt.registerTask "dist", [
    "clean"
    "compile"
    "concat"
    "surround"
  ]

  return