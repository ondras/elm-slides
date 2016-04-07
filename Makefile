MAIN := main.js
SRC := src/main.elm

all: $(MAIN)

$(MAIN): src/main.elm
	elm make $^ --output $@

clean:
	rm $(MAIN)

watch: all
	while inotifywait -e MODIFY -r src ; do make $^ ; done

.PHONY: all watch clean
