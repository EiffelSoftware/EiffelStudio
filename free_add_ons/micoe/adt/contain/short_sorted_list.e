indexing

description: "This cousin of the class SORTED_LIST makes a more%
             % economic use of spce at the cost of reduced speed;%
             % use it when your lists only have a few dozen elements.";
keywords: "list", "space saving", "sorting"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   SHORT_SORTED_LIST [G -> COMPARABLE]

inherit

    SORTED_COLLECTION [G]
        redefine
            is_equal, copy, 
            make, search, add, remove,
            first, last, next,
            previous, inside, item,
            iterator, iter_after, iter_before,
            first_after, last_before 
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
------------------------------------------------------------------------- 
feature -- Traversal
  
    iterator : TWOWAY_ITERATOR is 
 
        do 
            create {TWOWAY_INTEGER_ITERATOR} result.make (current) 
            init_first (result)
        end 
-----------------------------------------------------------
  
    iter_after (x : G) : TWOWAY_INTEGER_ITERATOR is 
 
        do 
            create result.make (current) 
            init_after (x, result)
        end 
------------------------------------------------------------------------- 
  
    iter_before (x : G) : TWOWAY_INTEGER_ITERATOR is 
 
        do 
            create result.make (current) 
            init_before (x, result)
        end 
-----------------------------------------------------------

    item (it : ITERATOR) : G is

        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit    ?= it
            result := items.item (iit.cursor)
        end
-----------------------------------------------------------

    inside (it : ITERATOR) : BOOLEAN is

        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit    ?= it
            result := (iit.cursor /= 0)
        end
-----------------------------------------------------------
feature -- Searching

    search (x : G) is

        local
            where : INTEGER

        do
            where := bsearch (x)

            found := (where <= count and then x >= items.item (where))

            if found then
                found_item := items.item (where)
            end
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G) is

        local
            i, where : INTEGER

        do
            where := bsearch (x)

            if not is_unique       or else
               where > count       or else
               x < items.item (where) then

                if items = void or else count = items.count then
                    expand
                end

                count := count + 1  

                if where = count then
                    items.put (x, where)
                else
                    from
                        i := where
                    until
                        i >= count
                    loop
                        items.put (items.item (i), i + 1)
                        i := i + 1
                    end

                    items.put (x, where)
                end
            end
        end
-----------------------------------------------------------

    remove (x : G) is

        local
            i : INTEGER
            s : ARRAY [G]       -- for optimization

        do
            s := items 

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
                    s.put (s.item (i + 1), i)
                    i := i + 1
                end

                count := count - 1

                if count < (items.count - delta) and then
                   items.count > delta               then
                    shrink
                end
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
                i := 1
            until
                not result or else i > count
            loop
                result := items.item (i).is_equal (other.items.item (i)) 
                i := i + 1
            end
        end
-----------------------------------------------------------
feature -- Copying

    copy (other : like current) is

        do
            standard_copy (other)
            items := clone (other.items)
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
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit ?= it

            if count = 0 then
                iit.set_cursor (0)
            else
                iit.set_cursor (1)
            end
        end
-----------------------------------------------------------

    last (it : ITERATOR) is

        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit ?= it

            if count = 0 then
                iit.set_cursor (0)
            else
                iit.set_cursor (count)
            end
        end
-----------------------------------------------------------

    next (it : ITERATOR) is

        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit ?= it

            if iit.cursor >= count then
                iit.set_cursor (0)
            else
                iit.set_cursor (iit.cursor + 1)
            end
        end
-----------------------------------------------------------

    previous (it : ITERATOR) is

        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit ?= it 
            iit.set_cursor (iit.cursor - 1)
        end
-----------------------------------------------------------

feature { SHORT_SORTED_LIST }

    items : ARRAY [G] 

-----------------------------------------------------------

feature { NONE }

    Default_delta : INTEGER is 4 
 
    delta : INTEGER 
 
-----------------------------------------------------------

    first_after (x : G; it : TWOWAY_INTEGER_ITERATOR) is

        local
            pos : INTEGER

        do
            pos := bsearch (x)

            if pos > count then
                it.set_cursor (0)
            else
                it.set_cursor (pos)
            end         
        end
-----------------------------------------------------------

    last_before (x : G; it : TWOWAY_INTEGER_ITERATOR) is

        local
            pos : INTEGER

        do
            from
                pos := bsearch (x)

                if pos > count then
                    pos := count
                end
            until
                pos < 1 or else x >= items.item (pos)
            loop
                pos := pos - 1
            end

            it.set_cursor (pos)
        end
-----------------------------------------------------------
 
    expand is

        do
            if items = void then
                create items.make (1, delta)
            else
                items.resize (1, items.count + delta)
            end
        end
-----------------------------------------------------------

    shrink is

        require
            count + delta <= items.count

        do
            items.resize (1, items.count - delta)
        end
-----------------------------------------------------------

    bsearch (x : G) : INTEGER is

        local
            low, mid, high : INTEGER
            s              : ARRAY [G]

        do
            from
                s    := items 
                low  := 0
                high := count + 1
            invariant
                0 <= low and then low < high and then high <= count + 1
                low = 0          or else s.item (low) <   x
                high = count + 1 or else s.item (high) >= x
            variant
                high - low
            until
                low = high - 1
            loop
                mid := (low + high) // 2

                if s.item (mid) < x then
                    low := mid
                else
                    high := mid
                end
            end

            result := high

        ensure
            result >= 1 and then result <= count + 1
            result <= count implies x <= items.item (result)
            result >  1     implies x >  items.item (result - 1)
        end

end -- class SHORT_SORTED_LIST

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
