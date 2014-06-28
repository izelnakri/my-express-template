var gulp       = require('gulp'),
    nodemon    = require('gulp-nodemon'),
    coffeelint = require('gulp-coffeelint'),
    coffee     = require('gulp-coffee'),
    uglify     = require('gulp-uglify'),
    sass       = require('gulp-ruby-sass'),
    prefix     = require('gulp-autoprefixer'),
    minifyCSS  = require('gulp-minify-css'),
    concat     = require('gulp-concat'),
    imagemin   = require('gulp-imagemin'),
    size       = require('gulp-size')
    // htmlmin    = require("gulp-htmlmin");

    //optional
    //sprite   = require('gulp-sprite')

var paths = {
  scripts: ['dev/coffee/base.coffee', 'dev/coffee/collection.coffee', 'dev/coffee/view.coffee'],
  sass: 'dev/sass/main.sass'
};

//define the sequence
gulp.task('scripts', function() {
  return gulp.src(paths.scripts) //path.scripts array specifies the order of concat
    .pipe(coffee())
    .pipe(uglify())
    .pipe(concat('custom.min.js'))
    .pipe(gulp.dest('dev/source'))
    cb(err)
});

gulp.task('compile-js',['scripts'], function() {
  return gulp.src(['dev/source/backbone-min.js','dev/source/custom.min.js'])
    .pipe(concat('production.min.js'))
    .pipe(gulp.dest('public/js'))
})

// define the sequence
gulp.task('sass', function(cb) {
  return gulp.src(paths.sass) //path.sass array specifies the order of concat
    .pipe(sass({sourcemap: true, require: ["susy"], compass: true,cacheLocation: "dev/source/.sass-cache"}).on("error", function(err) {console.log(err)}))
    .pipe(prefix())
    .pipe(minifyCSS())
    .pipe(concat('custom.min.css'))
    .pipe(gulp.dest('dev/source'))
    cb(err)
});

gulp.task('compile-css', ['sass'], function() {
  return gulp.src(['dev/source/pure-min.css','dev/source/custom.min.css'])
    .pipe(concat('production.min.css'))
    .pipe(gulp.dest('public/css'))
});

gulp.task('compile-js-lib', ['scripts', 'compile-js'], function() {
  return gulp.src(['dev/source/lodash.min.js','dev/source/big.min.js', 'dev/source/cookie.min.js','dev/source/googleanalytics.min.js'])
    .pipe(concat('lib.min.js'))
    .pipe(gulp.dest('public/js'))
});

gulp.task('watch', function () {
  gulp.watch(paths.scripts, ['scripts','compile-js-lib','compile-js']);
  gulp.watch(paths.sass, ['sass', 'compile-css']);
});

gulp.task('compile', ['scripts', 'sass', 'compile-css', 'compile-js-lib', 'compile-js']);

gulp.task('develop', function() {
  nodemon({ script: "server.coffee",  ignore: ['node_modules/**', 'tmp/**']})
});

gulp.task('default', ['compile', 'watch', 'develop']);


/** gulp plugins to consider:
DECIDE on htmlmin or minify-html
 - probably htmlmin
 - gulp compass
 - gulp clean
 - gulp cache
 - gulp notify

 gulp-csso 0.2.3
 gulp-rev 0.2.1
 gulp-imacss 0.1.1
 gulp-cdnizer 0.2.2
 css-sprite 0.5.0
 gulp-data-uri 0.1.2
 gulp-svg2png 0.1.1 
- gulp font to svg and different formats 
**/

