indexing

description: "Parent of all transport server classes.";
keywords: "GIOP framework", "transport";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class TRANSPORT_SERVER

inherit
    EVENT_CONSTANTS

feature

    make is

        deferred

        ensure
            is_open : is_open
        end
------------------------------
feature -- Destruction

    delete is
        -- This is actually a substitute for a destructor.
        -- It calls `close' (see the header comment of close).
        -- Call `delete' when *and only when*
        -- `current' is no longer
        -- needed *by anyone*.
        -- Y'all be real careful now ...

        deferred
        end
------------------------------

    aselect (disp : DISPATCHER; cb : TRANSPORT_SERVER_CALLBACK) is

        require
            is_open     : is_open
            nonvoid_arg : cb /= void implies disp /= void 

        deferred
        end
------------------------------

    bind (a : ADDRESS) is
        -- Establis `a' as the address where `current' will
        -- wait for requests from clients.

        require
            is_open : is_open

        deferred
        end
------------------------------

    close is
        -- NOTE: here is an *important* difference to MICO:
        -- after closing a new `make' is needed if the transport
        -- server object is to be used again. The advantage of this
        -- design is that any C data structures allocated for the
        -- transport server object have been freed. Thus there will be
        -- no memory leak if every transport server object is closed
        -- before being abandoned.

        require
            is_open : is_open

        deferred

        ensure
            not_open : not is_open
        end
------------------------------

    accept : TRANSPORT is
        -- After `listen' returns use this routine
        -- to get a line to the calling client.

        require
            is_open : is_open

        deferred
        end
----------------------------

    set_blocking is

        require
            is_open : is_open

        deferred
        end
----------------------------

    set_nonblocking is

        require
            is_open : is_open

        deferred
        end
----------------------------

    is_blocking : BOOLEAN is

        require
            is_open : is_open

        deferred
        end
----------------------------

    addr : ADDRESS is

        require
            is_open : is_open

        deferred
        end
----------------------------

    get_fd : INTEGER is

        deferred
        end
----------------------------

    is_open : BOOLEAN is

        deferred
        end
----------------------

    errormsg : STRING is

        do
            result := ""
            result.from_c (ext_errormsg)
        end
----------------------
feature { NONE } -- Implementation


    ext_errormsg : POINTER is

        external "C"
        alias "MICO_transport_errormsg"

        end

end -- class TRANSPORT_SERVER

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
