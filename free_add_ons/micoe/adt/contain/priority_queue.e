indexing

description: "This is a self-reorganizing structure that keeps%
             % the largest element at the front of the queue at%
             % all times. That is the priority of an element is%
             % determined by the position of the element in the%
             % total order on G. The structure is implemented with%
             % a heap so as to make `add' as efficient as possible.";
keywords: "priority", "queue"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   PRIORITY_QUEUE [G -> COMPARABLE]

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

    count : INTEGER  -- The number of elements in the queue.

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
        --  No other element has a higher priority.

        require
            not_empty : not empty

        do
            result := store.item (1)
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G) is
          --  Insert `x' at the appropriate position in the queue.

        local
            i : INTEGER

        do
            count := count + 1 
 
            if count > store.count then
                expand
            end

            from
                i := count
            until
                i = 1 or else x <= store.item (i // 2)
            loop
                store.put (store.item (i // 2), i)
                i := i // 2
            end

            store.put (x, i)
        end
-----------------------------------------------------------

    remove is
        --  Remove the element at the front of the queue.

        require
            not_empty : not empty

        do
            store.put (store.item (count), 1)
            count := count - 1

            if count > 0 then
                bu_heapify
            end

            if count < store.count // 4 and then 
               store.count > Min_size       then
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
                result := (other /= void  and then count = other.count)
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

feature { PRIORITY_QUEUE }

    Min_size : INTEGER is 16
    store    : ARRAY [G]

-----------------------------------------------------------

feature { NONE }

    bu_heapify is
                -- bottom up heap sort
        local
            k    : INTEGER
            x, y : G
        do
            from            -- descend
                k := 1
            until
                2 * k > count
            loop
                if 2 * k + 1 <= count                      and then 
                   store.item (2 * k) < store.item (2 * k + 1) then
                    k := 2 * k + 1
                else
                    k := 2 * k
                end
            end

            from            -- ascend again
                x := store.item (1)
            until
                store.item (k) >= x
            loop
                k := k // 2
            end

            from
                -- empty statement
            until
                k < 1
            loop
                y := store.item (k)
                store.put (x, k)
                x := y
                k := k // 2
            end
        end
-----------------------------------------------------------

    expand is

        do
            store.resize (1, 2 * store.count)
        end
-----------------------------------------------------------

    shrink is

        do
            store.resize (1, store.count // 2)
        end
-----------------------------------------------------------

end -- class PRIORITY_QUEUE

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
