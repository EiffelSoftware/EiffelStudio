indexing

description: "These are essentially nothing but dynamic arrays.";
keywords: "dynamic", "array"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class   INDEXED_LIST [G]

inherit

    ES_COLLECTION [G]
        export { INDEXED_LIST }
            is_unique
        redefine
            is_equal, copy, 
            make, search, add, remove,
            first, next, inside, item, iterator
    end

creation 
    make, make_from_array
 
feature  -- Initialization

    make (u : BOOLEAN) is

        do
            is_unique := u
            delta     := Default_delta
            begin     := low_index
            finish    := 0
            count     := 0
            found     := false
        end
-------------------------------------------------------------------------

    make_from_array (a : ARRAY [G]) is

        local
            i, n : INTEGER

        do
           make (false)
           if a.lower = 1 then
               store := clone (a)
           else
               from
                   i := a.lower
                   n := a.upper
               until
                   i > n
               loop
                   append (a.item (i))
                   i := i + 1
               end
           end
        end
-------------------------------------------------------------------------
feature -- Searching

    index : INTEGER -- set by search
        -- valid only if found = true ...

    search (x : G) is

        local
            s : ARRAY [G]        -- for optimization

        do
            from
                index := begin
                s     := store
            until
                index > finish or else equal (x, s.item (index))
            loop
                index := index + 1
            end

            found := (index <= finish)

            if found then
                found_item := s.item (index)
            end
        ensure then
            right_element : found implies x.is_equal (at (index))
        end
-------------------------------------------------------------------------
feature -- Mutation

    append (x : G) is

        local
            already : BOOLEAN
            old_fnd : BOOLEAN

        do
            if is_unique and then store /= void then
                old_fnd := found
                search (x)
                already := found
                found   := old_fnd
            end

            if not already then
                if store = void or else finish = store.upper then
                    expand_up
                end

                count  := count + 1  
                finish := finish + 1
                store.put (x, finish)
            end
        end
-------------------------------------------------------------------------

    prepend (x : G) is

        local
            already : BOOLEAN
            old_fnd : BOOLEAN

        do
            if is_unique and then store /= void then
                old_fnd := found
                search (x)
                already := found
                found   := old_fnd
            end

            if not already then
                if store = void or else begin = store.lower then
                    expand_down
                end

                count := count + 1  
                begin := begin - 1
                store.put (x, begin)
            end
        end
-------------------------------------------------------------------------

    add (x : G) is

        do
            append (x)
        end
-------------------------------------------------------------------------

    insert (x : G; indx : INTEGER) is
        -- Insert `x' _after_ position `indx'.
        -- insert (x, high_index) is the same as append (x).


        require
            valid_index : low_index - 1 <= indx and then
                          indx <= high_index

        local
            already : BOOLEAN
            old_fnd : BOOLEAN
            i       : INTEGER
            s       : ARRAY[G]
            z       : G

        do
            if is_unique and then store /= void then
                old_fnd := found
                search (x)
                already := found
                found   := old_fnd
            end

            if not already then
                if store = void or else finish = store.upper then
                    expand_up
                end

                from
                    finish := finish + 1
                    i      := finish
                    s      := store
                until
                    i = indx + 1
                loop
                    s.put (s.item (i - 1), i)
                    i := i - 1
                end

                s.put (x, i)
                count := count + 1
            end
        end
-------------------------------------------------------------------------

    remove (x : G) is

        local
            i, j : INTEGER
            s    : ARRAY [G]       -- for optimization

        do
            s := store 

            from
                i := begin
            until
                i > finish or else x.is_equal (s.item (i))
            loop
                i := i + 1
            end

            if i <= finish then
                from
                    j := i
                until
                    j >= finish
                loop
                    s.put (s.item (j + 1), j)
                    j := j + 1
                end

                count  := count - 1
                finish := finish - 1

                if finish < (store.upper - delta) and then
                   store.count > delta                then
                    shrink_top
                end
            end
        end
-------------------------------------------------------------------------

    remove_at (idx : INTEGER) is
        -- remove element at position idx

        require
            valid_index : valid_index (idx)

        local
            i : INTEGER

        do
            from
                i := begin + idx - 1
            until
                i >= finish or else i >= store.upper
            loop
                store.put (store.item (i + 1), i)
                i := i + 1
            end

            count  := count - 1
            finish := finish - 1

            if finish < (store.upper - delta) and then
                store.count > delta                then
                shrink_top
            end
        end
