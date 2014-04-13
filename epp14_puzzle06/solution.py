#!/usr/bin/env python
# $Id: pentahexes-10x11.py 571 2012-10-06 21:14:57Z goodger $

""" solutions"""

import puzzler

from puzzler.puzzles.polyhexes import Pentahexes

# from puzzler.puzzles.pentahexes import Pentahexes10x11

class Solution(Pentahexes):

    """? (many) solutions"""

    height = 14
    width = 11

    def coordinates(self):
      holes = [(0,5), (10,0), (10,6), (10,7), (10,8),
                (9,8), (9,9), (8,10), (0,11), (0,12),
                (0,13), (1,12), (1,13), (2,13)]
      for y in range(self.height):
          for x in range(self.width):
            if x + y < 5 or x + y > 18:
              holes.append((x,y))
      for y in range(self.height):
          for x in range(self.width):
              if (x,y) not in holes:
                yield(x,y)


    def customize_piece_data(self):
        self.piece_data['P5'][-1]['rotations'] = (0, 1, 2)

puzzler.run(Solution)
