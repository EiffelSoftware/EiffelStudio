indexing

description: "As the name suggests sorted lists maintain their%
             % elements in sorted order. Here the structure is%
             % implemented with a Red-Black tree.";
keywords: "list", "sorting"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   SORTED_LIST [G -> COMPARABLE]
            -- These lists are implemented as binary trees;
            -- no effort is made to keep them balanced, since
            -- it often doesn't pay off. If the tree happens
            -- to degenerate (a relatively unlikely occurrence)
            -- the tree will display worst case behavior.

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

    make (u : BOOLEAN) is
        -- See the version in COLLECTION.
 
        local
            i : INTEGER

        do
            is_unique := u
            found     := false
            count     := 0
            root      := 0
            free      := 1 

            create items.make (0, Min_size)
            create parent.make (0, Min_size)
            create left.make (0, Min_size)
            create right.make (0, Min_size)

            from
                i := 1
            until
                i = Min_size
            loop
                parent.put (i + 1, i)
                i := i + 1
            end

            parent.put (0, i)
        end
------------------------------------------------------------------------- 
feature -- Traversal
  
    iterator : TWOWAY_ITERATOR is 
        -- See the version in TRAVERSABLE.
 
        do 
            create {TWOWAY_INTEGER_ITERATOR} result.make (current) 
            init_first (result)
        end 
-----------------------------------------------------------
  
    iter_after (x : G) : TWOWAY_ITERATOR is 
        -- See the version in SORTED_COLLECTION.
 
        do 
            create {TWOWAY_INTEGER_ITERATOR} result.make (current) 
            init_after (x, result)
        end 
------------------------------------------------------------------------- 
  
    iter_before (x : G) : TWOWAY_ITERATOR is 
        -- See the version in SORTED_COLLECTION.
 
        do 
            create {TWOWAY_INTEGER_ITERATOR} result.make (current) 
            init_before (x, result)
        end 
-----------------------------------------------------------

    item (it : ITERATOR) : G is
        -- See the version in COLLECTION.
     
        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit    ?= it
            result := items.item (iit.cursor)
        end
-----------------------------------------------------------

    inside (it : ITERATOR) : BOOLEAN is
        -- See the version in TRAVERSABLE.

        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit    ?= it
            result := (iit.cursor /= -1)
        end
-----------------------------------------------------------

feature -- Searching
   
    search (x : G) is
        -- See the version in COLLECTION.

        local
            where : INTEGER

        do
            where := look_for (x)

            if where = 0 then
                found := false
            else
                found      := true
                found_item := items.item (where)
            end

        ensure then 
            found implies
                found_item <= x and then found_item >= x
        end
-----------------------------------------------------------
feature -- Mutation

    add (y : G) is
        -- See the version in COLLECTION.

        local
            x, p : INTEGER
            cmp  : INTEGER
            done : BOOLEAN

        do
            from
                x := root
            until
                done or else x = 0
            loop
                cmp := compare (y, items.item (x))

                if is_unique and then cmp = 0 then
                    done := true
                else
                    p := x

                    if cmp < 0 then
                        x := left.item (x)
                    else
                        x := right.item (x)
                    end
                end
            end

            if x = 0 then       -- y is really to be added
                x := make_node (y)
                parent.put (p, x)

                if p = 0 then
                    root := x
                elseif y < items.item (p) then
                    left.put (x, p)
                else
                    right.put (x, p)
                end

                count := count + 1 
            end
        end
-----------------------------------------------------------

    remove (u : G) is
        -- See the version in COLLECTION.

        local
            x, y, z, p : INTEGER

        do
            z := look_for (u)

            if z /= 0 then
                if left.item (z) = 0 or else right.item (z) = 0 then
                    y := z
                else
                    y := successor (z)
                end

                -- now splice out y

                if left.item (y) /= 0 then
                    x := left.item (y)
                else
                    x := right.item (y)
                end

                p := parent.item (y)
                parent.put (p, x)

                if p = 0 then       -- y is the root
                    root := x
                elseif y = left.item (p) then
                    left.put (x, p)
                else
                    right.put (x, p)
                end

                if y /= z then              -- z has two children
                    items.put (items.item (y), z)
                end

                count := count - 1   
                free_node (y)   
            end
        end
