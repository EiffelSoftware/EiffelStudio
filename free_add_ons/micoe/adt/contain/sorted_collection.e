indexing

description: "Sorted collections maintain their elements in sorted order;%
             % they permit traversal in both directions.";
keywords: "sorting", "two way traversal"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
deferred class SORTED_COLLECTION [G -> COMPARABLE]

inherit

    ES_COLLECTION [G]
        undefine
            iterator
    end;
    TWOWAY_TRAVERSABLE


feature -- Traversal


    iter_after (x : G) : TWOWAY_ITERATOR is
          -- Returns an iterator object which is prepared to
          -- traverse the current collection in increasing order
          -- beginning at the first element >= `x'.

        do
            create result.make (current)
            init_after (x, result)

        ensure
            right_item : inside (result) implies item (result) >= x
        end

-----------------------------------------------------------

    iter_before (x : G) : TWOWAY_ITERATOR is
          -- Returns an iterator object which is prepared to
          -- traverse the current collection in decreasing order
          -- beginning at the first element <= `x'.

        do
            create result.make (current)
            init_before (x, result)

        ensure
            right_item : inside (result) implies item (result) <= x
        end
-----------------------------------------------------------

feature { NONE }


    init_after (x : G; it : TWOWAY_ITERATOR) is

        do
            first_after (x, it)

            if inside (it) then
                it.initialize
            else
                it.terminate
            end
        end
-----------------------------------------------------------

    init_before (x : G; it : TWOWAY_ITERATOR) is

        do
            last_before (x, it)

            if inside (it) then
                it.initialize
            else
                it.terminate
            end
        end
------------------------------------------------------------------------- 

    first_after (x : G; it : TWOWAY_ITERATOR) is

        deferred
        end
-----------------------------------------------------------

    last_before (x : G; it : TWOWAY_ITERATOR) is

        deferred
        end

end -- class SORTED_COLLECTION

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
