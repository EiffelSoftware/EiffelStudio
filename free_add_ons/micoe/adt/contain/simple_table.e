indexing

description: "This a naive implementation of the table abstraction%
             % and is neither particularly fast nor especially%
             % efficient in its use of space.";
keywords: "table", "key"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   SIMPLE_TABLE [G, K]

inherit

    ES_TABLE [G, K]
        redefine
            is_equal, copy, 
            make, search, add, replace, remove,
            first, next, inside, item, iterator
    end

creation 
    make 
 
feature -- Initialization

    make (u : BOOLEAN) is
        -- See the version in TABLE.

        local
            i : INTEGER

        do
            is_unique := u
            count     := 0
            found     := false
            free      := 1 
            last_i    := 0
            used      := 0

            create chain.make (1, Min_size)
            create keys.make  (1, Min_size)
            create store.make (1, Min_size)

            from
                i := 1
            until
                i = store.count
            loop
                chain.put (i + 1, i)
                i := i + 1
            end

            chain.put (0, i)
        end
-----------------------------------------------------------
feature -- Searching

    search (ky : K) is
        -- See the version in TABLE.

        local
            index : INTEGER
            k     : ARRAY [K]        -- for optimization
            c     : ARRAY [INTEGER]  --  "        "

        do
            from
                index := used
                k     := keys
                c     := chain
            until
                index = 0 or else ky.is_equal (k.item (index))
            loop
                index := c.item (index)
            end

            if index = 0 then
                found := false
            else
                found      := true
                found_item := store.item (index)
                found_key  := keys.item (index)
            end

        ensure then 
            found implies ky.is_equal (found_key)
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G; k : K) is
        -- See the version in TABLE.

        local
            index   : INTEGER
            already : BOOLEAN
            old_fnd : BOOLEAN

        do
            if is_unique then
                old_fnd := found
                search (k)
                already := found
                found   := old_fnd
            end

            index := 0

            if not already then
                if count = store.count then
                    expand
                end

                index := free
                free  := chain.item (free)
                chain.put (0, index) 

                if last_i /= 0 then
                    chain.put (index, last_i)
                else
                    used := index
                end
 
                keys.put (k, index)
                store.put (x, index)
                last_i := index 
                count  := count + 1
            end
        end
-----------------------------------------------------------

    replace (x : G; ky : K) is
        -- See the version in TABLE.

        local
            index : INTEGER
            k     : ARRAY [K]        -- for optimization
            c     : ARRAY [INTEGER]  --  "        "

        do
            from
                index := used
                k     := keys
                c     := chain
            until
                index = 0 or else ky.is_equal (k.item (index))
            loop
                index := c.item (index)
            end

            if index = 0 then
                index := free
                free  := c.item (free)
                c.put (0, index) 

                if last_i /= 0 then
                    c.put (index, last_i)
                else
                    used := index
                end
 
                k.put (ky, index)
                store.put (x, index)
                last_i := index 
                count  := count + 1
            else 
                store.put (x, index)
            end
        end
