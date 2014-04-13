## Puzzle 2: Over Easy

Boggle, for when you have a calculator ready

### Getting started

The goal is simple on its face: define a 5x5 Boggle board with exactly one
of each letter `A-Z` (with `I`, `J` equated) which yields the longest
legal words possible. However, instead of the normal Boggle rules,
a word is legal if each letter is a strictly increasing Euclidean
distance from the previous letter.

### Gettin' OO up in here

For all its warts, I'm proudest of the code I wrote for this puzzle, taking
an object-oriented appraoch to modeling an `OverEasy::Board` and 
`OverEasy::Coordinate`. (Checking the code, you can see the commented out
`OverEasy::Word`, which turned out to be a waste of time as you'll see.)

Coordinates represent a pair of integers from `0` to `4`, and can optionally
be initialized by a single integer `0` to `24`. In addition to the 
convenience of initializing by a single integer, the distance function is
written as a method `#distance_from(other)`. Actually, distance is measured
as squared distance, since there's no useful reason to actually take the 
square root (which is a monotonic increasing function).

A Board is initialized by an array of strings, each holding a character
from `'A'` to `'Z'`.  `#random` provides a convenience method for generating
a random Board without specifying an array.  Upon initialization I wanted to
go ahead and generate the legal terms for each specific board.

### Watch your search space

I wasted maybe up to an hour with `OverEasy::Word`, because I forgot the 
cardinal rule of solving word puzzles by programming: always use the word
list as your search space. My first attempt to solve the puzzle involved
emulating a human player by looking at the Board first, and finding all the 
characters of increasing distances. At each step, I'd check the dictionary
to see if it was a legal partial word (representing it as an 
`OverEasy::Word` and using an `#is_partial?` method).
If so, I recursed to try and extend that partial word.

So, if you're playing along, that's a hell of a lot of dead ends, and at
every step of the way, I was searching through a dictionary of almost
200,000 words. As you can imagine, it ran very slowly even with a few
attempts at caching failed partial words.

### A saner approach

Once I came to my senses, the direction was clear. Taking each term in
the dictionary, the board finds the first two letters in the grid and records
the distance between them. Following that, it finds the next letter and 
measure its distance from the previous. If that distance is strictly greater, 
the new distance is recorded, rinse and repeat until the word is completed
or the distance to the next letter is too short.

At that point, it's really easy to store all the legal words, sort by their
length, and pull the 25 longest to find the overall value of the board.

### My mistakes

Speaking with Eric and players from Team Mint afterwards, I realized my
"shotgun" approach of generating and checking random boards was a poor 
decision that could have been easily improved
by setting at least some of the board manually:

- Eric informed me that during playtesting the highest score found was
  over 250 points.  He suggested that by embedding a legal 15-letter word
  in the grid it'd be easier to find a board worth a higher amount of points.
- Team Mint made sure that the suffix "INGS" was a legal partial with 
  a large distance between letters, giving a greater chance of yielding
  longer words.

Probably both of those could be combined as well. But my largest mistake was
not using my teammates to get ideas on how to optimize the search space
of boards, since they may also have come up with one or another of these
ideas.

Team Ecru scored 186 points for this puzzle (the sum of lengths of the
25 longest words). This was (I believe) the second-highest score, beaten
by Team Mint who scored 210 points.