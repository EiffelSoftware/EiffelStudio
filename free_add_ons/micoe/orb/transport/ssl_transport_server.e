indexing

description: "Receives transport requests on the server side and creates %
             %a new transport object to handle the request.";
keywords: "GIOP framework", "transport", "secure";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_TRANSPORT_SERVER

inherit
    ORB_STATICS;
    TRANSPORT_SERVER_CALLBACK;
    TRANSPORT_SERVER

creation
    make, ssl_make

feature -- Initialization

    make is

        do
            check
                never_called : false
            end
        end
----------------------

    ssl_make (a : SSL_ADDRESS) is

        do
            my_server     := a.content.make_transport_server
            my_local_addr := a
            my_acb        := void
        end
----------------------
feature -- Destruction

    delete is

        local
            theo : THE_ORB
            orb  : ORB

        do
            create theo.make (0, void, "")
            orb := theo.ORB_instance
            my_server.aselect (orb.dispatcher, void)
            my_acb := void
            my_server.delete
        end
----------------------

    aselect (disp : DISPATCHER; cb : TRANSPORT_SERVER_CALLBACK) is

        do
            my_acb := cb

            if cb /= void then
                my_server.aselect (disp, current)
            else
                my_server.aselect (disp, void)
            end
        end
----------------------

    bind (a : ADDRESS) is

        local
            sa : SSL_ADDRESS

        do
            check
                valid_proto : equal (a.proto, "ssl")
            end
            sa ?= a
            my_server.bind (sa.content)
        end
----------------------

    accept : TRANSPORT is

        local
            t : TRANSPORT

        do
            t := my_server.accept
            if t /= void then
                create {SSL_TRANSPORT} result.make2 (my_local_addr, t)
            end
            result.accept
        end
----------------------

    close is

        do
            my_server.close
        end
----------------------

    set_blocking is

        do
            my_server.set_blocking
        end
----------------------

    set_nonblocking is

        do
            my_server.set_nonblocking
        end
----------------------

    is_blocking : BOOLEAN is

        do
            result := my_server.is_blocking
        end
----------------------

    addr : ADDRESS is

        do
            result := my_local_addr
        end
----------------------

    is_open : BOOLEAN is

        do
            result := my_server.is_open
        end
----------------------

    get_fd : INTEGER is

        do
            result := my_server.get_fd
        end
----------------------
feature { SSL_TRANSPORT_SERVER } -- Implementation

    my_server     : TRANSPORT_SERVER
    my_local_addr : SSL_ADDRESS
    my_acb        : TRANSPORT_SERVER_CALLBACK
----------------------

    callback_ts (ts : TRANSPORT_SERVER; ev : INTEGER) is

        do
            inspect ev

            when Accept_ev then
                my_acb.callback_ts (current, ev)

            when Remove_ev then
                my_acb.callback_ts (current, ev)
                my_acb := void
            end
        end

end -- class SSL_TRANSPORT_SERVER

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
