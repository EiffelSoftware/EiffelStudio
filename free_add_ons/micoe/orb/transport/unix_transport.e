indexing

description: "A transport endpoint using unix domain sockets.";
keywords: "GIOP framework", "transport";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNIX_TRANSPORT

inherit
    TRANSPORT;
    THE_LOGGER;
    DISPATCHER_CALLBACK

creation { ANY }
    make

creation { TRANSPORT_SERVER }
    make_with_fd

feature -- Initialization

    make is

        local
            log : IO_MEDIUM

        do
            sock_data := create_unix_socket
            fd        := ext_get_fd (sock_data)

            log := logger.log (logger.Log_info, "General", 
                               "UNIX_TRANSPORT", "make")
            log.put_string ("Unix transport with fd ")
            log.putint (fd)
            log.put_string (" opened%N")

            rdisp     := void
            wdisp     := void
            rcb       := void
            wcb       := void
            ateof     := false
        end
----------------------

    make_with_fd (file_desc : INTEGER) is

        local
            log : IO_MEDIUM

        do
            fd        := file_desc
            sock_data := create_unix_socket_with_fd (fd)

            log := logger.log (logger.Log_info, "General", 
                               "UNIX_TRANSPORT", "make_with_fd")
            log.put_string ("Unix transport with fd ")
            log.putint (fd)
            log.put_string (" opened%N")

            rdisp     := void
            wdisp     := void
            rcb       := void
            wcb       := void
            ateof     := false

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
feature -- Standard Operations

    rselect (disp : DISPATCHER; cb : TRANSPORT_CALLBACK) is

        do
            if rdisp /= void and then rcb /= void then
                rdisp.remove (current, Read_ev)
                rdisp := void
                rcb   := void
            end
            if cb /= void then
                disp.rd_event (current, fd)
                rdisp := disp
                rcb   := cb
            end
        end
----------------------

    wselect (disp : DISPATCHER; cb : TRANSPORT_CALLBACK) is

        do
            if wdisp /= void and then wcb /= void then
                wdisp.remove (current, Write_ev)
                wdisp := void
                wcb   := void
            end
            if cb /= void then
                disp.wr_event (current, fd)
                wdisp := disp
                wcb   := cb
            end
        end
----------------------

    bind (a : ADDRESS) is

        local
            ua  : UNIX_ADDRESS
            sun : SOCKADDR_UN
            exs : ANY

        do
            check
                is_a_unix_address : equal (a.proto, "unix")
            end
            ua  ?= a

            -- XXX The C++ code has a comment "Should do this after
            -- the socket is destroyed ..."
            exs := ua.get_filename.to_c
            unlink ($exs)

            sun := ua.get_sockaddr
            exs := sun.get_path.to_c
            bad := not unix_bind (sock_data, $exs)
            check
                success : not bad
            end
        end
----------------------

    connect (a : ADDRESS) is

        local
            ua  : UNIX_ADDRESS
            sun : SOCKADDR_UN
            exs : ANY

        do
            check
                is_a_unix_address : equal (a.proto, "unix")
            end
            ua  ?= a
            sun := ua.get_sockaddr
            exs := sun.get_path.to_c
            bad := not unix_connect (sock_data, $exs)
        end
----------------------

    close is

        local
            log : IO_MEDIUM

        do
            log := logger.log (logger.Log_info, "General",
                               "UNIX_TRANSPORT", "close")
            log.put_string ("Unix transport with fd ")
            log.putint (fd)
            log.put_string (" now closing%N")

            unix_close (sock_data)
            sock_data := default_pointer
        end
----------------------

    set_blocking is

        do
            bad := not unix_set_blocking (sock_data, true)
            check
                success : not bad
            end
        end
----------------------

    set_nonblocking is

        do
            bad := not unix_set_blocking (sock_data, false)
            check
                success : not bad
            end
        end
----------------------

    is_blocking : BOOLEAN is

        do
            bad := not unix_isblocking (sock_data, $result)
            check
                success : not bad
            end
        end
----------------------

    addr : ADDRESS is

        local
            sun  : SOCKADDR_UN
            f    : INTEGER
            p    : POINTER
            path : STRING
            r    : BOOLEAN

        do
            if getsockname (sock_data, $f, $p) then
                path := ""
                path.from_c (p)
                create sun.make (path, f)
                if local_addr = void then
                    create local_addr.make (sun)
                else
                    local_addr.make (sun) -- reinitialize it
                end
                result := local_addr
             end
        end
