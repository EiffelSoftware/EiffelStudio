indexing

description: "This class implements the classic stack abstraction%
             % with LIFO semantics. These stacks are dynamic in size%
             % resizing themselves as needed; thus there is no%
             % function `full'; however, they do shrink, whenever%
             % possible so as to make optimal use of space.";
keywords: "LIFO", "dynamic"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   STACK [G]

inherit
    ANY
        redefine
            is_equal, copy
    end

creation
    make

feature -- Initialization

    make is

        do
            create store.make (1, Min_size)
            count := 0
        end
-----------------------------------------------------------
feature -- Status

    count : INTEGER   -- The number of elements on the stack.   

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
          -- The element at the top of the stack.

        require
            not_empty : not empty

        do
            result := store.item (count)
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G) is
          -- Push the element `x' onto the top of the stack.

        do 
            count := count + 1  

            if count > store.count then 
                expand
            end

            store.put (x, count)
        end
-----------------------------------------------------------

    remove is
          -- Remove the element at the top of the stack.

        require
            not_empty : not empty

        do
            count := count - 1

            if count < (store.count // 4) then
                shrink
            end
        end
-----------------------------------------------------------
feature -- Comparison

    is_equal (other : like current) : BOOLEAN is

        local
            i : INTEGER

        do
            from
                result := (other /= void and then count = other.count)
                i      := 1
            until
                not result or else i > count
            loop
                if store.item (i) /= other.store.item (i) then
                    result := false
                else
                    i := i + 1
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

feature { STACK }

    Min_size : INTEGER is 16
    store    : ARRAY [G]        -- actual storage

-----------------------------------------------------------

feature { NONE }

    expand is

        do
            store.resize (1, 2 * store.count)
        end
-----------------------------------------------------------

    shrink is

        do
            if store.count > Min_size then
                store.resize (1, store.count // 2)
            end
        end
-----------------------------------------------------------

end -- class STACK

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
