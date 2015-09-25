var gulp        = require("gulp"),
	compass     = require("gulp-compass"),
	minifyCss   = require("gulp-minify-css"),
	coffee      = require("gulp-coffee"),
	uglify      = require("gulp-uglify"),
	source      = require("vinyl-source-stream"),
	streamify   = require("gulp-streamify"),
	browserSync = require('browser-sync').create(),

	pathes      = {
		appName: "NewPattern",
		src: {
			scripts: "./app/assets/scripts",
			styles : "./app/assets/styles"
		},
		dest: {
			scripts: "./public/javascripts",
			styles : "./public/stylesheets"
		}
	},
	sourceFile = pathes.src.scripts + "/Application.coffee",
	destFile   = "Application.js";


gulp.task("compass", function() {
	return gulp.src(pathes.src.styles + "/" + pathes.appName + ".sass")
		.pipe(streamify(compass({
			project_path: __dirname + "/",
			css         : pathes.dest.styles,
			sass        : pathes.src.styles
		})))
		.pipe(streamify(minifyCss()))
		.on("error", console.log)
		.pipe(gulp.dest(pathes.dest.styles))
		.pipe(browserSync.stream());
});

gulp.task("coffee", function() {
	return gulp.src("./app/assets/scripts/**/*.coffee")
		.pipe(coffee({bare: false})
		.on("error", console.log))
		.pipe(gulp.dest(pathes.dest.scripts))
		.pipe(browserSync.stream());
});

gulp.task("vendor", function() {
	return gulp.src("./app/assets/scripts/libs/**/*.js")
		.on("error", console.log)
		.pipe(gulp.dest(pathes.dest.scripts + "/libs/"))
		.pipe(browserSync.stream());
});

gulp.task("html", function() {
	return gulp.src("./app/views/*.html")
		.pipe(gulp.dest("./public/"));
});

gulp.task("views", function() {
	return gulp.src("./app/views/templates/**/*.html")
		.pipe(gulp.dest("./public/views/"));
});

gulp.task("serve", ["compass", "coffee", "html", "views"], function() {
	browserSync.init({
		server: "./public"
	});

	gulp.watch(pathes.src.styles + "/**/*.sass", ["compass"]);

	gulp.watch(pathes.src.scripts + "/**/*", ["coffee"]);

	gulp.watch("./app/views/**/*.html", ["html"]).on("change", browserSync.reload);
	gulp.watch("./app/views/templates/**/*.html", ["views"]).on("change", browserSync.reload);

	browserSync.watch([pathes.dest.styles + "/**/*.css", pathes.dest.scripts + "/**/*.js"], function (event, file) {
		if (event === "change") {
			browserSync.reload();
		}
	});
});

gulp.task("default", ["vendor", "serve"]);
