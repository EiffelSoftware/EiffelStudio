indexing

description: "This is a straightforward implementation of the%
             % abstraction hash table for implementing a 1:1%
             % mapping. If you need a hash_table that reorganizes%
             % itself when it gets too full look at DICTIONARY.";
keywords: "table", "1:1 mapping"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   HASH_TABLE [G, K -> HASHABLE]

inherit
 
    ES_TABLE [G, K]
        rename
            make as unused_make
        redefine
            is_equal, copy, 
            search, add, remove, iterator,
            first, next, inside, item, key
    end

creation
    make

feature -- Initialization

    make (only_once : BOOLEAN; size : INTEGER) is
        -- If `only_once' is true then duplicate keys will not be accepted.
        -- `size' specifies the number of buckets; it should be roughly as big
        -- as the expected number of keys.

        local
            i : INTEGER

        do
            is_unique := only_once
            modulus   := size
            count     := 0
            free      := 1
            found     := false
 
            create buckets.make (1, size)
            create chain.make (1, Min_size)
            create store.make (1, Min_size)
            create keys.make (1, Min_size)

            from
                i := 1
            until
                i = chain.count
            loop
                chain.put (i + 1, i)
                i := i + 1
            end

            chain.put (0, i)
        end
-----------------------------------------------------------
feature -- Searching

    search (k : K) is
        -- See the version in TABLE.

        local
            n  : INTEGER
            c  : ARRAY [INTEGER]
            ky : ARRAY [K]

        do
            found := false

            from
                n  := buckets.item (1 + k.hash_code \\ modulus)
                c  := chain
                ky := keys
            until
                n = 0 or else k.is_equal (ky.item (n))
            loop
                n := c.item (n)
            end

             if n /= 0 then
                found_item  := store.item (n)
                found_key   := keys.item (n)
                found       := true
            end

        ensure then 
            found implies k.is_equal (found_key)
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G; k : K) is
        -- See the version in TABLE.

        local
            already : BOOLEAN
            hval    : INTEGER
            n       : INTEGER

        do
            hval := 1 + k.hash_code \\ modulus

            if is_unique then
                already := lsearch (buckets.item (hval), k)
            end

            if not already then
                if count >= store.count then
                    expand
                end

                keys.put (k, free)
                store.put (x, free)

                n    := free
                free := chain.item (free)
                chain.put (buckets.item (hval), n)
                buckets.put (n, hval)

                count := count + 1
            end
        end
-----------------------------------------------------------

    replace (x : G; k : K) is
        -- See the version in TABLE.

        local
            hval : INTEGER
            n    : INTEGER
            c    : ARRAY [INTEGER]
            ky   : ARRAY [K]

        do
            hval := 1 + k.hash_code \\ modulus

            from
                n  := buckets.item (hval)
                c  := chain
                ky := keys
            until
                n = 0 or else k.is_equal (ky.item (n))
            loop
                n := c.item (n)
            end

            if n /= 0 then
                store.put (x, n)
            else
                if count >= store.count then
                    expand
                end

                keys.put (k, free)
                store.put (x, free)

                n    := free
                free := chain.item (free)
                chain.put (buckets.item (hval), n)
                buckets.put (n, hval)

                count := count + 1
            end
        end
-----------------------------------------------------------

    remove (k : K) is
        -- See the version in TABLE.

        local
            hval : INTEGER
            n, p : INTEGER
            c    : ARRAY [INTEGER]
            ky   : ARRAY [K]

        do
            hval := 1 + k.hash_code \\ modulus

            from
                n  := buckets.item (hval)
                c  := chain
                ky := keys
            until
                n = 0 or else k.is_equal (ky.item (n))
            loop
                p := n
                n := c.item (n)
            end

            if n /= 0 then
                if p /= 0 then
                    chain.put (chain.item (n), p)
                else
                    buckets.put (chain.item (n), hval)
                end

                chain.put (free, n)
                free  := n
                count := count - 1

                if count < store.count // 4 and then count > Min_size then
                    shrink
                end
            end
        end
-----------------------------------------------------------
feature -- Traversal

    iterator : ITERATOR is
        -- See the version in TRAVERSABLE.

        do
            create {PAIR_ITERATOR} result.make (current)
            init_first (result)
        end
-----------------------------------------------------------

    item (it : ITERATOR) : G is
        -- See the version in TABLE.

        local
            hit : PAIR_ITERATOR

        do
            hit    ?= it
            result := store.item (hit.j)
        end
