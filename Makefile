MAIN := main.js

all: $(MAIN)

$(MAIN): $(wildcard src/*.elm)
	elm make src/Main.elm --output $@

clean:
	rm $(MAIN)

watch: all
	while inotifywait -e MODIFY -r src ; do make $^ ; done

.PHONY: all watch clean
