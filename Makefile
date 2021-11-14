update:
	git pull origin master
	git submodule foreach git pull

build:
	npm --prefix themes/bilberry-hugo-theme/ install

run:
	hugo server

deploy: update build 
	npm --prefix themes/bilberry-hugo-theme/ run production
	hugo
	rsync -avz --delete public/ $(TARGET_DIR)
		
