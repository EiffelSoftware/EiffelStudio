indexing

description: "This class is very similar to its cousin PRIORITY_QUEUE%
             % except that the priority of an element is determined by%
             % a key that is stored with the element. The keys are%
             % subject to a total order.";
keywords: "priority", "queue", "key"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class   KEY_PRIORITY_QUEUE [G, K -> COMPARABLE]

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
            create keys.make (1, Min_size)
            create store.make (1, Min_size)
            count := 0
        end
-----------------------------------------------------------
feature -- Status

    count : INTEGER  -- The number of (key, item) pairs in the queue.

    empty : BOOLEAN is
          -- This is a convenience function.

        do
            result := (count = 0)

        ensure
            right_answer: result = (count = 0)
        end
-----------------------------------------------------------
feature -- Access

    item : G is
          -- The element at the front of the queue.
          -- No other element in the queue has a higher priority.

        require
            not_empty : not empty

        do
            result := store.item (1)
        end
-----------------------------------------------------------

    key : K is
        -- The key at the front of the queue. No other key
        -- in the queue is larger.

        require
            not_empty : not empty

        do
            result := keys.item (1)
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G; k : K) is
          -- Insert the pair `x', `k' at the appropriate
          -- position in the queue (determined by `k').

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
                i = 1 or else k <= keys.item (i // 2)
            loop
                keys.put (keys.item (i // 2), i)
                store.put (store.item (i // 2), i)
                i := i // 2
            end

            keys.put (k, i)
            store.put (x, i)
        end
-----------------------------------------------------------

    remove is
          -- Remove the pair at the front of the queue.

        require
            not_empty : not empty

        do
            keys.put (keys.item (count), 1)
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
                result := (other /= void and then count = other.count)
                i      := 1
            until
                not result or else i > count
            loop
                if keys.item (i)  /= other.keys.item (i)  or else
                   store.item (i) /= other.store.item (i) then
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
            keys  := clone (other.keys)
            store := clone (other.store)
        end
-----------------------------------------------------------

feature { KEY_PRIORITY_QUEUE }

    Min_size : INTEGER is 16
    keys     : ARRAY [K]
    store    : ARRAY [G]

-----------------------------------------------------------

feature { NONE }

    bu_heapify is
                -- bottom up heap sort
        local
            i    : INTEGER
            k, l : K
            x, y : G
        do
            from            -- descend
                i := 1
            until
                2 * i > count
            loop
                if 2 * i + 1 <= count                    and then 
                   keys.item (2 * i) < keys.item (2 * i + 1) then
                    i := 2 * i + 1
                else
                    i := 2 * i
                end
            end

            from            -- ascend again
                k := keys.item (1)
            until
                keys.item (i) >= k
            loop
                i := i // 2
            end

            from
                x := store.item (1)
            until
                i < 1
            loop
                y := store.item (i)
                l := keys.item (i)
                store.put (x, i)
                keys.put (k, i)
                x := y
                k := l
                i := i // 2
            end
        end
-----------------------------------------------------------

    expand is

        do
            keys.resize (1, 2 * keys.count)
            store.resize (1, 2 * store.count)
        end
-----------------------------------------------------------

    shrink is
        do
            keys.resize (1, keys.count // 2)
            store.resize (1, store.count // 2)
        end
-----------------------------------------------------------

end -- class KEY_PRIORITY_QUEUE

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
