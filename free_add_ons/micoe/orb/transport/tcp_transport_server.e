indexing

description: "Receives transport requests on the server side and creates %
             %a new transport endpoint to communicate with the client.";
keywords: "GIOP framework", "transport", "TCP/IP";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TCP_TRANSPORT_SERVER

inherit
    TRANSPORT_SERVER;
    THE_LOGGER;
    DISPATCHER_CALLBACK

creation
    make

feature

    make is

        do
            sock_data := create_serv_socket
            fd        := ext_get_fd (sock_data)
            listening := false
            adisp     := void
            acb       := void
        end
----------------------
feature -- Destruction

    delete is
        -- See the header comment of the precursor.

        do
            if adisp /= void and then acb /= void then
                adisp.remove (current, Read_ev)
                acb.callback_ts (current, Remove_ev)
                adisp := void
            end
            close
        end
----------------------

    closed : BOOLEAN is

        do
            result := (sock_data = Default_pointer)
        end
----------------------

    aselect (disp : DISPATCHER; cb : TRANSPORT_SERVER_CALLBACK) is

        do
            if acb /= void and then adisp /= void then
                adisp.remove (current, Read_ev)
                adisp := void
                acb   := void
            end
            if cb /= void then
                listen
                disp.rd_event (current, fd)
                adisp := disp
                acb   := cb
            end
        end
----------------------

    bind (a : ADDRESS) is

        local
            ia  : INET_ADDRESS
            sin : SOCKADDR_IN
            r   : BOOLEAN
            log : IO_MEDIUM

        do
            check
                is_an_inet_address : equal (a.proto, "inet")
            end
            ia  ?= a
            sin := ia.get_sockaddr
            r := ext_bind (sock_data, sin.get_port, sin.get_addr)
            if not r then
                log := logger.log (logger.Log_err, "General", 
                                  "TCP_TRANSPORT_SERVER", "bind")
                log.put_string (errormsg)
                log.new_line
            end
            check
                success : r
            end
        end
----------------------

    close is
        -- See the header comment of the precursor.

        do
            ext_close (sock_data)
            sock_data := default_pointer
        end
----------------------

    accept : TRANSPORT is

        local
            newfd : INTEGER

        do
            if ext_accept (sock_data, $newfd) then
                create {TCP_TRANSPORT} result.make_with_fd (newfd)
            end
        end
----------------------

    set_blocking is

        local
            r : BOOLEAN
        do
            r := ext_set_blocking (sock_data, true)
            check
                success : r
            end
        end
----------------------

    set_nonblocking is

        local
            r : BOOLEAN

        do
            r := ext_set_blocking (sock_data, false)
            check
                success : r
            end
        end
----------------------

    is_blocking : BOOLEAN is

        local
            r : BOOLEAN

        do
            r := ext_isblocking (sock_data, $result)
            check
                success : r
            end
        end
----------------------

    addr : ADDRESS is

        local
            sin : SOCKADDR_IN
            f   : INTEGER
            p   : INTEGER
            a   : POINTER

        do
            if getsockname (sock_data, $f, $p, $a) then
                create sin.make (f, p, a)
                if local_addr = void then
                    create local_addr.make (sin)
                else -- reinitialize
                    local_addr.make (sin)
                end
                result := local_addr
            end
        end
----------------------

    get_fd : INTEGER is

        do
            result := fd
        end
----------------------

    is_open : BOOLEAN is

        do
            result := (sock_data /= default_pointer)
        end
----------------------
feature -- The operation that makes this a callback

    callback_d (disp : DISPATCHER; ev : INTEGER) is

        do
           inspect (ev)

           when Read_ev then
               acb.callback_ts (current, Accept_ev)

           when Remove_ev then
               acb   := void
               adisp := void

           end
        end
----------------------
feature { TCP_TRANSPORT_SERVER } -- Implementation

    adisp      : DISPATCHER
    acb        : TRANSPORT_SERVER_CALLBACK
    fd         : INTEGER
    listening  : BOOLEAN
    local_addr : INET_ADDRESS
    sock_data  : POINTER
----------------------

    listen is
        -- Lie in wait for calls from a client.
        -- `listen' does not return until such
        -- a call arrives.

        local
            r : BOOLEAN

        do
            if not listening then
                r := ext_listen (sock_data)
                check
                    success : r
                end
                listening := true
            end
        end
----------------------

    create_serv_socket : POINTER is

        external "C"
        alias " MICO_create_tcp_serv_socket"

        end
----------------------

    ext_get_fd (sp : POINTER) : INTEGER is

        external "C"
        alias "MICO_tcp_get_fd"

        end
----------------------

    ext_listen (sp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_listen"

        end
----------------------

    ext_bind (sp : POINTER; p : INTEGER; a : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_bind"

        end
----------------------

    ext_close (sp : POINTER) is

        external "C"
        alias "MICO_tcp_close"

        end
----------------------

    ext_set_blocking (sp : POINTER; doblock : BOOLEAN) : BOOLEAN is

        external "C"
        alias "MICO_tcp_set_blocking"

        end
----------------------

    ext_isblocking (sp, bp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_isblocking"

        end
----------------------

    ext_accept (sp, ip : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_accept"

        end
----------------------

    getsockname (sp, fp, pp, ap : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_getsockname"

        end

end -- class TCP_TRANSPORT_SERVER

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
