indexing

description: "Receives transport requests on the server side and creates %
             %a new transport endpoint to communicate with the client.";
keywords: "transport", "unix domain";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNIX_TRANSPORT_SERVER

inherit
    TRANSPORT_SERVER;
    DISPATCHER_CALLBACK;
    THE_LOGGER

creation
    make

feature

    make is

        do
            sock_data := create_unix_serv_socket
            listening := false
            fd        := ext_get_fd (sock_data)
            adisp     := void
            acb       := void
        end
------------------------------
feature -- Cleaning up

    delete is
        -- See the header comment of the precursor.

        do
            if adisp /= void and then acb /= void then
                adisp.remove (current, Read_ev)
                acb.callback_ts (current, Remove_ev)
                adisp := void
            end
            close -- This cleans up the sock_data.
        end
------------------------------

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
------------------------------

    bind (a : ADDRESS) is

        local
            ua  : UNIX_ADDRESS
            sun : SOCKADDR_UN
            exs : ANY
            r   : BOOLEAN
            log : IO_MEDIUM

        do
            check
                is_a_unix_address : equal (a.proto, "unix")
            end
            ua  ?= a
            -- XXX A comment in the C++ code says "should do this
            -- after the socket is destroyed ..."; and we do
            -- precisely that (in the C code of `ext_close').
            exs := ua.get_filename.to_c
            unlink ($exs)

            sun := ua.get_sockaddr
            exs := sun.get_path.to_c
            r   := ext_bind (sock_data, $exs)

            if not r then
                log := logger.log (logger.Log_err, "General",
                                   "UNIX_TRANSPORT_SERVER", "bind")
                log.put_string (errormsg)
                log.new_line
            end
            check
                success : r
            end
        end
------------------------------

    close is
        -- See the header comment of the precursor.

        do
            ext_close (sock_data) -- also unlinks filename
                                  -- used for binding.
            sock_data := default_pointer
        end
------------------------------

    accept : TRANSPORT is

        local
            newfd : INTEGER
            log   : IO_MEDIUM

        do
            if ext_accept (sock_data, $newfd) then
                create {UNIX_TRANSPORT} result.make_with_fd (newfd)

                log := logger.log (logger.Log_info, "General",
                                   "UNIX_TRANSPORT_SERVER", "accept")
                log.put_string ("Unix transport server with fd ")
                log.putint (fd)
                log.put_string (" connected to unix transport with fd ")
                log.putint (newfd)
                log.new_line
            end
        end
----------------------------

    set_blocking is

        local
            r : BOOLEAN

        do
            r := ext_set_blocking (sock_data, true)
            check
                success : r
            end
        end
----------------------------

    set_nonblocking is

        local
            r : BOOLEAN

        do
            r := ext_set_blocking (sock_data, false)
            check
                success : r
            end
        end
----------------------------

    is_blocking : BOOLEAN is

        local
            r : BOOLEAN

        do
            r := ext_isblocking (sock_data, $result)
            check
                success : r
            end
        end
----------------------------

    addr : ADDRESS is

        local
            sun  : SOCKADDR_UN
            f    : INTEGER
            p    : POINTER
            path : STRING

        do
            if getsockname (sock_data, $f, $p) then
                path := ""
                path.from_c (p)
                create sun.make (path, f)
                if local_addr = void then
                    create local_addr.make (sun)
                else -- reinitialize
                    local_addr.make (sun)
                end
                result := local_addr
            end
        end
----------------------------

    get_fd : INTEGER is

        do
            result := fd
        end
----------------------------

    is_open : BOOLEAN is

        do
            result := (sock_data /= default_pointer)
        end
----------------------------
feature -- This routine makes this a DISPATCHER_CALLBACK

    callback_d (disp : DISPATCHER; ev : INTEGER) is

        do
            inspect (ev)
 
            when Read_ev then
                check
                    acb_nonvoid : acb /= void
                end
                acb.callback_ts (current, Accept_ev)

            when Remove_ev then
                adisp := void
                acb   := void

            end
        end
----------------------------
feature { NONE } -- Implementation

    sock_data  : POINTER
    fd         : INTEGER
    adisp      : DISPATCHER
    acb        : TRANSPORT_SERVER_CALLBACK
    listening  : BOOLEAN
    action     : ACTION
    local_addr : UNIX_ADDRESS
----------------------------

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
----------------------------

    create_unix_serv_socket : POINTER is

        external "C"
        alias "MICO_create_unix_serv_socket"

        end
----------------------------

    ext_get_fd (sp : POINTER) : INTEGER is

        external "C"
        alias "MICO_unix_get_fd"

        end
----------------------------

    ext_bind (sp, pp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_bind"

        end
----------------------------

    ext_close (sp : POINTER) is

        external "C"
        alias "MICO_unix_close"

        end
----------------------------

    ext_set_blocking (sp : POINTER; doblock : BOOLEAN) : BOOLEAN is

        external "C"
        alias "MICO_unix_set_blocking"

        end
----------------------------

    ext_isblocking (sp, bp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_isblocking"

        end
----------------------------

    ext_accept (sp, ip : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_accept"

        end
----------------------------

    ext_listen (sp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_listen"

        end
----------------------------

    getsockname (sp, fp, pp : POINTER) : BOOLEAN is

        external "C"
        alias "MICO_unix_getsockname"

        end
----------------------------

    unlink (fn : POINTER) is

        external "C"
        alias "MICO_unlink"

        end

end -- class UNIX_TRANSPORT_SERVER

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