-----------------------------------------------------------

    remove_all is
        -- Make `current' completely empty.

        do
            make (is_unique) -- Just reinitialize.
        end
-----------------------------------------------------------
feature -- Comparison

    is_equal (other : like current) : BOOLEAN is
        -- This `is_equal' is somewhere between standard_is_equal and
        -- deep_is_equal. It returns true precisely if `current' and
        -- `other' contain _the same_ references in the same order.

        local
            i1, i2 : ITERATOR 

        do
            if other /= void then
                from
                    i1 := iterator
                    i2 := other.iterator
                until
                    i1.finished or else i2.finished or else
                    not equal (item (i1), item (i2))
                loop
                    i1.forth
                    i2.forth
                end

                result := (i1.finished and then i2.finished)
            end

        rescue
            if i1 /= void then
                i1.stop
            end

            if i2 /= void then
                i2.stop
            end
        end
-----------------------------------------------------------
feature -- Copying

    copy (other : like current) is
        -- This `copy' is somewhere between standard_copy and deep copy.
        -- The resulting copy contains _the same_ references to items
        -- as the original, not references to copies of the items.

        do
            standard_copy (other)
            items  := clone (other.items)
            parent := clone (other.parent)
            left   := clone (other.left)
            right  := clone (other.right)
        end
-----------------------------------------------------------

feature { SORTED_LIST }

    Min_size : INTEGER is 16

    items    : ARRAY [G]
    parent   : ARRAY [INTEGER]
    left     : ARRAY [INTEGER]
    right    : ARRAY [INTEGER]
    root     : INTEGER 
    free     : INTEGER
 
-----------------------------------------------------------

feature { ITERATOR }

    first (it : ITERATOR) is

        local
            p   : INTEGER
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit ?= it

            if root /= 0 then
                from
                    p := root
                until
                    left.item (p) = 0
                loop
                    p := left.item (p)
                end
            end

            if p /= 0 then
                iit.set_cursor (p) 
            else
                iit.set_cursor (-1)
            end
        end
-----------------------------------------------------------
 
    last (it : ITERATOR) is

        local
            p   : INTEGER
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit ?= it

            if root /= 0 then
                from
                    p := root
                until
                    right.item (p) = 0 
                loop
                    p := right.item (p)
                end
            end

            if p /= 0 then
                iit.set_cursor (p)
            else
                iit.set_cursor (-1)
            end
        end
-----------------------------------------------------------

    next (it : ITERATOR) is

        local
            iit : TWOWAY_INTEGER_ITERATOR
            p   : INTEGER

        do
            iit ?= it
            p   := successor (iit.cursor)

            if p /= 0 then
                iit.set_cursor (p)
            else
                iit.set_cursor (-1)
            end
        end
-----------------------------------------------------------

    previous (it : ITERATOR) is

        local
            iit  : TWOWAY_INTEGER_ITERATOR
            p    : INTEGER

        do
            iit ?= it
            p   := predecessor (iit.cursor)

            if p /= 0 then
                iit.set_cursor (p)
            else
                iit.set_cursor (-1)
            end
        end
-----------------------------------------------------------

feature { NONE }

    compare (x, y : G) : INTEGER is

        do
            if x < y then
                result := -1
            elseif y < x then
                result := 1
            end
        end
-----------------------------------------------------------

    make_node (x : G) : INTEGER is

        do
            if count = parent.count - 1 then
                expand
            end

            result := free
            free   := parent.item (free)
            items.put (x, result)
            parent.put (0, result)
            left.put (0, result)
            right.put (0, result)
        end
-----------------------------------------------------------

    free_node (n : INTEGER) is

        do
            parent.put (free, n)
            free := n

            if count <= parent.count // 4   and then
               parent.count > Min_size + 1     then
                shrink
            end
        end
-----------------------------------------------------------

    look_for (x : G) : INTEGER is

        local
            cmp  : INTEGER
            done : BOOLEAN

        do
            from
                result := root
            until
                done or else result = 0 
            loop
                cmp := compare (x, items.item (result))

                if cmp = 0 then
                    done := true
                elseif cmp < 0 then
                    result := left.item (result)
                else
                    result := right.item (result)
                end
            end
        end
-----------------------------------------------------------

    first_after (x : G; it : TWOWAY_INTEGER_ITERATOR) is

        local
            pos  : INTEGER
            cmp  : INTEGER
            done : BOOLEAN

        do
            from
                pos := root
            until
                done or else pos = 0 
            loop
                cmp := compare (x, items.item (pos))

                if cmp = 0 then
                    done := true
                elseif cmp < 0 then
                    if left.item (pos) /= 0 then
                        pos := left.item (pos)
                    else
                        done := true
                    end
                else
                    if right.item (pos) /= 0 then
                        pos := right.item (pos)
                    else
                        pos  := successor (pos)
                        done := true
                    end
                end
            end

            check
                pos /= 0 implies items.item (pos) >= x
                -- items.item (pos) is smallest such element
            end
             
            if pos /= 0 then
                it.set_cursor (pos)
            else
                it.set_cursor (-1)
            end
        end
-----------------------------------------------------------

    last_before (x : G; it : TWOWAY_INTEGER_ITERATOR) is

        local
            pos  : INTEGER
            cmp  : INTEGER
            done : BOOLEAN

        do
            from
                pos := root
            until
                done or else pos = 0 
            loop
                cmp := compare (x, items.item (pos))

                if cmp = 0 then
                    done := true
                elseif cmp < 0 then
                    if left.item (pos) /= 0 then
                        pos := left.item (pos)
                    else
                        pos  := predecessor (pos)
                        done := true
                    end
                else
                    if right.item (pos) /= 0 then
                        pos := right.item (pos)
                    else
                        done := true
                    end
                end
            end

            check
                pos /= 0 implies items.item (pos) <= x
                -- items.item (pos) is largest such element
            end

            if pos /= 0 then
                it.set_cursor (pos)
            else
                it.set_cursor (-1)
            end
        end
-----------------------------------------------------------

    successor (n : INTEGER) : INTEGER is

        local
            x : INTEGER

        do
            x := n

            if right.item (x) /= 0 then
                from
                    result := right.item (x)
                until
                    left.item (result) = 0
                loop
                    result := left.item (result)
                end
            else
                from
                    result := parent.item (x)
                until
                    result = 0 or else x = left.item (result)
                loop
                    x      := result
                    result := parent.item (result)
                end
            end
        end
-----------------------------------------------------------

    predecessor (n : INTEGER) : INTEGER is

        local
            x : INTEGER

        do
            x := n

            if left.item (x) /= 0 then
                from
                    result := left.item (x)
                until
                    right.item (result) = 0
                loop
                    result := right.item (result)
                end
            else
                from
                    result := parent.item (x)
                until
                    result = 0 or else x = right.item (result)
                loop
                    x      := result
                    result := parent.item (result)
                end
            end
        end
-----------------------------------------------------------

    expand is

        local
            i, old_size : INTEGER

        do
            old_size := items.count - 1

            items.resize (0, 2 * old_size)
            parent.resize (0, 2 * old_size)
            left.resize (0, 2 * old_size)
            right.resize (0, 2 * old_size)

            from
                i := old_size + 1
            until
                i = 2 * old_size
            loop
                parent.put (i + 1, i)
                i := i + 1
            end

            parent.put (0, i)
            free := old_size + 1
        end
-----------------------------------------------------------

    shrink is

        local
            new_size : INTEGER
            i, j     : INTEGER
            it       : ARRAY [G]
            pa       : ARRAY [INTEGER]
            le       : ARRAY [INTEGER]
            ri       : ARRAY [INTEGER]

        do
            new_size := parent.count // 2

            create it.make (0, new_size)
            create pa.make (0, new_size)
            create le.make (0, new_size)
            create ri.make (0, new_size)


            from
                free := 1 
                i    := 1
                j    := root
                it.put (items.item (j), free)
                pa.put (parent.item (j), free)
                le.put (left.item (j), free)
                ri.put (right.item (j), free)

                parent.put (free, left.item (j))
                parent.put (free, right.item (j))

                free := free + 1
            until
                i = free
            loop
                j := le.item (i)

                if j /= 0 then
                    it.put (items.item (j), free)
                    pa.put (parent.item (j), free)
                    le.put (left.item (j), free)
                    ri.put (right.item (j), free)

                    parent.put (free, left.item (j))
                    parent.put (free, right.item (j))
   
                    le.put (free, i)
                    free := free + 1
                end

                j := ri.item (i)

                if j /= 0 then
                    it.put (items.item (j), free)
                    pa.put (parent.item (j), free)
                    le.put (left.item (j), free)
                    ri.put (right.item (j), free)

                    parent.put (free, left.item (j))
                    parent.put (free, right.item (j))

                    ri.put (free, i)
                    free := free + 1
                end

                i := i + 1
            end

            from
                i := free
            until
                i = new_size
            loop
                pa.put (i + 1, i)
                i := i + 1
            end

            items  := it
            parent := pa
            left   := le
            right  := ri
            root   := 1
        end

end -- class SORTED_LIST

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
