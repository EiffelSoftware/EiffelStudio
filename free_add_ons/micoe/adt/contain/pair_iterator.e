indexing

description: "This is the right kind of iterator to use when%
             % your data structure is such that a position%
             % can be described by a pair of integers.";
keywords: "iterator", "traversal"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class PAIR_ITERATOR

inherit
    ITERATOR
    end

creation
    make

feature { ES_TRAVERSABLE }

    i, j : INTEGER

-----------------------------------------------------------
 
    set_pos (new_i, new_j : INTEGER) is

        do
            i        := new_i
            j        := new_j
        end
-----------------------------------------------------------

end -- class PAIR_ITERATOR

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
