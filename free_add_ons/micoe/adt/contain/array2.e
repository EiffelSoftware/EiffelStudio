indexing

description: "This class implements two-dimensional arrays.";
keywords: "two-dimensional array"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   ARRAY2 [G]

creation
    make

feature -- Initialization
 
    make (s1, s2 : INTEGER; init_val : G) is

        require
            -- init_val /= void

        local
            i : INTEGER

        do
            create store.make (1, s1 * s2)
            size1 := s1
            size2 := s2

            from
                i := 1
            until
                i > s1 * s2
            loop
                store.put (init_val, i)
                i := i + 1
            end
        end
-----------------------------------------------------------
feature -- Access
 
    size1 : INTEGER -- No. of rows
    size2 : INTEGER -- No. of columns

-----------------------------------------------------------

    item (i, j : INTEGER) : G is

        require
            1 <= i and then i <= size1
            1 <= j and then j <= size2

        do
            result := store.item ((i - 1) * size1 + j)
        end
-----------------------------------------------------------
feature -- Mutation
 
    put (x : G; i, j : INTEGER) is

        require
            1 <= i and then i <= size1
            1 <= j and then j <= size2

        do
            store.put (x, (i - 1) * size1 + j)
        end
-----------------------------------------------------------
 
feature { NONE }

    store : ARRAY [G]

-----------------------------------------------------------

end -- class ARRAY2

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
