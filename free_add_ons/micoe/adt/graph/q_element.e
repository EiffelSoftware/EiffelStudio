indexing

description: "Special objects, that can participate in PRIORTQs";
keywords: "priority queue", "raise priority"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   Q_ELEMENT [G, K->COMPARABLE]

creation
    make

feature -- Initialization

    make (x : G; p : K) is
        -- Initialize an element with item `x' and
        -- priority `p'.

        do
            item        := x
            my_priority := p
        end
-----------------------------------------------------------

feature -- Access

    item : G

    index : INTEGER
        -- Position of `current' in the queue
    queue : PRIORTQ [G, K]
        -- That's the queue `current' is in.


    priority : K is

        do
            result := my_priority
        end
-----------------------------------------------------------
feature -- Mutation

    set_priority (p : K) is
        -- Give this element a new priority and move it to it's right position
        -- in `queue'.

        require
            raising_priority : p >= priority

        do
            my_priority := p
            if queue /= void then
                queue.raise_priority (current)
            end
        end
-----------------------------------------------------------

    is_in_queue (q : PRIORTQ [G, K]) : BOOLEAN is

        do
            result := (q = queue)
        end
-----------------------------------------------------------

    set_item (x : G) is

        do
            item := x
        end
-----------------------------------------------------------
 
feature  { PRIORTQ }

    set_index (i : INTEGER) is

        do
           index := i
        end
-----------------------------------------------------------

    set_queue (q : like queue) is

        do
            queue := q
        end
-----------------------------------------------------------
feature { NONE }

    my_priority : K

end -- class Q_ELEMENT

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
