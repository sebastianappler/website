update:
	git submodule foreach git pull

build:
	npm --prefix themes/bilberry-hugo-theme/ install
	npm --prefix themes/bilberry-hugo-theme/ run production

run: update build
	hugo server

deploy: update build 
	hugo
	rsync -avz --delete public/ $(TARGET_DIR)
