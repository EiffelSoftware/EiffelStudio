indexing

description: "A special kind of priority queue supporting the feature %
             %`raise_priority' in an efficient manner; these are needed %
             %by various shortest path algorithms.";
keywords: "priority queue", "raise priority", "shortest paths"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   PRIORTQ [G, K -> COMPARABLE]
        -- special priority queue implementing `raise_priority'.
                                
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

    count : INTEGER

    empty : BOOLEAN is

        do
            result := (count = 0)
        end
-----------------------------------------------------------
feature -- Access

    item : Q_ELEMENT [G, K] is

        require
            not empty

        do
            result := store.item (1)
        end
-----------------------------------------------------------

feature -- Mutation

    add (x : Q_ELEMENT [G, K]) is

        local
            i : INTEGER

        do
            if count > store.count then
                expand
            end

            count := count + 1

            from
                i := count
            until
                i = 1 or else x.priority <= store.item (i // 2).priority 
            loop
                store.put (store.item (i // 2), i)
                store.item (i).set_index (i)
                i := i // 2
            end

            store.put (x, i)
            x.set_index (i)
            x.set_queue (current)
        end
-----------------------------------------------------------

    remove is

        require
            not empty

        do
            store.item (1).set_queue (void)

            store.put (store.item (count), 1)
            store.item (1).set_index (1)
            count := count - 1

            heapify

            if count < (store.count - 1) // 4 and then 
               store.count > Min_size + 1         then
                shrink
            end
        end
-----------------------------------------------------------

    raise_priority (x : Q_ELEMENT [G, K]) is
        -- Move `x' to it's new position; presumably `x' has been given a new priority
        -- prior to a call to this routine. As the name suggests the new priority
        -- should be higher than the old one so that `x' moves forward in the queue.

        require
            is_here       : x.is_in_queue (current)
            good_element  : 1 <= x.index and then x.index <= count

        local
            i : INTEGER
            p : K

        do
            p := x.priority

            from
                i := x.index
            until
                i = 1 or else p <= store.item (i // 2).priority 
            loop
                store.put(store.item (i // 2), i)
                store.item (i).set_index (i)
                i := i // 2
            end

            store.put (x, i)
            x.set_index(i)
        end
-----------------------------------------------------------

feature { NONE }

    Min_size : INTEGER is 16
    store    : ARRAY [Q_ELEMENT [G, K]]

-----------------------------------------------------------

    heapify is

        local
            x    : Q_ELEMENT [G, K]
            i, j : INTEGER
            done : BOOLEAN

        do
            from
                x := store.item (1)
                i := 1
                j := 2 
            until
                done or else j > count
            loop
                if j < count and then 
                   store.item (j + 1).priority > store.item (j).priority then
                    j := j + 1
                end

                if store.item (j).priority > store.item (i).priority then
                    store.put (store.item (j), i)
                    store.item (i).set_index (i)
                    i := j 
                    j := 2 * j 
                else
                    done := true
                end
            end             

            store.put (x, i)
            x.set_index (i)
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

end -- class PRIORTQ

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
