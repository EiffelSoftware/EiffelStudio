indexing

description: "A transport endpoint using TCP";
keywords: "GIOP framework", "transport", "TCP/IP";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TCP_TRANSPORT

inherit
    TRANSPORT;
    DISPATCHER_CALLBACK

creation { ANY }
    make
creation { TRANSPORT_SERVER }
    make_with_fd

feature -- Initialization

    make is

        do
            sock_data := create_tcp_socket
            fd        := ext_get_fd (sock_data)
            ateof     := false
            rdisp     := void
            wdisp     := void
            rcb       := void
            wcb       := void

        end
----------------------

    make_with_fd (file_desc : INTEGER) is

        do
            fd        := file_desc
            sock_data := create_tcp_socket_with_fd (fd)
            ateof     := false
            rdisp     := void
            wdisp     := void
            rcb       := void
            wcb       := void

        ensure
            is_open : not closed
        end
----------------------
feature -- Destruction

    delete is
        -- See the header comment of the precursor.

        do
            if rdisp /= void and then rcb /= void then
                rdisp.remove (current, Read_ev)
                rcb.callback_t (current, Remove_ev)
                rdisp := void
            end
            if wdisp /= void and then wcb /= void then
                wdisp.remove (current, Write_ev)
                wcb.callback_t (current, Remove_ev)
                wdisp := void
            end
            close -- This cleans up the sock_data.
        end
----------------------

    closed : BOOLEAN is

        do
            result := (sock_data = Default_pointer)
        end
----------------------
feature -- Standard Operations

    rselect (disp: DISPATCHER; cb : TRANSPORT_CALLBACK) is

        do
            if rcb /= void and then rdisp /= void then
                rdisp.remove (current, Read_ev)
                rdisp := void
                rcb   := void
            end
            if cb /= void then
                if disp /= void then
                    disp.rd_event (current, fd)
                end
                rdisp := disp
                rcb   := cb
            end
        end
----------------------

    wselect (disp : DISPATCHER; cb: TRANSPORT_CALLBACK) is

        do
            if wcb /= void and then wdisp /= void then
                wdisp.remove (current, Write_ev)
                wdisp := void
                wcb   := void
            end
            if cb /= void then
                if disp /= void then
                    disp.wr_event (current, fd)
                end
                wdisp := disp
                wcb   := cb
            end
        end
----------------------

    bind (a : ADDRESS) is

        local
            ia  : INET_ADDRESS
            sin : SOCKADDR_IN
            r   : BOOLEAN

        do
            check
                is_an_inet_address : equal (a.proto, "inet")
            end
            ia  ?= a
            sin := ia.get_sockaddr
            r := tcp_bind (sock_data, sin.get_port, sin.get_addr )
            check
                success : r
            end
        end
----------------------

    connect (a : ADDRESS) is

        local
            ia  : INET_ADDRESS
            sin : SOCKADDR_IN

        do
            check
                good_proto : equal (a.proto, "inet")
            end
            ia  ?= a
            sin := ia.get_sockaddr
            bad := not tcp_connect (sock_data, sin.get_port, sin.get_addr)
        end
----------------------

    close is
        -- If after `close' you want to go on
        -- using `current', you must reinitialize
        -- with a call to `make'.

        do
            tcp_close (sock_data)
            sock_data := default_pointer
        end
----------------------

    set_blocking is

        do
            bad := not tcp_set_blocking (sock_data, true)
            check
                success : not bad
            end
        end
----------------------

    set_nonblocking is

        do
            bad := not tcp_set_blocking (sock_data, false)
            check
                success : not bad
            end
        end
----------------------

    is_blocking : BOOLEAN is

        do
            
            bad := not tcp_isblocking (sock_data, $result)
            check
                success : not bad
            end
        end
----------------------

    get_fd : INTEGER is

        do
            result := fd
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
                else
                    local_addr.make (sin) -- reinitialize it
                end
                result := local_addr
            end
        end
----------------------

    peer : ADDRESS is

        local
            sin : SOCKADDR_IN
            f   : INTEGER
            p   : INTEGER
            a   : POINTER

        do
             if getpeername (sock_data, $f, $p, $a) then
                 create sin.make (f, p, a)
                 if peer_addr = void then
                     create peer_addr.make (sin)
                 else
                     peer_addr.make (sin) -- reinitialize it
                 end
             else -- disconnect has already happened ...
                 peer_addr := void
             end
             result := peer_addr
        end
----------------------

    eof : BOOLEAN is

        do
             result := ateof
        end
----------------------
feature -- The operation that makes this a callback

    callback_d (d : DISPATCHER; ev : INTEGER) is

        do
            inspect (ev)

            when Read_ev then
                check
                    rcb_nonvoid : rcb /= void
                end
                rcb.callback_t (current, Read_ev)

            when Write_ev then
                check
                    wcb_nonvoid : wcb /= void
                end
                wcb.callback_t (current, Write_ev)

            when Remove_ev then
                wdisp := void
                rdisp := void
                wcb   := void
                rcb   := void

            end
        end
----------------------
feature {TCP_TRANSPORT } -- Implementation

    Bufsize : INTEGER is 1024
        -- This constant should under no circumstances be larger
        -- than the constant MAXBUF in transport.c.

    rdisp        : DISPATCHER
    wdisp        : DISPATCHER
    rcb          : TRANSPORT_CALLBACK
    wcb          : TRANSPORT_CALLBACK
    fd           : INTEGER
    ateof        : BOOLEAN
    local_addr   : INET_ADDRESS
    peer_addr    : INET_ADDRESS
    sock_data    : POINTER

----------------------
feature { NONE } -- Implementation

    read (buf : POINTER; len : INTEGER) : INTEGER is

        do
            result := tcp_read (sock_data, buf, len)
            ateof  := ext_eof (sock_data)
        end
----------------------

    write (buf : POINTER; start, len : INTEGER) : INTEGER is

        do
            result := tcp_write (sock_data, buf, start, len)
        end
----------------------

    create_tcp_socket : POINTER is

        external "C"
        alias "MICO_create_tcp_socket"

        end
----------------------

    create_tcp_socket_with_fd (ile_desc : INTEGER) : POINTER is

        external "C"
        alias "MICO_create_tcp_socket_with_fd"

        end
----------------------

    ext_get_fd (sp : POINTER) : INTEGER is

        external "C"
        alias "MICO_tcp_get_fd"

        end
----------------------

    tcp_bind (sp : POINTER; p : INTEGER; a : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_bind"

        end
----------------------

    tcp_connect (sp : POINTER; p : INTEGER; a : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_connect"

        end
----------------------

    tcp_close (sp : POINTER) is

        external "C"
        alias "MICO_tcp_close"

        end
----------------------

    tcp_set_blocking (sp : POINTER; doblock : BOOLEAN) : BOOLEAN is

        external "C"
        alias "MICO_tcp_set_blocking"

        end
----------------------

    tcp_isblocking (sp, ip : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_isblocking"

        end
----------------------

    tcp_read (sp, bf : POINTER; len : INTEGER) : INTEGER is

        external "C"
        alias "MICO_tcp_read"

        end
----------------------

    tcp_write (sp, bf : POINTER; strt, len : INTEGER) : INTEGER is

        external "C"
        alias "MICO_tcp_write"

        end

----------------------

    ext_eof (sp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_eof"

        end
----------------------

    getsockname (sp, fp, pp, ap : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_getsockname"

        end
----------------------

    getpeername (sp, fp, pp, ap : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_tcp_getpeername"

        end

end -- class TCP_TRANSPORT

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
