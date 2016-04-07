JS := out/main.js
CSS := out/style.css

all: $(JS) $(CSS)

$(JS): $(wildcard src/*.elm)
	elm make src/Main.elm --output $@

$(CSS): src/style.less
	lessc $^ > $@

clean:
	rm -f $(JS) $(CSS)

watch: all
	while inotifywait -e MODIFY -r src ; do make $^ ; done

.PHONY: all watch clean
