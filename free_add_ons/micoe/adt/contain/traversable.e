indexing

description: "The classes TRAVERSABLE and ITERATOR cooperate%
             % closely to achieve a convenient traversal of%
             % container objects. There can be arbitrarily%
             % many iterators traversing a container at any%
             % given time since they are completely independent%
             % of one another. On the other hand an iterator%
             % logs in with it's container before it starts%
             % and logs out when it stops. The container object%
             % permits neither an `add' nor a `remove' as long%
             % as some iterator is traversing it.";
keywords: "iterator"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
deferred class ES_TRAVERSABLE

feature -- Traversal

    iterator : ITERATOR is
          -- Returns an iterator object which is prepared to
          -- traverse the current container. The `first' routine
          -- of the iterator has already been called and does not
          -- need to be called explicitly unless one wants to
          -- restart the traversal.

        do
            create result.make (current)
            init_first (result)
        end
-----------------------------------------------------------
 
    inside (it : ITERATOR) : BOOLEAN is 
          -- Is the given iterator still inside the container?

        require
            not_void : it /= void

        deferred 
        end 
-----------------------------------------------------------
  
    protected : BOOLEAN is 
            -- True if and only if there is at least one
            -- iterator traversing the container at the moment.

        do 
            result := ( n_iter > 0 ) 
        end 
-----------------------------------------------------------

feature { ITERATOR } 

   
    n_iter : INTEGER        -- no. of active iterators  
 
----------------------------------------------------------- 
 
    first (it : ITERATOR) is

        deferred
        end
-----------------------------------------------------------

    next (it : ITERATOR) is

        require
            still_inside : inside (it)

        deferred
        end
-----------------------------------------------------------

    log_in is
            -- used by iterator to log in

        do
            n_iter := n_iter + 1
        end
-----------------------------------------------------------

    log_out is
            -- used by iterator to log off

        require
            n_iter > 0

        do
            n_iter := n_iter - 1
        end
-----------------------------------------------------------

feature { NONE }

    init_first (it : ITERATOR) is

        do
            first (it)

            if inside (it) then
                it.initialize
            else
                it.terminate
            end
        end

end -- class ES_TRAVERSABLE

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
