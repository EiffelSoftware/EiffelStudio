indexing

description: "As the name suggests these tables keep their keys%
             % in sorted order. They are implemented using Red-%
             %Black trees.";
keywods: "table", "key", "sorting"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"              
  
class   SORTED_TABLE [G, K -> COMPARABLE]
                        -- implementation with red-black trees

inherit

    TWOWAY_TRAVERSABLE
        undefine
            iterator, is_equal, copy
        end;
    ES_TABLE [G, K]
        undefine
            iterator
        redefine
            is_equal, copy, 
            make, search, iterator, 
            first,  next,
            inside
    end

creation
    make

feature  -- Initialization

    make (u : BOOLEAN) is
        -- See the version in TABLE.

        local
            i : INTEGER

        do
            is_unique := u
            found     := false
            count     := 0
            root      := 0
            free      := 1
 
            create keys.make (0, Min_size)
            create items.make (0, Min_size)
            create color.make (0, Min_size)
            create parent.make (0, Min_size)
            create left.make (0, Min_size)
            create right.make (0, Min_size)

            color.put (black, 0)        -- NIL sentinel

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
-----------------------------------------------------------
feature -- Traversal
 
    iterator : TWOWAY_ITERATOR is
        -- See the version in TRAVERSABLE.

        do
            create {TWOWAY_INTEGER_ITERATOR} result.make (current)
            init_first (result)
        end
-----------------------------------------------------------
  
    iter_after (k : K) : TWOWAY_ITERATOR is 
        -- See the version in TWOWAY_TRAVERSABLE.
 
        do 
            create {TWOWAY_INTEGER_ITERATOR} result.make (current) 
            init_after (k, result)
        end 
------------------------------------------------------------------------- 
  
    iter_before (k : K) : TWOWAY_ITERATOR is 
        -- See the version in TWOWAY_TRAVERSABLE.
 
        do 
            create {TWOWAY_INTEGER_ITERATOR} result.make (current) 
            init_before (k, result)
        end 
-----------------------------------------------------------

    item (it : ITERATOR) : G is
        -- See the version in TABLE.

        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit    ?= it
            result := items.item (iit.cursor)
        end
-----------------------------------------------------------

    key (it : ITERATOR) : K is
        -- See the version in TABLE.

        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit    ?= it
            result := keys.item (iit.cursor)
        end
-----------------------------------------------------------

    inside (it : ITERATOR) : BOOLEAN is
        -- See the version in TRAVERSABLE.

        local
            iit : TWOWAY_INTEGER_ITERATOR
 
        do
            iit    ?= it
            result := (iit.cursor /= 0)
        end
-----------------------------------------------------------
feature -- Searching
 
    search (k : K) is
        -- See the version in TABLE.

        local
            where : INTEGER

        do
            where := look_for (k)

            if where = 0 then
                found := false
            else
                found      := true
                found_item := items.item (where)
                found_key  := keys.item (where)
            end

        ensure then 
            found implies
                found_key <= k and then found_key >= k
        end
-----------------------------------------------------------
feature -- Mutation

    add (y : G; k : K) is
        -- See the version in TABLE.

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
                cmp := compare (k, keys.item (x))

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
                insert (p, y, k)
            end
        end
-----------------------------------------------------------

    replace (y : G; k : K) is
        -- See the version in TABLE.

        local
            x, p : INTEGER
            cmp  : INTEGER

        do
            from
                x   := root
                cmp := 1
            until
                cmp = 0 or else x = 0
            loop
                cmp := compare (k, keys.item (x))

                p := x

                if cmp < 0 then
                    x := left.item (x)
                elseif cmp > 0 then
                    x := right.item (x)
                end
            end

            if x /= 0 then      -- key k is already there
                items.put (y, x)

            else                -- y is really to be added
                insert (p, y, k)
            end
        end
-----------------------------------------------------------

    remove (k : K) is
        -- See the version in TABLE.

        local
            x, y, z, p : INTEGER

        do
            z := look_for (k)

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
                    keys.put (keys.item (y), z)
                end

                if color.item (y) = black then
                    fixup (x)
                end
  
                count := count - 1   
                free_node (y)   
            end
        end
