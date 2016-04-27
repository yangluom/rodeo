LESS_FILES=$(shell find public/less -name '*.less' -type f)
HBS_FILES=$(shell find public/handlebars-templates -name '*.hbs' -type f)
JS_FILES=$(shell find public/js -type f -name '*.js' | grep -v main.js)
JSX_FILES=$(shell find public/jsx -type f -name '*.jsx')
EXTERNAL_FILES=$(shell find public/js/lib -type f -name '*.js' | tr '\n' ' ')
ACE_FILES=$(shell find public/ace -type f -name '*.js' | grep -v ace.min.js)
APP_FILES=src/editors.js src/console.js src/script.js src/preferences.js src/menu.js

.PHONEY: all css js

all: css js jsx

css: static/css/styles.css static/css/styles-dark.css static/css/styles-presentation.css static/css/styles-cobalt.css

js: static/js/server-main.js static/js/desktop-main.js static/js/ace.min.js static/js/external.min.js

jsx: static/js/startup.js

static/js/startup.js: $(JSX_FILES)
	gulp jsx

static/js/external.min.js : $(EXTERNAL_FILES)
	uglifyjs public/js/lib/jquery.min.js \
		public/js/lib/bootstrap.min.js \
		public/js/lib/bootbox.js \
		public/js/lib/ascii-table.min.js \
		public/js/lib/handlebars-v4.0.2.js \
		public/js/lib/react.js \
		public/js/lib/react-dom.js \
		public/js/lib/jqconsole.min.js \
		public/js/lib/jquery.dataTables.js \
		public/js/lib/jquery.splitter-0.15.0.js \
		public/js/lib/list.js \
		public/js/lib/mousetrap.js \
		public/js/lib/owl.carousel.js \
		public/js/lib/saveSvgAsPng.js	> static/js/external.min.js

static/js/desktop-main.js : $(JS_FILES)
	uglifyjs public/js/console.js \
		public/js/editor/actions.js \
		public/js/editor/add.js \
		public/js/editor/new.js \
		public/js/events/desktop.js \
		public/js/execute.js \
		public/js/file-nav.js \
		public/js/focus.js \
		public/js/handlebars-templates.js \
		public/js/helpers.js \
		public/js/install-package.js \
		public/js/menu/desktop.js \
		public/js/menu/server.js \
		public/js/plots.js \
		public/js/preferences.js \
		public/js/search.js \
		public/js/session.js \
		public/js/shortcuts/display.js \
		public/js/templates.js \
		public/js/upload.js \
		public/js/windows/about.js \
		public/js/windows/display-variable.js \
		public/js/windows/markdown.js \
		public/js/windows/sizing.js \
		public/js/windows/startup-error.js \
		public/js/main.js > static/js/desktop-main.js

static/js/ace.min.js : $(ACE_FILES)
	uglifyjs $(shell find public/ace -type f -name '*.js' | grep -v main.js | tr '\n' ' ')	> static/js/ace.min.js

# src/app.js: $(APP_FILES)
# 	uglifyjs $(APP_FILES) > src/app.js