-----------------------------------------------------------

    key (it : ITERATOR) : K is
        -- See the version in TABLE.

        local
            hit : PAIR_ITERATOR

        do
            hit    ?= it
            result := keys.item (hit.j)
        end
-----------------------------------------------------------

    inside (it : ITERATOR) : BOOLEAN is
        -- See the version in TRAVERSABLE.

        local
            hit : PAIR_ITERATOR

        do
            hit    ?= it
            result := (hit.j /= 0)
        end
-----------------------------------------------------------
feature -- Comparison

    is_equal (other : like current) : BOOLEAN is
        -- This `is_equal' is somewhere between standard_is_equal and
        -- deep_is_equal. It returns true precisely if `current' and
        -- `other' contain _the same_ references in the same order.

        local
            i      : INTEGER
            n1, n2 : INTEGER

        do
            from
                result := (other /= void and then modulus = other.modulus)
                i      := 1
            until
                not result or else i > modulus
            loop
                from
                    n1 := buckets.item (i)
                    n2 := other.buckets.item (i)
                until
                    not result or else n1 = 0 or else n2 = 0
                loop
                    if not equal (keys.item (n1), other.keys.item (n2))
                       or else
                       store.item (n1) /= other.store.item (n2) then
                        result := false
                    else
                        n1 := chain.item (n1)
                        n2 := other.chain.item (n2)
                    end
                end

                if n1 /= 0 or else n2 /= 0 then 
                    result := false 
                else
                    i := i + 1 
                end 
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
            buckets := clone (other.buckets)
            keys    := clone (other.keys)
            store   := clone (other.store)
            chain   := clone (other.chain)
        end
-----------------------------------------------------------

feature { HASH_TABLE }

    Min_size : INTEGER is 16
    buckets  : ARRAY [INTEGER] 
    modulus  : INTEGER 
    chain    : ARRAY [INTEGER]      -- chaining of two lists: used, free
    keys     : ARRAY [K]            -- storage for keys
    store    : ARRAY [G]            -- storage for items
    free     : INTEGER              -- number of first free slot

-----------------------------------------------------------

feature { ITERATOR }

    first (it : ITERATOR) is

        local
            i   : INTEGER
            hit : PAIR_ITERATOR

        do
            hit ?= it

            from
                i := 1
            until
                i > modulus or else buckets.item (i) /= 0
            loop
                i := i + 1
            end

            if i <= modulus then
                hit.set_pos (i, buckets.item (i))
            else
                hit.set_pos (0, 0)
            end
        end
-----------------------------------------------------------

    next (it : ITERATOR) is

        local
            i   : INTEGER
            hit : PAIR_ITERATOR

        do
            hit ?= it

            if chain.item (hit.j) /= 0 then
                hit.set_pos (hit.i, chain.item (hit.j))
            else
                from
                    i := hit.i + 1
                until
                    i > modulus or else buckets.item (i) /= 0
                loop
                    i := i + 1
                end

                if i <= modulus then
                    hit.set_pos (i, buckets.item (i))
                else
                    hit.set_pos (0, 0)
                end
            end
        end
-----------------------------------------------------------

feature { NONE }

    lsearch (n : INTEGER; k : K) : BOOLEAN is

        local
            m : INTEGER

        do
            from
                m := n
            until
                m = 0 or else k.is_equal (keys.item (m))
            loop
                m := chain.item (m)
            end

            result := (m /= 0)
        end
-----------------------------------------------------------

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
            str  : ARRAY [G]
            kys  : ARRAY [K]
            chn  : ARRAY [INTEGER]
            i, j : INTEGER
            k    : INTEGER

        do
            create kys.make (1, store.count // 2)
            create str.make (1, store.count // 2)
            create chn.make (1, store.count // 2)

            from
                i := 1
                j := 1
            until
                j > modulus
            loop
                from
                    k := buckets.item (j)

                    if k /= 0 then
                        buckets.put (i, j)
                    end
                until
                    k = 0
                loop
                    kys.put (keys.item (k), i)
                    str.put (store.item (k), i)
                    k := chain.item (k) 

                    if k = 0 then
                        chn.put (0, i)
                    else
                        chn.put (i + 1, i)
                    end

                    i := i + 1
                end

                j := j + 1
            end

            from
                i := count + 1
            until
                i >= chn.count
            loop
                chn.put (i + 1, i)
                i := i + 1
            end

            chn.put (0, i)

            free  := count + 1
            chain := chn
            keys  := kys
            store := str
        end
-----------------------------------------------------------

end -- class HASH_TABLE 

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