----------------------

    peer : ADDRESS is

        local
            sun  : SOCKADDR_UN
            f    : INTEGER
            p    : POINTER
            path : STRING

        do
            if getpeername (sock_data, $f, $p) then
                path := ""
                path.from_c (p)
                create sun.make (path, f)
                if peer_addr = void then
                    create peer_addr.make (sun)
                else
                    peer_addr.make (sun) -- reinitialize it
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

    closed : BOOLEAN is

        do
            result := (sock_data = default_pointer)
        end
----------------------

    get_fd : INTEGER is

        do
            result := fd
        end
----------------------
feature -- This routine makes this a dispatcher callback

    callback_d (disp : DISPATCHER; ev : INTEGER) is

        do
           inspect (ev)

           when Read_ev then
               rcb.callback_t (current, Read_ev)

           when Write_ev then
               wcb.callback_t (current, Write_ev)

           when Remove_ev then
               wdisp := void
               rdisp := void
               wcb   := void
               rcb   := void

           end
        end
----------------------
feature {UNIX_TRANSPORT } -- Implementation

    Bufsize : INTEGER is 1024
        -- In no case may this constant be smaller than
        -- the constant MAXBUF in transport.c.

    ateof        : BOOLEAN
    fd           : INTEGER
    rdisp        : DISPATCHER
    wdisp        : DISPATCHER
    rcb          : TRANSPORT_CALLBACK
    wcb          : TRANSPORT_CALLBACK
    local_addr   : UNIX_ADDRESS
    peer_addr    : UNIX_ADDRESS
    sock_data    : POINTER
----------------------
feature { NONE } -- Implementation

    read (buf : POINTER; len : INTEGER) : INTEGER is

        local
            log : IO_MEDIUM

        do
            result := unix_read (sock_data, buf, len)
            ateof  := ext_eof (sock_data)

            log := logger.log (logger.Log_info, "General", 
                               "UNIX_TRANSPORT", "read")
            log.put_string ("Unix transport with fd ")
            log.putint (fd)
            log.put_string (" read ")
            log.putint (result)
            log.put_string (" bytes")
            if result = 0 then
                log.put_string ("; eof = ")
                log.put_boolean (ateof)
            end
            log.new_line
        end
----------------------

    write (buf : POINTER; start, len : INTEGER) : INTEGER is

        local
            log : IO_MEDIUM

        do
            result := unix_write (sock_data, buf, start, len)

            log := logger.log (logger.Log_info, "General",
                               "UNIX_TRANSPORT", "write")
            log.put_string ("Unix transport with fd ")
            log.putint (fd)
            log.put_string (" wrote ")
            log.putint (result)
            log.put_string (" bytes%N")
        end
----------------------

    create_unix_socket : POINTER is

        external "C"
        alias "MICO_create_unix_socket"

        end
----------------------

    create_unix_socket_with_fd (file_desc : INTEGER) : POINTER is

        external "C"
        alias "MICO_create_unix_socket_with_fd"

        end
----------------------

    ext_get_fd (sp : POINTER) : INTEGER is

        external "C"
        alias "MICO_unix_get_fd"

        end
----------------------

    unix_bind (sp, pp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_bind"

        end
----------------------

    unix_connect (sp, pp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_connect"

        end
----------------------

    unix_close (sp : POINTER) is

        external "C"
        alias "MICO_unix_close"

        end
----------------------

    unix_set_blocking (sp : POINTER; doblock : BOOLEAN) : BOOLEAN is

        external "C"
        alias "MICO_unix_set_blocking"

        end
----------------------

    unix_isblocking (sp, bp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_isblocking"

        end
----------------------

    unix_read (sp, bf : POINTER; len : INTEGER) : INTEGER is

        external "C"
        alias "MICO_unix_read"

        end
----------------------

    unix_write (sp, bf : POINTER; strt, len : INTEGER) : INTEGER is

        external "C"
        alias "MICO_unix_write"

        end
----------------------

    ext_eof (sp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_eof"

        end
----------------------

    getsockname (sp, fp, pp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_getsockname"

        end
----------------------

    getpeername (sp, fp, pp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_getpeername"

        end
----------------------

    unlink (fn : POINTER) is

        external "C"
        alias "MICO_unlink"

        end

end -- class UNIX_TRANSPORT

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
