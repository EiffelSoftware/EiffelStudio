indexing

description: "The scheduler for the ORB";
keywords: "Scheduling", "events";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class DISPATCHER

inherit
    EVENT_CONSTANTS

feature -- Operations

    rd_event (cb : DISPATCHER_CALLBACK; fd : INTEGER) is
        -- Add a read event to watch for -- i.e. watch for
        -- something to read on descriptor `fd'. When it
        -- happens, call `cb.callback'.

        deferred
        end
---------------------------------------------------------

    wr_event (cb : DISPATCHER_CALLBACK; fd : INTEGER) is
        -- Add a write event to watch for -- i.e. watch for
        -- the ability to writeon descriptor `fd'. When it
        -- happens, call `cb.callback'.

        deferred
        end
---------------------------------------------------------

    ex_event (cb : DISPATCHER_CALLBACK; fd : INTEGER) is
        -- Add an exception event to watch for -- i.e. watch for
        -- an exception (whatever that means) on descriptor `fd'.
        -- When it happens, call `cb.callback'.

        deferred
        end
---------------------------------------------------------

    tm_event (cb : DISPATCHER_CALLBACK; tmout : INTEGER) is
        -- Add a timer event to watch for -- i.e. set the
        -- timer to timeout after `tmout' ms. When it
        -- happens, call `cb.callback'.

        require
            nonnegative : tmout >= 0

        deferred
        end
---------------------------------------------------------

    remove (cb : DISPATCHER_CALLBACK; ev : INTEGER) is
        -- Remove event of type `event' associated with callback `cb'
        -- from the list of events to be watched for. `event' can be
        -- one of Read_ev, Write_ev, Except_ev, Timer_ev or All_ev.
        -- All_ev matches any event type.

        deferred
        end
---------------------------------------------------------

    run is
        -- Run one step; i.e. until an event occurs or for a
        -- preset fixed length of time, whichever occurs first.
        -- Afterward handle any events that have occurred.

        deferred
        end
---------------------------------------------------------

    run_forever is
        -- Call `run' repeatedly until stopped by a
        -- deadly signal.

        deferred
        end
---------------------------------------------------------

    move (other : DISPATCHER) is
        -- Transfer all events being watched for by `current'
        -- to `other'.

        deferred
        end
---------------------------------------------------------

    idle : BOOLEAN is
        -- Are there any events being watched for?

        deferred
        end

end -- class DISPATCHER

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
