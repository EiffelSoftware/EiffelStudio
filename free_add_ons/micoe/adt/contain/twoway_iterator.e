indexing

description: "TWOWAY_ITERATORs can traverse their containers in either%
             % direction. This is only useful on containers that keep%
             % their elements sorted.";
keywords: "traversal", "sorting"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   TWOWAY_ITERATOR

inherit
    ITERATOR
        redefine
            partner
    end

creation { TWOWAY_TRAVERSABLE }
    make

feature -- Traversal

    last is                 -- go to last element of traversable object

        do
            partner.last (current)
            initialize
        end
-----------------------------------------------------------

    back is                 -- go to previous element of traversable object

        require
            still_inside : inside

        do
            partner.previous (current)

            if not inside then
                terminate
            end
        end
-----------------------------------------------------------

feature { NONE }

    partner : TWOWAY_TRAVERSABLE

end -- class TWOWAY_ITERATOR

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
