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
      src: ''
      dest: ''
      inputExt: 'json'  # @TODO, plan to support js/json
      outputExt: 'js'   # @TODO, plan to support js/json

    inputFileExtAndExistRegex = new RegExp "\\w+.#{options.inputExt}$"
    inputFileExtRegex = new RegExp ".#{options.inputExt}$"
    destFilePath = "#{options.dest}.#{options.outputExt}"
    destFileStr = ''
    destFileObj = {}

    iterateLocales = ( absPath, rootDir, subDir, fileName ) ->
      # Only inputExt file will be process
      return if not inputFileExtAndExistRegex.test fileName

      folderLayer = ( subDir.split '/' ).length

      # @TODO Only support 2 layer now lang/namspace
      grunt.fail.fatal "can't deeper than 2 layer now" if folderLayer > 1

      # Read source file, read dest file. merge them. write it in dest file
      lang = subDir
      namespace = fileName.replace inputFileExtRegex, ''

      destFileObj[ lang ] = {} if not destFileObj[ lang ]
      destFileObj[ lang ][ namespace ] = JSON.parse grunt.file.read absPath

    # If src folder not exist or not a folder, throw error.
    if not grunt.file.isDir options.src
      grunt.fail.fatal "options 'src' must be a folder."

    # Delete old file and create an empty file
    grunt.file.delete destFilePath

    # Append js file
    grunt.file.recurse options.src, iterateLocales

    destFileStr += 'define( function( require, exports, module ){\nmodule.exports='
    destFileStr += JSON.stringify destFileObj
    destFileStr += '\n});'

    grunt.file.write destFilePath, destFileStr

    grunt.log.writeln "#{destFilePath.cyan} created."