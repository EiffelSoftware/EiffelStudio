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
keywords: "iterator", "traversal"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   ITERATOR

creation { ES_TRAVERSABLE }
    make
 
feature -- Control

    finished : BOOLEAN

-----------------------------------------------------------
 
    first is
        -- go to first element of container

        do
            partner.first (current)
            initialize

        ensure
            not_inside_means_finished : not inside implies finished
        end
-----------------------------------------------------------

    forth is
        -- go to next element of container

        require
            still_inside : inside

        do
            partner.next (current)

            if not inside then
                terminate
            end

        ensure
            not_inside_means_finished : not inside implies finished
        end
-----------------------------------------------------------

    stop is
        -- make finished true

        do
            if not finished then
                terminate
            end
        end
-----------------------------------------------------------

    inside : BOOLEAN is
        -- Is `current' still inside "it's" container?

        do
            result := partner.inside (current)
        end
-----------------------------------------------------------

feature { ES_TRAVERSABLE } 

    partner    : ES_TRAVERSABLE  -- object traversed by iterator
    logged_in  : BOOLEAN      -- am I logged in with container?

-----------------------------------------------------------

    make (t : like partner) is

        do
            partner   := t
            logged_in := false
        end
-----------------------------------------------------------

    initialize is
        -- called to initialize data inside, finished,
        -- logged_in

        do
            finished := not inside

            if not finished and then not logged_in then
                partner.log_in
                logged_in := true
            end
        end

-----------------------------------------------------------

    terminate is
        -- called to clean up and log out

        do
            finished := true

            if logged_in then
                logged_in := false
                partner.log_out
            end
        end
-----------------------------------------------------------

    recompute_finished is
        -- This routine may (should) be called by any routine
        -- in a descendent that might have affected the status
        -- of finished and needs to be certain the class
        -- invariant is satisfied.

        do
            finished := not inside
        end

end -- class ITERATOR

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
