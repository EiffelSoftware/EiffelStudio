indexing

description: "It isn't easy to implement bitmasks efficiently in Eiffel. This%
             % attempts to repair that deficiency. All operations are %
             %nondestructive and thus produce endless new objects that %
             %eventually become garbage, contrary to the general policy of %
             %garbage avoidance, but it can't be helped.";
keywords: "efficient", "bitmask"

class FLAGS

creation
    make, make_from_array

feature -- Access

    value : INTEGER 
        -- The value of the bitmask as an integer.
    size  : INTEGER
        -- The number of bits in the bitmask.
 
feature -- Initialization
 
    make (val, sz : INTEGER) is
        -- Initialize a bitmask with `sz' bits and initial value `val'.

        do
            value := val
            size  := sz
        end
-------------------------------------------------------------------------

    make_from_array (a : ARRAY [INTEGER]) is
        -- The entries in `a' are the nibbles of the final value.
        -- `a' has Bigendian order.
        -- For example with `a' = <<8,0,0,,0,0,0,0,1>> the flag is
        -- 0x80000001L.

        local
            i, n : INTEGER

        do
            from
                i := a.lower
                n := a.upper
            until
                i > n
            loop
                value := 16 * value + a.item (i)
                i   := i + 1
            end
            size := 4 * n
        end
-------------------------------------------------------------------------
feature -- Bitwise operators

    infix "&" (other : FLAGS) : FLAGS is
        -- Bitwise and.

        do
            create result.make (int_and (value, other.value), size)
        end
-------------------------------------------------------------------------

    infix "|" (other : FLAGS) : FLAGS is
        -- Bitwise or.

        do
            create result.make (int_or (value, other.value), size)
        end
-------------------------------------------------------------------------

    infix "^" (other : FLAGS) : FLAGS is
        -- Bitwise exclusive or.

        do
            create result.make (int_xor (value, other.value), size)
        end
-------------------------------------------------------------------------

    prefix "not" : FLAGS is
        -- Bitwise inversion.

        do
            create result.make (int_not (value, size), size)
        end
-------------------------------------------------------------------------
feature { FLAGS } -- Implementation

    int_and (i1, i2 : INTEGER) : INTEGER is

        external "C"
        
        end
-------------------------------------------------------------------------

    int_or (i1, i2 : INTEGER) : INTEGER is

        external "C"

        end
-------------------------------------------------------------------------

    int_xor (i1, i2 : INTEGER) : INTEGER is

        external "C"

        end
-------------------------------------------------------------------------

    int_not (i, sz : INTEGER) : INTEGER is

        external "C"

        end

end -- class FLAGS

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
