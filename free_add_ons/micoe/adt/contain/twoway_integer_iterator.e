indexing

description: "This is the right kind of twoway iterator to%
             % use when your data structure is such that a%
             % position can be described by an integer.";
keywords: "iterator", "traversal"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   TWOWAY_INTEGER_ITERATOR

inherit
    TWOWAY_ITERATOR
    end

creation
    make

feature { TWOWAY_TRAVERSABLE }

    cursor : INTEGER

-----------------------------------------------------------
 
    set_cursor (curs : INTEGER) is

        do
            cursor := curs
            recompute_finished
        end
-----------------------------------------------------------

end -- class TWOWAY_INTEGER_ITERATOR

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