-----------------------------------------------------------

    remove (ky : K) is
        -- See the version in TABLE.

        local
            lead, follow : INTEGER
            k            : ARRAY [K]       -- for optimization
            c            : ARRAY [INTEGER] --  "       "

        do
            k := keys
            c := chain

            from
                lead := used
            until
                lead = 0 or else ky.is_equal (k.item (lead))
            loop
                follow := lead
                lead   := c.item (lead)
            end

            if lead /= 0 then
                if follow = 0 then
                    used := chain.item (lead)
                else
                    chain.put (chain.item (lead), follow)
                end

                if lead = last_i then
                    last_i := follow 

                    if last_i /= 0 then
                        chain.put (0, last_i)
                    end
                end

                chain.put (free, lead)
                free  := lead
                count := count - 1

                if count < (store.count // 4) and then
                   store.count > Min_size         then
                    shrink
                end
            end
        end
-----------------------------------------------------------
feature -- Traversal

    iterator : ITERATOR is
        -- See the version in TRAVERSABLE.

        do
            create {INTEGER_ITERATOR} result.make (current)
            init_first (result)
        end
-----------------------------------------------------------

    item (it : ITERATOR) : G is
        -- See the version in TABLE.

        local
            iit : INTEGER_ITERATOR

        do
            iit    ?= it
            result := store.item (iit.cursor)
        end
-----------------------------------------------------------

    key (it : ITERATOR) : K is
        -- See the version in TABLE.

        local
            iit : INTEGER_ITERATOR

        do
            iit    ?= it
            result := keys.item (iit.cursor)
        end
-----------------------------------------------------------

    inside (it : ITERATOR) : BOOLEAN is
        -- See the version in TRAVERSABLE.

        local
            iit : INTEGER_ITERATOR

        do
            iit    ?= it
            result := (iit.cursor /= 0)
        end 
-----------------------------------------------------------
feature -- Comparison

    is_equal (other : like current) : BOOLEAN is
        -- This `is_equal' is somewhere between standard_is_equal and
        -- deep_is_equal. It returns true precisely if `current' and
        -- `other' contain _the same_ references in the same order.

        local
            i1, i2 : INTEGER

        do
            if other /= void then
                from
                    i1 := used
                    i2 := other.used
                until
                    i1 = 0 or else i2 = 0                              or else
                    not keys.item (i1).is_equal (other.keys.item (i2)) or else
                    store.item (i1) /= other.store.item (i2)
                loop
                    i1 := chain.item (i1)
                    i2 := other.chain.item (i2)
                end

                result := (i1 = 0 and then i2 = 0)
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
            keys  := clone (other.keys)
            store := clone (other.store)
            chain := clone (other.chain)
        end
-----------------------------------------------------------

feature { SIMPLE_TABLE }

    Min_size : INTEGER is 16
    chain    : ARRAY [INTEGER]      -- chaining of two lists: used, free
    keys     : ARRAY [K]            -- storage for keys
    store    : ARRAY [G]            -- storage for items
    last_i   : INTEGER              -- index of last element added
    free     : INTEGER              -- number of first free slot
    used     : INTEGER              -- number of first used slot

-----------------------------------------------------------

feature { ITERATOR }

    first (it : ITERATOR) is

        local
            iit : INTEGER_ITERATOR

        do
            iit ?= it
            iit.set_cursor (used)
        end
-----------------------------------------------------------

    next (it : ITERATOR) is

        local
            iit : INTEGER_ITERATOR

        do
            iit ?= it
            iit.set_cursor (chain.item (iit.cursor))
        end
-----------------------------------------------------------

feature { NONE }

    expand is

        local
            i, old_size : INTEGER

        do
            old_size := store.count
            chain.resize (1, 2 * old_size)
            keys.resize  (1, 2 * old_size)
            store.resize (1, 2 * old_size)

            from
                i := old_size + 1
            until
                i = chain.count
            loop
                chain.put (i + 1, i)
                i := i + 1
            end

            chain.put (free, i)
            free := old_size + 1
        end
-----------------------------------------------------------

    shrink is

        local
            s    : ARRAY [G]
            kys  : ARRAY [K]
            i, j : INTEGER

        do
            create kys.make (1, store.count // 2)
            create s.make (1, store.count // 2)

            from
                i := 1
                j := used
            until
                j = 0
            loop
                kys.put (keys.item (j), i)
                s.put (store.item (j), i)
                j := chain.item (j) 
                i := i + 1
            end

            used   := 1
            last_i := i - 1

            from
                chain.resize (1, s.count)
                i := 1
            until
                i = s.count
            loop
                chain.put (i + 1, i)
                i := i + 1
            end

            chain.put (0, i)
            chain.put (0, count)

            free  := count + 1
            keys  := kys
            store := s
        end
-----------------------------------------------------------

end -- class SIMPLE_TABLE

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
