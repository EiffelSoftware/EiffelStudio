indexing

description: "Objects of type TWOWAY_TRAVERSABLE support traversal%
             % in both directions. This is only useful on containers%
             % that maintain their elements in sorted order.";
keywords: "traversal", "sorting"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
deferred class TWOWAY_TRAVERSABLE

inherit
    ES_TRAVERSABLE
        redefine
            iterator
    end

feature -- Traversal

    iterator : TWOWAY_ITERATOR is

        do
            create result.make (current)
            init_first (result)
        end
-----------------------------------------------------------

feature { ITERATOR }

    last (it : ITERATOR) is

        deferred
        end
-----------------------------------------------------------
 
    previous (it : ITERATOR) is

        require
            still_inside : inside (it)

        deferred
        end
-----------------------------------------------------------


end -- class TWOWAY_TRAVERSABLE

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
