
indexing

description: "Some mathematical functions that ISE forgot or got wrong";
keywords: "mathematical functions", "trigonometry", "rounding",
          "random numbers";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class MATH

feature -- Trigonometry

    deg : DOUBLE is 57.29577951308232087680  -- degrees/radian

    arctan2 (y, x : DOUBLE) : DOUBLE is
        -- arctan of y/x; the value is in [-pi, pi]
        -- and takes the quadrant of (x, y) into account.

        external "C"
        alias    "atan2"
        
        end
--------------------------------------------------------
feature -- Miscellany

    floor (d : DOUBLE) : INTEGER is
         -- The largest integer <= d.
         -- Everybody knows the value of `floor' is an INTEGER
         -- c.f. Knuth "Fundamental Algorithms", p. 37.
         -- The fact that the C library also got it wrong is no excuse.

        external "C"
        alias    "c_floor"

        end
--------------------------------------------------------

    ceiling (d : DOUBLE) : INTEGER is
        -- The smallest integer >= d.
        -- See the comment on `floor'.

        external "C"
        alias    "c_ceiling"

        end
--------------------------------------------------------

    abs (x : INTEGER) : INTEGER is
        -- The value is |x|.

        do
            if x > 0 then
                result := x
            else
                result := -x
            end
        end
--------------------------------------------------------
feature -- Random numbers

    srand (seed : INTEGER) is
        -- Initialize the random number generator with seed `seed'.

        external "C"
        alias    "c_srand"
        end
--------------------------------------------------------

    rand : INTEGER is
        -- The next random number.

        external "C"
        alias    "c_rand"
        ensure
            range : 1 <= result and then result <= 10
        end
    
end -- class MATH

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------
