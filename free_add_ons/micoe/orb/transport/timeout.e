indexing

description: "Abstraction of a timeout event.";
keywords: "scheduling", "event";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TIMEOUT

inherit
    EVENT_CONSTANTS;
    DISPATCHER_CALLBACK

creation
    make

feature -- Initialization

    make (disp : DISPATCHER; tm : INTEGER) is

        do
            d     := disp
            ready := (tm = 0)


            if tm > 0 then
                d.tm_event (current, tm)
            end
        end
----------------------

    cleanup is
        -- This is actually a destructor

        do
            d.remove (current, Timer_ev)
        end
----------------------
feature -- The all-important operation

    callback_d (disp : DISPATCHER; ev : INTEGER) is

        do
            ready := true
        end
----------------------
feature -- Access

    done : BOOLEAN is

        do
            result := ready
        end
----------------------
feature { NONE } -- Implementation

    ready : BOOLEAN
    d     : DISPATCHER	

end -- class TIMEOUT

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
