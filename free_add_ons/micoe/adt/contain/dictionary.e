indexing

description: "A dictionary implements a 1:1 mapping between keys of type%
             % K and items of type G. Unlike HASH_TABLE the class%
             % DICTIONARY strives to keep the load factor bounded%
             % so as to guarantee essentially constant access time%
             % (O(1)). This is achieved by using rehashing whenever%
             % the load factor exceeds a bound that can be controlled%
             % by the programmer. Using amortized analysis one can%
             % show that the average cost of a put is nevertheless O(1).";
keywords: "1:1 mapping", "associative array", "hash table"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   DICTIONARY [G, K -> HASHABLE]

inherit
    ES_TRAVERSABLE
        redefine
            iterator, inside, first, next,
            is_equal, copy
        end

creation
    make

feature -- Initialization

    make is

        local
            i : INTEGER

        do
            default_size := Def_size
            load_factor  := Def_factor
            modulus      := Def_size
            count        := 0
            free         := 1 
            crnt_n       := 0
            shrinkable   := false

            create buckets.make (0, modulus - 1)
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

            from
                i := 0
            until
                i >= modulus
            loop
                buckets.put (0, i)
                i := i + 1
            end
        end
-----------------------------------------------------------
feature -- Size control

    count : INTEGER -- Number of (key, item) pairs in `current'.


    set_default_size (new_size : INTEGER) is
        -- Change the default number of buckets.
        -- This procedure will normally be called
        -- before putting any elements into the
        -- dictionary. If it is called later, this
        -- will cause an automatic rehashing.
        -- The default size is 32.

        do
            default_size := new_size

            if modulus /= default_size then
                if count > 0 then
                    resize (default_size)
                else
                    modulus := default_size
                    buckets.resize (0, modulus - 1)
                end
            end
        end
-----------------------------------------------------------

    set_load_factor (new_factor : REAL) is
        -- The "load factor" determines the point at
        -- which a resize and rehash takes place. This
        -- happens when `count' > `load_factor' * (no. buckets).
        -- The default `load_factor' is 2.0. 

        do
            load_factor := new_factor
        end
-----------------------------------------------------------

    set_shrinkable (on_or_off : BOOLEAN) is
        -- Should the number of buckets shrink again
        -- when count gets small? Default is `off'.

        do
            shrinkable := on_or_off
        end
-----------------------------------------------------------
feature -- Access

    at (k : K) : G is
        -- The item stored at key `k'.

        require
            key_is_there : has (k)

        local
            ky : ARRAY [K]
            ch : ARRAY [INTEGER]

        do
            if crnt_n = 0 or else not k.is_equal (keys.item (crnt_n)) then
                from
                    crnt_n := buckets.item (k.hash_code \\ modulus)
                    ky     := keys
                    ch     := chain
                until
                    k.is_equal (ky.item (crnt_n))
                loop
                    crnt_n := ch.item (crnt_n)
                end
            end

            result := store.item (crnt_n)
        end
-----------------------------------------------------------

    has (k : K) : BOOLEAN is
        -- Is there an item currently associated
        -- with key `k'?

        require
           good_key : k /= void

        local
            ky : ARRAY [K]
            ch : ARRAY [INTEGER]

        do
            if crnt_n = 0 or else not k.is_equal (keys.item (crnt_n)) then
                from
                    crnt_n := buckets.item (k.hash_code \\ modulus)
                    ky     := keys
                    ch     := chain
                until
                    crnt_n = 0 or else k.is_equal (ky.item (crnt_n))
                loop
                    crnt_n := ch.item (crnt_n)
                end
            end

            result := (crnt_n /= 0)
        end
