
indexing

description: "The abstract class TABLE factors out the features that%
             % will be common to all kinds of tables.";
keywords: "table", "key"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
deferred class ES_TABLE [G, K]

inherit

    ES_TRAVERSABLE

feature -- Initialization

    make (only_once : BOOLEAN) is
        -- If `only_once' is true, then the
        -- new table will not allow duplicate keys.
        -- Otherwise duplicate entries are allowed.

        do
            is_unique := only_once
            count     := 0
            found     := false
        end
-----------------------------------------------------------
feature -- Status

    count : INTEGER
        -- that's how many (key, item) pairs there are

    empty : BOOLEAN is

        do
            result := (count = 0)

        ensure
            right_answer : result = (count = 0)
        end
-----------------------------------------------------------
feature -- Traversal

    item (it : ITERATOR) : G is
        -- The item at the position on which the iterator `it' is
        -- currently standing.

        require
            not_void  : it /= void
            is_inside : inside (it)

        deferred
        end
-----------------------------------------------------------

    key (it : ITERATOR) : K is
        -- The key at the position on which the iterator `it' is
        -- currently standing.

        require
            not_void  : it /= void
            is_inside : inside (it)

        deferred
        end
-----------------------------------------------------------
feature -- Searching

    found      : BOOLEAN    -- True if and only if the last call
                            -- to `search' was successful.
    found_item : G          -- The item found by the last call to
                            -- `search'. The value is valid only if
                            -- `found' = true.
    found_key  : K          -- The key found by the last call to
                            -- `search'. The value is valid only if
                            -- `found' = true.

    search (k : K) is   -- a default implementation
        -- Look for the key `k' in the table. If at least one
        -- reference to `k' is found there, set `found' to true;
        -- otherwise set `found' to false.
        -- If `found' = true, `found_item' and `found_key' are
        -- set correspondingly. Virtually all descendents will
        -- have a more efficient version of `search'.

        local
            it : ITERATOR

        do
            from
                it := iterator
            until
                it.finished
            loop
                if k.is_equal (key (it)) then
                    it.stop
                else
                    it.forth
                end
            end

            found := inside (it)

            if found then
                found_item := item (it)
                found_key  := key (it)
            end
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G; k : K) is
        -- If the table was created in non--unique 
        -- mode then the pair `x', `k' is unconditionally
        -- added to the contents of the table. If the table 
        -- was created in unique mode, then `x', `k' is
        -- only added if `k' was not yet in the table.
        -- Otherwise a call `add (x, k)' is without effect.

        require
            no_clash : not protected   -- don't change horses in mid-stream ...

        deferred
        end
-----------------------------------------------------------

    replace (x : G; k : K) is
            -- If an entry for key k exists, replace item with x;
            -- otherwise make an entry for k with item x.

        require 
            no_clash : not protected   -- don't change horses in mid-stream ... 
 
        deferred
        end
-----------------------------------------------------------

    remove (k : K) is
        -- If the key `k' is present in the container,
        -- then one reference to `k' is removed.

        require
            no_clash : not protected   -- don't change horses in mid-stream ...

        deferred
        end
-----------------------------------------------------------

feature { NONE }

    is_unique : BOOLEAN -- may an element be in container more than once? 


end -- class ES_TABLE

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
