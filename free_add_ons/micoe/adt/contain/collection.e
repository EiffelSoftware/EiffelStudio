indexing

description: "The abstract class COLLECTION factors out the features that%
             % will be common to all kinds of lists.";
keywords: "list"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
deferred class ES_COLLECTION [G]

inherit

    ES_TRAVERSABLE


feature -- Initialization


    make (only_once : BOOLEAN) is
          -- If `only_once' is true, then the new collection will
          -- not allow duplicates. Otherwise duplicate entries
          -- are allowed.

        do
            is_unique := only_once
        end
-----------------------------------------------------------
feature -- Status

    count : INTEGER
        -- That's how many elements there are 

    empty : BOOLEAN is

        do
            result := (count = 0)

        ensure
            right_answer : result = (count = 0)
        end
-----------------------------------------------------------
feature -- Traversal

    item (it : ITERATOR) : G is
          -- The element at the position on which the iterator `it' is
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

-----------------------------------------------------------

    search (x : G) is
          -- Look for the element `x' in the collection. If at least
          -- one reference to `x' is found there, set `found' to
          -- true and `found_item' to the item found; otherwise
          -- set `found' to false. Virtually every descendant will
          -- have a more efficient version of `search'.

        local
            it : ITERATOR

        do
            from
                it := iterator
            until
                it.finished
            loop
                if x.is_equal (item (it)) then
                    it.stop
                else
                    it.forth
                end
            end

            found := inside (it)

            if found then
                found_item := item (it)
            end
        end
-----------------------------------------------------------
feature -- Mutation

    add (x : G) is
          -- If the collection was created in non-unique mode, then
          -- the element `x' is unconditionally added to the contents
          -- of the collection. If the list was created in unique
          -- unique mode, `x' is only added if it was not yet in the
          -- collection. Otherwise a call `add (x)' is without effect.

        require
            no_clash : not protected   -- don't change horses in mid-stream ...

        deferred
        end
-----------------------------------------------------------

    remove (x : G) is
          -- If the element `x' is present in the list, then one
          -- reference to `x' is removed.

        require
            no_clash : not protected   -- don't change horses in mid-stream ...

        deferred
        end
-----------------------------------------------------------

feature { NONE }

    is_unique : BOOLEAN     -- may an element be in container more than once? 

-----------------------------------------------------------

end -- class ES_COLLECTION

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