-----------------------------------------------------------
feature -- Comparison

    is_equal (other : like current) : BOOLEAN is
        -- This `is_equal' is somewhere between standard_is_equal and
        -- deep_is_equal. It returns true precisely if `current' and
        -- `other' contain _the same_ references.

        local
            i1, i2 : ITERATOR 

        do
            if other /= void then
                from
                    i1 := iterator
                    i2 := other.iterator
                until
                    i1.finished                      or else
                    i2.finished                      or else
                    not key (i1).is_equal (key (i2)) or else
                    item (i1) /= item (i2)
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
            keys   := clone (other.keys)
            items  := clone (other.items)
            color  := clone (other.color)
            parent := clone (other.parent)
            left   := clone (other.left)
            right  := clone (other.right)
        end
-----------------------------------------------------------

feature { SORTED_TABLE }

    red      : CHARACTER is 'r'
    black    : CHARACTER is 'b'
    Min_size : INTEGER is 16

    keys     : ARRAY [K]
    items    : ARRAY [G]
    color    : ARRAY [CHARACTER]
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

            iit.set_cursor (p) 
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

            iit.set_cursor (p)
        end
-----------------------------------------------------------

    next (it : ITERATOR) is

        local
            iit : TWOWAY_INTEGER_ITERATOR

        do
            iit ?= it
            iit.set_cursor (successor (iit.cursor))
        end
-----------------------------------------------------------

    previous (it : ITERATOR) is

        local
            iit  : TWOWAY_INTEGER_ITERATOR

        do
            iit ?= it
            iit.set_cursor (predecessor (iit.cursor))
        end
-----------------------------------------------------------

feature { NONE }

    init_before (k : K; it : TWOWAY_ITERATOR) is

        do
            last_before (k, it)

            if inside (it) then
                it.initialize
            else
                it.terminate
            end
        end
-----------------------------------------------------------

    init_after (k : K; it : TWOWAY_ITERATOR) is

        do
            first_after (k, it)

            if inside (it) then
                it.initialize
            else
                it.terminate
            end
        end
-----------------------------------------------------------

    compare (x, y : K) : INTEGER is

        do
            if x < y then
                result := -1
            elseif y < x then
                result := 1
            end
        end
-----------------------------------------------------------

    make_node (k : K; x : G) : INTEGER is

        do
            if count = parent.count - 1 then
                expand
            end

            result := free
            free   := parent.item (free)
            keys.put (k, result)
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

            if count <= parent.count / 4   and then
               parent.count > Min_size + 1     then
                shrink
            end
        end
-----------------------------------------------------------

    look_for (k : K) : INTEGER is

        local
            cmp  : INTEGER 
            done : BOOLEAN

        do
            from
                result := root
            until
                done or else result = 0 
            loop
                cmp := compare (k, keys.item (result))

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

    insert (par : INTEGER; y : G; k : K) is
                -- add new node with parent p, key k, item y

        local
            x, p, u, g : INTEGER

        do
            p := par
            x := make_node (k, y)
            parent.put (p, x)
            color.put (red, x)

            if p = 0 then
                root := x
            elseif k < keys.item (p) then
                left.put (x, p)
            else
                right.put (x, p)
            end

            count := count + 1 

            from
                -- empty statement
            until
                x = root or else color.item (parent.item (x)) = black
            loop
                p := parent.item (x)        -- father of x
                g := parent.item (p)        -- grandfather of x

                if p = left.item (g) then
                    u := right.item (g) -- uncle of x

                    if u /= 0 and then color.item (u) = red then
                        color.put (black, p)
                        color.put (black, u)
                        color.put (red, g)
                        x := g
                    else
                        if x = right.item (p) then
                            x := p
                            left_rotate (x)
                            p := parent.item (x)
                            g := parent.item (p) 
                        end

                        color.put (black, p)
                        color.put (red, g)
                        right_rotate (g)
                    end
                else
                    u := left.item (g)      -- uncle of x

                    if u /= 0 and then color.item (u) = red then
                        color.put (black, p)
                        color.put (black, u)
                        color.put (red, g)
                        x := g
                    else
                        if x = left.item (p) then
                            x := p
                            right_rotate (x)
                            p := parent.item (x)
                            g := parent.item (p) 
                        end

                        color.put (black, p)
                        color.put (red, g)
                        left_rotate (g)
                    end
                end
            end

            color.put (black, root)
        end
-----------------------------------------------------------

    first_after (k : K; it : TWOWAY_ITERATOR) is

        local
            pos  : INTEGER
            cmp  : INTEGER
            done : BOOLEAN
            iit  : TWOWAY_INTEGER_ITERATOR

        do
            iit ?= it

            from
                pos := root
            until
                done or else pos = 0 
            loop
                cmp := compare (k, keys.item (pos))

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
                pos /= 0 implies keys.item (pos) >= k
                -- keys.item (pos) is smallest such element
            end

            iit.set_cursor (pos)
        end
-----------------------------------------------------------

    last_before (k : K; it : TWOWAY_ITERATOR) is

        local
            pos  : INTEGER
            cmp  : INTEGER
            done : BOOLEAN
            iit  : TWOWAY_INTEGER_ITERATOR

        do
            from
                pos := root
            until
                done or else pos = 0 
            loop
                cmp := compare (k, keys.item (pos))

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
                pos /= 0 implies keys.item (pos) <= k
                -- keys.item (pos) is largest such element
            end

            iit ?= it
            iit.set_cursor (pos)
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

    left_rotate (x : INTEGER) is

        local
            y, z : INTEGER

        do
            y := right.item (x)
            z := left.item (y)
            right.put (z, x)

            if z /= 0 then
                parent.put (x, z)
            end

            z := parent.item (x)
            parent.put (z, y)

            if z = 0 then
                root := y
            elseif x = left.item (z) then
                left.put (y, z)
            else
                right.put (y, z)
            end

            left.put (x, y)
            parent.put (y, x)
        end
-----------------------------------------------------------

    right_rotate (x : INTEGER) is

        local
            y, z : INTEGER

        do
            y := left.item (x)
            z := right.item (y)
            left.put (z, x)

            if z /= 0 then
                parent.put (x, z)
            end

            z := parent.item (x)
            parent.put (z, y)

            if z = 0 then
                root := y
            elseif x = right.item (z) then
                right.put (y, z)
            else
                left.put (y, z)
            end

            right.put (x, y)
            parent.put (y, x)
        end
-----------------------------------------------------------

    fixup (y : INTEGER) is

        local
            x, w, z : INTEGER

        do
            from
                x := y
            until
                x = root or else color.item (x) = red
            loop
                z := parent.item (x)

                if x = left.item (z) then
                    w := right.item (z)

                    if color.item (w) = red then
                        color.put (black, w)
                        color.put (red, z)
                        left_rotate (z)
                        w := right.item (z)
                    end

                    if color.item (left.item (w)) = black and then
                       color.item (right.item (w)) = black    then
                        color.put (red, w)
                        x := z
                    else
                        if color.item (right.item (w)) = black then
                            color.put (black, left.item (w))
                            color.put (red, w)
                            right_rotate (w)
                            w := right.item (z)
                        end

                        color.put (color.item (z), w)
                        color.put (black, z)
                        color.put (black, right.item (w))

                        left_rotate (z)
                        x := root
                    end
                else
                    w := left.item (z)

                    if color.item (w) = red then
                        color.put (black, w)
                        color.put (red, z)
                        right_rotate (z)
                        w := left.item (z)
                    end

                    if color.item (left.item (w)) = black and then
                       color.item (right.item (w)) = black    then
                        color.put (red, w)
                        x := z
                    else
                        if color.item (left.item (w)) = black then
                            color.put (black, right.item (w))
                            color.put (red, w)
                            left_rotate (w)
                            w := left.item (z)
                        end

                        color.put (color.item (z), w)
                        color.put (black, z)
                        color.put (black, left.item (w))
 
                        right_rotate (z)
                        x := root
                    end
                end
            end

            color.put (black, x)
        end
-----------------------------------------------------------

    expand is

        local
            i, old_size : INTEGER

        do
            old_size := items.count - 1

            keys.resize (0, 2 * old_size)
            items.resize (0, 2 * old_size)
            color.resize (0, 2 * old_size)
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
            ke       : ARRAY [K]
            it       : ARRAY [G]
            co       : ARRAY [CHARACTER]
            pa       : ARRAY [INTEGER]
            le       : ARRAY [INTEGER]
            ri       : ARRAY [INTEGER]

        do
            new_size := parent.count // 2

            create ke.make (0, new_size)
            create it.make (0, new_size)
            create co.make (0, new_size)
            create pa.make (0, new_size)
            create le.make (0, new_size)
            create ri.make (0, new_size)

            co.put (black, 0)

            from
                free := 1 
                i    := 1
                j    := root
                ke.put (keys.item (j), free)
                it.put (items.item (j), free)
                co.put (color.item (j), free)
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
                    ke.put (keys.item (j), free)
                    it.put (items.item (j), free)
                    co.put (color.item (j), free)
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
                    ke.put (keys.item (j), free)
                    it.put (items.item (j), free)
                    co.put (color.item (j), free)
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

            keys   := ke
            items  := it
            color  := co
            parent := pa
            left   := le
            right  := ri
            root   := 1
        end
-----------------------------------------------------------

end -- class SORTED_TABLE

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