-------------------------------------------------------------------------

    replace (x : G; idx : INTEGER) is
        -- Replace whatever is at position `idx' by `x'. 
        -- idx may be > high_index; in this case the list is
        -- extended appropriately.

        require
            valid_index : low_index <= idx

        do
            if store = void then
                expand_up
            end

            store.force (x, begin + idx - 1)
            if finish < begin + idx - 1 then
                finish := begin + idx - 1
                count  := finish - begin + 1
            end
        end
-------------------------------------------------------------------------
feature -- Limits

    low_index : INTEGER is 1
        -- The smallest acceptable index.

    high_index : INTEGER is
        -- The highest acceptable index (except for replace).

        do
            result := finish
        end
-------------------------------------------------------------------------
feature -- Size control

    set_increment (inc : INTEGER) is
        -- Set the amount by which the list grows or shrinks
        -- when it needs to expand or shrink.

        do
            delta := inc
        end
-------------------------------------------------------------------------
feature -- Access

    at (idx : INTEGER) : G is

        require
            valid_index : valid_index (idx)

        do
            result := store.item (begin + idx - 1)
        end
-------------------------------------------------------------------------

    valid_index (idx : INTEGER) : BOOLEAN is

        do
            result := (low_index <= idx and then idx <= high_index)
        end
-------------------------------------------------------------------------
feature -- Traversal

    iterator : ITERATOR is

        do
            create {INTEGER_ITERATOR} result.make (current)
            init_first (result)
        end
-------------------------------------------------------------------------

    item (it : ITERATOR) : G is

        local
            iit : INTEGER_ITERATOR

        do
            iit    ?= it
            result := store.item (begin + iit.cursor - 1)
        end
-------------------------------------------------------------------------

    inside (it : ITERATOR) : BOOLEAN is

        local
            iit : INTEGER_ITERATOR

        do
            iit    ?= it
            result := (iit.cursor /= 0)
        end 
-------------------------------------------------------------------------
feature -- Comparison

    is_equal (other : like current) : BOOLEAN is

        local
            i, j : INTEGER

        do
            from
                result := (other /= void and then count = other.count)
                i := begin
                j := other.begin
            until
                not result or else i > finish
            loop
                result := store.item (i).is_equal (other.store.item (j)) 
                i := i + 1
                j := j + 1
            end
        end
-------------------------------------------------------------------------
feature -- Copying

    copy (other : like current) is

        do
            is_unique := other.is_unique
            delta     := Default_delta
            begin     := other.begin
            finish    := other.finish
            count     := other.count
            found     := other.found

            if store = void then
                 store := clone (other.store)
            else
                store.copy (other.store) 
            end
        end
-------------------------------------------------------------------------

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
-------------------------------------------------------------------------

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
-------------------------------------------------------------------------

feature { INDEXED_LIST }

    Default_delta : INTEGER is 4 
 
    delta  : INTEGER 
    begin  : INTEGER
    finish : INTEGER
    store  : ARRAY [G]
 
---------------------------------------------------------------------  
 
    expand_up is

        do
            if store = void then
                create store.make (1, delta)
                begin := 1
            else
                store.resize (store.lower, store.upper + delta)
            end
        end
---------------------------------------------------------------------  
 
    expand_down is

        local
            i : INTEGER

        do
            if store = void then
                create store.make (1, 2 * delta)
                begin  := delta
                finish := delta - 1
            else
                if finish + delta > store.upper then
                    store.resize (store.lower, store.upper + delta) 
                end

                from
                    i := begin
                until
                    i > finish
                loop
                    store.put (store.item (i), i + delta)
                    i := i + 1
                end

                begin  := begin + delta
                finish := finish + delta
            end
        end
-------------------------------------------------------------------------

    shrink_top is

        require
            still_fits : finish + delta <= store.upper

        do
            store.resize (store.lower, store.upper - delta)
        end
-------------------------------------------------------------------------

invariant
    consistent : count = finish - begin + 1

end -- class INDEXED_LIST

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

