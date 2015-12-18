var gulp = require('gulp');
var path = require('path');
var del = require('del'); 
var shell = require('shelljs')
var pkgm = require('./package');
var ts = require('gulp-typescript');
var tfx = require('./node_modules/tfx-cli/_build/app/exec/extension/create');

var _buildRoot = path.join(__dirname, '_build');
var _tasksRoot = path.join(_buildRoot, 'Tasks');
var _extensionsRoot = path.join(_buildRoot, 'Extensions');
var _pkgRoot = path.join(__dirname, '_package');
var _oldPkg = path.join(__dirname, 'Package');
var _wkRoot = path.join(__dirname, '_working');

gulp.task('clean', function (cb) {
	del([_buildRoot, _pkgRoot, _wkRoot, _oldPkg],cb);
});

gulp.task('compile', function (cb) {
	var tasksPath = path.join(__dirname, 'Tasks', '**/*.ts');
	var tsResult = gulp.src([tasksPath, 'definitions/*.d.ts'])
		.pipe(ts({
		   declarationFiles: false,
		   noExternalResolve: true,
		   'module': 'commonjs'
		}));
		
	return tsResult.js.pipe(gulp.dest(path.join(__dirname, 'Tasks')));
});

gulp.task('package', ['build'], function() {
	shell.mkdir('-p', _extensionsRoot);
	tfx.createExtension(
		{
			root: './',
			manifestGlobs: ['vss-extension.json'],
			overrides: {},
			bypassValidation: false
		}, 
		{
			outputPath: _extensionsRoot,
			locRoot: null
		});			
});

gulp.task('build', ['clean', 'compile'], function () {
	shell.mkdir('-p', _tasksRoot);
	return gulp.src(path.join(__dirname, 'Tasks', '**/task.json'))
        .pipe(pkgm.PackageTask(_tasksRoot));
});

gulp.task('default', ['build']);