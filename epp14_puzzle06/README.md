## Puzzle 10: "Humpty Dumpty"(?)

Pentomino-tiling with a hexagonical twist.

### Getting started

After spending a little time on another puzzle called "crack.open.this.egg"
(which, other than a non-standard file compression/archival format,
wasn't very technical) and not getting anywhere, I was handed this puzzle.
Having seen @jamesdabbs blast through a similar pentomino puzzle last
year, I knew that the only sensible solution was to find or write a solver.

### Finding the right library

I knew that I wouldn't have time to start from scratch. Knowing that
pentomino solvers existed, I started by looking at 
<https://github.com/jirapave/PentominoRuby>. I poked around with it a
little, but knew that in order to adapt it, I had to learn more about
modeling hexagonical grids.

[This page](http://www.redblobgames.com/grids/hexagons/) is filled with
a lot of cool information on different ways to represent a hexogonical
tiling of the plane, particularly in the context of a video game. But it
became apparent that I had a lot of work ahead of me if I was going
to adapt a vanilla pentomino script to work with these objects.

### What are these things?

I wish I had a copy of my search history for about this time. I figured
that Eric wasn't the first person to work with these pentomino derivatives,
but I couldn't for the life of me figure out what they were called.

I finally stumbled upon <http://puzzler.sourceforge.net/>, which identified
them as "Pentahexes". (My working term for them was "hexapents". So close!)
On the [pentahex page](http://puzzler.sourceforge.net/docs/pentahexes.html)
I saw many examples, but unsurprisingly, none of them were an egg.

The page made it apparent that these solutions were found programmatically,
but the awful design made it very difficult to find the actual library, much
less what language it was written in.

I finally found the [README](http://puzzler.sourceforge.net/README.html),
so I downloaded, extracted, and `sudo python setup.py install`ed.

### Setting up the puzzle

Since no one had defined an egg-shaped grid for the library, I needed
to define it myself.  I adapted this 
[hexagon-shaped puzzle](http://puzzler.sourceforge.net/docs/images/hexes/pentahexes-hexagon-1.png) 
from the source for this purpose
(commented added by myself for this post):

~~~python
class PentahexesHexagon1(Pentahexes):

    # the egg is contained within a trapezoid
    # of horizontal (0 and pi radians) width 13 units
    # and "vertical" (pi/3 and 4pi/3 radians) height
    # 13 units
    height = 13
    width = 13

    # only coodinate tuples yielded by this function
    # are included in the puzzle
    def coordinates(self):
        # toss in cells we don't want here
        hole = set()
        # remove the center hole
        for y in range(4, 9):
            for x in range(4, 9):
                if 9 < x + y < 15:
                    hole.add((x,y))
        # two more to remove
        hole.remove((8,6))
        hole.remove((4,6))
        # remaining grid is a trapezoid with a hole
        for y in range(self.height):
            for x in range(self.width):
                # don't use lower-left or upper-right corners
                # to make a hexagon
                if 5 < x + y < 19 and (x,y) not in hole:
                    yield (x, y)

    # allow full rotations and flips
    def customize_piece_data(self):
        self.piece_data['P5'][-1]['rotations'] = (0, 1, 2)
        self.piece_data['P5'][-1]['flips'] = None
~~~

Due to the irregular shape of the egg, I removed the lower-left
and upper-right corners in a similar manner, but otherwise I just
hand-wrote all the holes to add from the upper-left and lower-right.

You can run the resulting script in `solution.py` (after installing
the puzzler library).

Team Ecru was the first team to solve this puzzle.



### Alternate Solution

Team Mint, sporting many of my colleages from Auburn University's
graduate math program, used 
[Knuth's Algorithm X](http://en.wikipedia.org/wiki/Knuth%27s_Algorithm_X) 
to (un)crack this egg. Since I wasn't on their
team I can't say much more, but if I can convince one of them to write up
their process I'll be sure to add it here.