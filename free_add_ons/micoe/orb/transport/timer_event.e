indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class TIMER_EVENT
    -- Actually a struct.

creation
    make, make3

feature -- Initialization

    make is

        do
        end
---------------------------------

    make3 (ev, del : INTEGER; dcb : DISPATCHER_CALLBACK) is

        do
            event   := ev
            delta   := del
            cb      := dcb
        end
---------------------------------
feature -- Access

    get_event : INTEGER is

        do
            result := event
        end
---------------------------------

    get_delta : INTEGER is

        do
            result := delta
        end
---------------------------------

    get_cb : DISPATCHER_CALLBACK is

        do
            result := cb
        end
---------------------------------
feature -- Mutation

    set_event (ev : INTEGER) is

        do
            event := ev
        end
---------------------------------

    set_delta (del : INTEGER) is

        do
            delta := del
        end
---------------------------------

    set_cb (dcb : DISPATCHER_CALLBACK) is

        do
            cb := dcb
        end
---------------------------------
feature { NONE } -- Implementation

    event   : INTEGER
    delta   : INTEGER
    cb      : DISPATCHER_CALLBACK

end -- class TIMER_EVENT

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
