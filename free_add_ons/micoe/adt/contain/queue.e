indexing

description: "This class implements the classic queue abstraction%
             % with FIFO semantics. These queues are dynamic in size%
             % resizing themselves as needed; thus there is no%
             % function `full'; however, they do shrink, whenever%
             % possible so as to make optimal use of space.";
keywords: "FIFO", "dynamic"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   QUEUE [G]

inherit
    ANY
        redefine
            is_equal, copy
    end

creation
    make

feature -- Initialization


    make is

        local
            i : INTEGER

        do
            create store.make (1, Min_size)
            in_idx  := 1
            out_idx := 1
            count   := 0
        end
-----------------------------------------------------------
feature -- Status

    count : INTEGER   -- The number of elements in the queue.   

    empty : BOOLEAN is
          -- This is a convenience function.

        do
            result := (count = 0)

        ensure
            right_answer : result = (count = 0)
        end
-----------------------------------------------------------
feature -- Access

    item : G is
          --  The element at the front of the queue.

        require
            not_empty : not empty

        do
            result := store.item (out_idx)
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G) is
          --  Append the element `x' to the end of the queue.

        do 
            if count = store.count - 1 then 
                expand
            end

            store.put (x, in_idx)
            in_idx := (in_idx \\ store.count) + 1
            count  := count + 1
        end
-----------------------------------------------------------

    remove is
          --  Remove the element at the front of the queue.

        require
            not_empty : not empty

        do
            out_idx := (out_idx \\ store.count) + 1
            count   := count - 1

            if count < (store.count // 4) and then store.count > Min_size then
                shrink
            end
        end 
-----------------------------------------------------------
feature -- Comparison

    is_equal (other : like current) : BOOLEAN is

        local
            i1, i2, j : INTEGER

        do
            from
                result := (other /= void and then count = other.count)
                j      := 0
                i1     := out_idx
                i2     := other.out_idx
            until
                not result or else j = count
            loop
                if store.item (i1) /= other.store.item (i2) then
                    result := false
                else
                    j  := j + 1
                    i1 := (i1 \\ store.count) + 1
                    i2 := (i2 \\ other.store.count) + 1
                end
            end
        end
-----------------------------------------------------------
feature -- Copying

    copy (other : like current) is

        do
            standard_copy (other)
            store := clone (other.store)
        end
-----------------------------------------------------------

feature { QUEUE }

    Min_size : INTEGER is 16
    store    : ARRAY [G]        -- actual storage
    in_idx   : INTEGER          -- index for next add
    out_idx  : INTEGER          -- index for item and remove

-----------------------------------------------------------

feature { NONE }

    expand is

        local
            s        : ARRAY [G]
            i        : INTEGER
            old_size : INTEGER

        do
            old_size := store.count
            create s.make (1, 2 * old_size)

            from
                i := 1
            until
                out_idx = in_idx
            loop
                s.put (store.item(out_idx), i)
                out_idx := (out_idx \\ old_size) + 1
                i       := i + 1
            end

            store   := s
            in_idx  := i
            out_idx := 1
        end
-----------------------------------------------------------

    shrink is

        local
            s        : ARRAY [G]
            old_size : INTEGER
            i        : INTEGER

        do
            old_size := store.count
            create s.make (1, old_size // 2)

            from
                i := 1
            until
                out_idx = in_idx
            loop
                s.put (store.item (out_idx), i)

                out_idx := (out_idx \\ old_size) + 1
                i       := i + 1
            end

            store   := s  
            out_idx := 1
            in_idx  := i
        end
-----------------------------------------------------------

end -- class QUEUE

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
