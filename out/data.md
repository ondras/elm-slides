# elm-slides

 - Welcome to the sample presentation
 - Print the page as usual
 - Press <kbd>&rarr;</kbd> to continue...

--8<------

# Source data

 - Specified in a separate Markdown document
 - Check out this presentation's [source](data.md)
 - Individual slides are separated with scissors:

~~~
 ...
 # slide 1
 --8<-----
 # slide 2
 ...
~~~

--8<------

# Navigating the presentation

## Keyboard control crash course

 - First slide: <kbd>Home</kbd>
 - Previous slide: <kbd>&larr;</kbd> <kbd>&uarr;</kbd> <kbd>PgUp</kbd> <kbd>Backspace</kbd>
 - Next slide: <kbd>&rarr;</kbd> <kbd>&darr;</kbd> <kbd>PgDown</kbd> <kbd>Space</kbd>
 - Last slide: <kbd>End</kbd>

--8<------

# Additional features

 - URL/hash for permalinks and navigation
 - Dynamic title based on the first slide
 - Skinnable

--8<------

# Syntax highlighting

 - Courtesy of [highlight.js](https://highlightjs.org/)
 - Just use a fenced code block with a language hint

~~~javascript
function fib(x) {
  if (x < 2) { return 1; }
  return fib(x-1) + fib(x-2); // TODO optimize
}
~~~

--8<------

# Implementation details

 - Written in the [Elm language](http://elm-lang.org/) v0.17
 - This page is an (almost) empty template
 - Uses custom JS ports for title and hash manipulation
 - Check out the [source](https://github.com/ondras/elm-slides/tree/master/src)

--8<------

# That's all, folks!

 - <a href="#" target="_self">Back to the start</a>
