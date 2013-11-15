###*
  grunt-contrib-i18next
  http://gruntjs.com/

  Copyright (c) 2013 Ignacio Rivas
  Licensed under the MIT license.
  https://github.com/sabarasaba/grunt-contrib-i18next/blob/master/LICENSE-MIT
###
###*
  grunt-contrib-i18next
  http://gruntjs.com/

  Copyright (c) 2013 Jonathan Dang
  Licensed under the MIT license.
  https://github.com/jonakyd/grunt-contrib-i18next
###

module.exports = (grunt) ->
  'use strict'

  grunt.registerMultiTask 'i18next', 'Build locale files.', ->
    options = @options
      srcFolder : 'app/locales'
      destFile  : 'build/locales.json'

    jsonConcat = ( keyArr, destObj, srcObj ) ->
      lang = keyArr[ 0 ]
      namespace = keyArr[ 1 ]

      if ( !destObj.hasOwnProperty lang )
        destObj[ lang ] = {}

      destObj[ lang ][ namespace ] = srcObj

    iterateLocales = ( absPath, rootDir, subDir, fileName ) ->
      destFilePath = options.destFile

      # Only json file will be process
      if( !/\w+.json$/.test fileName )
        return

      # If dest file doesn't exist, then just copy it.
      if ( !grunt.file.exists destFilePath )
        grunt.file.write destFilePath, JSON.stringify {}

      # Read source file, read dest file. merge them. write it in dest file
      lang = ( subDir.split '/' )[ 0 ]
      namespace = fileName.replace /.json$/, ''
      srcFile = grunt.file.readJSON absPath
      destFile = grunt.file.readJSON destFilePath
      mergedFile = jsonConcat [ lang, namespace ], destFile, srcFile

      console.log( destFile )
      console.log( mergedFile )
      console.log( '====' );

      grunt.file.write( destFilePath, JSON.stringify( mergedFile ))






        # var data = this.data;
        # grunt.util.async.forEachSeries(this.files, function (f, nextFileObj) {
        #     var destFile = f.dest;
        #     var files = f.src.filter(function (filepath) {
        #         // Warn on and remove invalid source files (if nonull was set).
        #         if (!grunt.file.exists(filepath)) {
        #             grunt.log.warn('Source file "' + filepath + '" not found.');
        #             return false;
        #         } else {
        #             return true;
        #         }
        #     });

        #     var json = concatJson(files, data);
        #     grunt.file.write(destFile, json);
        #     grunt.log.write('File "' + destFile + '" created.');
        # });

    # remove dir
    console.log( @files );
    # grunt.file.recurse options.srcFolder, iterateLocales
