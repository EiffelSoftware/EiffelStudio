indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class REQUEST_QUEUE

inherit
    EVENT_CONSTANTS;
    DISPATCHER_CALLBACK

creation
    make

feature -- Initialization

    make (the_oa : OBJECT_ADAPTER; the_orb : ORB) is

        do
            oa         := the_oa
            myorb      := the_orb
            current_id := 0
            create invokes.make
        end
--------------------------------
feature -- Access

    iscurrent (id : INTEGER) : BOOLEAN is

        do
            result := (current_id /= 0 and then id = current_id)
        end
--------------------------------

    size : INTEGER is

        do
            result := invokes.count
        end
--------------------------------
feature -- Operations

    add (rec : REQUEST_QUEUE_RECORD) is

        do
            invokes.add (rec)
        end
--------------------------------

    exec_now is

        local
            seen : SORTED_SET [INTEGER]
            inv  : REQUEST_QUEUE_RECORD
            done : BOOLEAN

        do
            from
                create seen.make
            until
                invokes.empty or else done
            loop
                inv := invokes.item

                current_id := inv.msgid
                if seen.has (current_id) then
                    done := true
                else
                    seen.add (current_id)
                    invokes.remove
                    -- If invoke cannot be executed yet,
                    -- mediator will install a new
                    -- REQUEST_QUEUE_RECORD...
                    inv.exec (oa, myorb)
                end
            end
            current_id := 0
        end
--------------------------------

    exec_later is
        -- schedule reexecution of pending requests...

        do
            if not invokes.empty then
                myorb.dispatcher.remove (current, Timer_ev)
                myorb.dispatcher.tm_event (current, 0)
                    -- zero timeout
            end
        end
--------------------------------

    exec_stop is

        do
            myorb.dispatcher.remove (current, Timer_ev)
        end
--------------------------------

    fail is
        -- make all pending invokes fail

        local
            inv : REQUEST_QUEUE_RECORD

        do
            from
                -- nothing
            until
                invokes.empty
            loop
                inv := invokes.item
                invokes.remove
                inv.fail (oa, myorb)
            end
        end
--------------------------------

    clear is

        do
            create invokes.make
        end    
--------------------------------

    callback_d (d : DISPATCHER; ev : INTEGER) is

        do
            check
                good_event : ev = Timer_ev
            end
            exec_now
        end
--------------------------------
feature { NONE } -- Implementation

    current_id : INTEGER
    invokes    : QUEUE [REQUEST_QUEUE_RECORD]
    oa         : OBJECT_ADAPTER
    myorb      : ORB 

end -- class REQUEST_QUEUE

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
