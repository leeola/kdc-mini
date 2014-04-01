#
# # Gulpfile
#
gulp = require 'gulp'
coffee = require 'gulp-coffee'
insert = require 'gulp-insert'


paths =
  bin: 'bin/kdc-mini.coffee'


gulp.task 'bin', ->
  gulp.src paths.bin
    .pipe coffee()
    .pipe insert.prepend '#!/usr/bin/env node\n'
    .pipe gulp.dest 'build/bin'


gulp.task 'build', ['bin']
gulp.task 'default', ['build']