-----------------------------------------------------------
feature -- Mutation

    put (x : G; k : K) is
        -- If there is as yet no key `k' in the
        -- dictionary, enter it with item `x'.
        -- Otherwise overwrite the item associated
        -- with key `k'.

        require
           good_key : k /= void

        local
            hval : INTEGER
            ky   : ARRAY [K]
            ch   : ARRAY [INTEGER]

        do
            hval := k.hash_code \\ modulus

            if not has (k) or else not k.is_equal (keys.item (crnt_n)) then
                from
                    crnt_n := buckets.item (hval)
                    ky     := keys
                    ch     := chain
                until
                    crnt_n = 0 or else k.is_equal (ky.item (crnt_n))
                loop
                    crnt_n := ch.item (crnt_n)
                end

                if crnt_n = 0 then
                    if count >= store.count then
                        expand
                    end

                    keys.put (k, free)
                    store.put (x, free)

                    crnt_n := free
                    free   := chain.item (free)
                    chain.put (buckets.item (hval), crnt_n)
                    buckets.put (crnt_n, hval)
                    count := count + 1

                    if count > modulus * load_factor then
                        resize (2 * modulus)
                    end
                end
            else
                store.put (x, crnt_n) 
            end
        end
-----------------------------------------------------------

    remove (k : K) is
        -- If there is an entry for key `k'
        -- remove it. Otherwise the call has no effect.

        require
           good_key : k /= void

        local
            hval : INTEGER
            n, p : INTEGER
            ky   : ARRAY [K]
            ch   : ARRAY [INTEGER]

        do
            hval := k.hash_code \\ modulus

            from
                n  := buckets.item (hval)
                ky := keys
                ch := chain
            until
                n = 0 or else k.is_equal (ky.item (n))
            loop
                p := n
                n := ch.item (n)
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

                if n = crnt_n then
                    crnt_n := 0
                end

                if shrinkable                            and then
                   count < (modulus * load_factor) / 4.0 and then
                   modulus >= 2 * default_size              then
                    resize (modulus // 2)
                end

                if count < store.count // 4 and then count > Min_size then
                    shrink
                end
            end
        end
-----------------------------------------------------------
feature -- Traversal

    iterator : ITERATOR is
        -- An iterator prepared to traverse the entire dictionary.

        do
            create {PAIR_ITERATOR} result.make (current)
            init_first (result)
        end
-----------------------------------------------------------

    item (it : ITERATOR) : G is
        -- The item the iterator `it' is currently standing on.

        local
            hit : PAIR_ITERATOR

        do
            hit    ?= it
            result := store.item (hit.j)
        end
-----------------------------------------------------------

    key (it : ITERATOR) : K is
        -- The key the iterator `it' is currently standing on.

        local
            hit : PAIR_ITERATOR

        do
            hit    ?= it
            result := keys.item (hit.j)
        end
-----------------------------------------------------------

    inside (it : ITERATOR) : BOOLEAN is
        -- Is the iterator `it' still inside the dictionary?

        local
            hit : PAIR_ITERATOR

        do
            hit    ?= it
            result := (hit.j /= 0)
        end
-----------------------------------------------------------
feature -- Comparison

    is_equal (other : like current) : BOOLEAN is

        local
            i      : INTEGER
            n1, n2 : INTEGER

        do
            from
                result := (other /= void and then modulus = other.modulus)
            until
                not result or else i >= modulus
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

        do
            standard_copy (other)
            buckets := clone (other.buckets)
            keys    := clone (other.keys)
            store   := clone (other.store)
            chain   := clone (other.chain)
        end
-----------------------------------------------------------
feature { ITERATOR }

    first (it : ITERATOR) is

        local
            i   : INTEGER
            hit : PAIR_ITERATOR

        do
            hit ?= it

            from
                i := 0
            until
                i >= modulus or else buckets.item (i) /= 0
            loop
                i := i + 1
            end

            if i < modulus then
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
                    i >= modulus or else buckets.item (i) /= 0
                loop
                    i := i + 1
                end

                if i < modulus then
                    hit.set_pos (i, buckets.item (i))
                else
                    hit.set_pos (0, 0)
                end
            end
        end
-----------------------------------------------------------

feature { DICTIONARY }

    Min_size : INTEGER is 16
    buckets  : ARRAY [INTEGER]
    modulus  : INTEGER
    chain    : ARRAY [INTEGER]      -- chaining of two lists: used, free
    keys     : ARRAY [K]            -- storage for keys
    store    : ARRAY [G]            -- storage for items
    free     : INTEGER              -- number of first free slot

-----------------------------------------------------------

feature { NONE }

    Def_size   : INTEGER is 32 
    Def_factor : REAL is 2.0 

    load_factor  : REAL   
    default_size : INTEGER   
    shrinkable   : BOOLEAN 
    crnt_n       : INTEGER

-----------------------------------------------------------

    resize (new_mod : INTEGER) is

        local
            hval    : INTEGER
            new_buc : like buckets
            i       : INTEGER
            n, p    : INTEGER
            ky      : ARRAY [K]
            ch      : ARRAY [INTEGER]

        do
            create new_buc.make (0, new_mod - 1)

            from
                i  := 0
                ky := keys
                ch := chain
            until
                i >= modulus
            loop
                from
                    n := buckets.item (i)
                until
                    n = 0
                loop
                    p    := ch.item (n)
                    hval := ky.item (n).hash_code \\ new_mod 
                    ch.put (new_buc.item (hval), n) 
                    new_buc.put (n, hval) 
                    n := p
                end

                i := i + 1
            end

            buckets := new_buc
            modulus := new_mod
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
                j := 0
            until
                j >= modulus
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
                
end -- class DICTIONARY 

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
