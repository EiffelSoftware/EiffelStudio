indexing

description: "This cousin of the class LIST uses less space%
             % at the cost of reduced speed. Use it if your%
             % lists only have a few dozen elements.";
keywords: "list", "space saving"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   SHORT_LIST [G]

inherit

    ES_COLLECTION [G]
        redefine
            is_equal, copy, 
            make, search, add, remove,
            first, next, inside, item, iterator
    end

creation 
    make 
 
feature -- Initialization

    make (only_once : BOOLEAN) is

        do
            is_unique := only_once
            delta     := Default_delta
            count     := 0
            found     := false
        end
-----------------------------------------------------------
feature -- Searching

    search (x : G) is

        local
            i : INTEGER
            s : ARRAY [G]        -- for optimization

        do
            from
                i := 1
                s := store
            until
                i > count or else x.is_equal (s.item (i))
            loop
                i := i + 1
            end

            found := (i <= count)

            if found then
                found_item := s.item (i)
            end
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G) is

        local
            already : BOOLEAN
            old_fnd : BOOLEAN

        do
            if is_unique then
                old_fnd := found
                search (x)
                already := found
                found   := old_fnd
            end

            if not already then
                if store = void or else count = store.count then
                    expand
                end

                count := count + 1  
                store.put (x, count)
            end
        end
-----------------------------------------------------------

    remove (x : G) is

        local
            i : INTEGER
            s : ARRAY [G]       -- for optimization

        do
            s := store 

            from
                i := 1
            until
                i > count or else x.is_equal (s.item (i))
            loop
                i := i + 1
            end

            if i <= count then
                from
                    -- nothing                    
                until
                    i >= count
                loop
                    store.put (store.item (i + 1), i)
                    i := i + 1
                end

                count := count - 1

                if count < (store.count - delta) and then
                   store.count > delta               then
                    shrink
                end
            end
        end
-----------------------------------------------------------
feature -- Traversal

    iterator : ITERATOR is

        do
            create {INTEGER_ITERATOR} result.make (current)
            init_first (result)
        end
-----------------------------------------------------------

    item (it : ITERATOR) : G is

        local
            iit : INTEGER_ITERATOR

        do
            iit    ?= it
            result := store.item (iit.cursor)
        end
-----------------------------------------------------------

    inside (it : ITERATOR) : BOOLEAN is

        local
            iit : INTEGER_ITERATOR

        do
            iit    ?= it
            result := (iit.cursor /= 0)
        end 
-----------------------------------------------------------
feature -- Comparison

    is_equal (other : like current) : BOOLEAN is

        local
            i : INTEGER

        do
            from
                result := (other /= void and then count = other.count)
                i := 1
            until
                not result or else i > count
            loop
                result := store.item (i).is_equal (other.store.item (i)) 
                i := i + 1
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
feature -- Size control

    set_increment (inc : INTEGER) is
        -- Set the amount by which the arrays grow or shrink
        -- when the list expands or shrinks.

        do
            delta := inc
        end
-----------------------------------------------------------

feature { ITERATOR }

    first (it : ITERATOR) is

        local
            iit : INTEGER_ITERATOR

        do
            iit ?= it

            if count = 0 then
                iit.set_cursor (0)
            else
                iit.set_cursor (1)
            end
        end
-----------------------------------------------------------

    next (it : ITERATOR) is

        local
            iit : INTEGER_ITERATOR

        do
            iit ?= it

            if iit.cursor >= count then
                iit.set_cursor (0)
            else
                iit.set_cursor (iit.cursor + 1)
            end
        end
-----------------------------------------------------------

feature { SHORT_LIST }

    store : ARRAY [G] 

-----------------------------------------------------------

feature { NONE }

    Default_delta : INTEGER is 4 
 
    delta : INTEGER 
 
-----------------------------------------------------------
 
    expand is

        do
            if store = void then
                create store.make (1, delta)
            else
                store.resize (1, store.count + delta)
            end
        end
-----------------------------------------------------------

    shrink is

        require
            count + delta <= store.count

        do
            store.resize (1, store.count - delta)
        end
-----------------------------------------------------------

end -- class SHORT_LIST

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
