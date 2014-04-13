## Puzzle 10: Philosopher's Egg

A scroll of nonsense(?) characters must be interpreted. But then what?...

### Getting started

This is the first puzzle I took a crack at. I helped playtest a similar
cryptogram designed by Eric which used symbols instead of letters, so
I figured going that route as the best place to start.

While I'd like to get/write some frequence analysis code to be able to
crack these locally, the quick solution method was just to use an existing
web app. <http://www.wordplays.com/cryptogram> works well, but I needed to
have characters representing letters be represented as letters in the first
place.

### Solving the cryptogram

I downloaded the PDF and copy-pasted the text into Sublime Text. The
characters were unicode which did not display in the editor, but by
selecting each one at a time, I was able to Find All and replace all the
letters in the top message with the letters `A-Y`.

Plugging just the top part in the cryptogram solver, I easily got this
message:

```
much like the alchemy of substances the alchemy of 
language requires the use of two things components 
and processes. the components are the letters that 
form words and the processes are the functions by 
which one alters those words. below i give examples 
of the most commonly used processes. i am sure other 
alchemists use different symbols of representation 
but i have found these to be most suited to my work. 
```

This made the rest of the puzzle evident: roman numerals were simple
integers, and the other symbols represented functions on strings.

### Interpreting the rest

I replaced all the roman numerals with integers and the function characters
with unused symbols, and `epp14_puzzle10.txt` was the result. Running it
through the cryptogram solver, I got `epp14_puzzle10_crack.txt`.

This gave me enough information to interpret the meaning of each function.
I relabled the functions as `_funcName_` in `epp14_puzzle10_func.txt` for
readability.

### Bringing it home with some code

In retrospect, while the functions are nested fairly deeply, it wouldn't
have been too much work to parse them by hand. I probably lost a little bit
of time for this, but instead I implemented the functions as Ruby methods.

Comparing `epp14_puzzle10_func.txt` with `epp14_puzzle10.rb` you can see
I defined the methods in the same order as given in the puzzle, and even
used the examples as rudimentary "tests" to make sure they were all
working correctly. I was then able to reinterpret the notation given in the
puzzle in Ruby without too much effort.

Running the script revealed some errors, and you can see that I did end up
crunching parts by hand since I wasn't sure which functions were implemented
incorrectly. But in the end, I found where the solution code was hidden,
despite a small typo (I think on my part):

```
railroad
crossing
ar
ross
```

[Google Maps link](https://www.google.com/maps/place/336+N+Ross+St/@32.611837,-85.475367,3a,75y,280.48h,79.69t/data=!3m4!1e1!3m2!1sJ4hkidQFiOJsPMXvBr32kQ!2e0!4m2!3m1!1s0x888cf2e0e3953ce9:0xe7dd08a5cf891ad9)

Team Ecru was the first team to solve this puzzle.
