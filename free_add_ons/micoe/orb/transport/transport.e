indexing

description: "Parent of all transport classes";
keywords: "GIOP framework", "transport";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class TRANSPORT

inherit
    EVENT_CONSTANTS

feature

    make is

        deferred

        ensure
            is_open : not closed
        end
----------------------
feature -- Destruction

    delete is
        -- This is actually a substitute for a destructor.
        -- It calls `close' (see the header comment of close).
        -- To be called when *and only when* `current'
        -- is no longer needed *by anybody*.
        -- Y'all be real careful now ...

        deferred
        end
----------------------

    closed : BOOLEAN is

        deferred
        end
----------------------

    rselect (disp : DISPATCHER; cb : TRANSPORT_CALLBACK) is

        require
            nonvoid_arg : cb /= void implies disp /= void

        deferred
        end
----------------------

    wselect (disp : DISPATCHER; cb : TRANSPORT_CALLBACK) is

        require
            nonvoid_arg : cb /= void implies disp /= void

        deferred
        end
----------------------

    bind (a : ADDRESS) is
        -- IMHO this is something needed only by
        -- TRANSPORT_SERVERS; I don't understand what
        -- it's doing in this class???

        require
            is_open : not closed

        deferred
        end
----------------------

    connect (a : ADDRESS) is

        require
            is_open : not closed

        deferred
        end
----------------------

    accept is

        do
            -- SSL_TRANSPORT redefines this routine. The
            -- other kinds of transport don't need it.
        end
----------------------

    close is
        -- NOTE: here is an *important* difference to MICO:
        -- after closing a new `make' is needed if the transport
        -- object is to be used again. The advantage of this
        -- design is that any C data structures allocated for the
        -- transport object have been freed. Thus there will be no
        -- memory leak if every transport object is closed before
        -- being abandoned.

        require
            is_open : not closed

        deferred

        ensure
            not_open : closed
        end
----------------------

    set_blocking is

        require
            not_closed : not closed

        deferred
        end
----------------------

    set_nonblocking is

        require
            is_open : not closed

        deferred
        end
----------------------

    is_blocking : BOOLEAN is

        require
            is_open : not closed

        deferred
        end
----------------------

    read_to_buffer (buf : BUFFER; len : INTEGER) : INTEGER is

        require
            is_open  : not closed
            writable : not buf.readonly

        local
            r : BOOLEAN

        do
            r := buf.resize (len)
            check
                did_resize : r
            end

            result := read (buf.buf_data, len)

            debug ("MICO_BUFFER")
                buf.dump_buffer
            end

            if result > 0 then
                buf.wseek_rel (result)
            end
        end
----------------------

    write_from_buffer (buf : BUFFER;
                       len : INTEGER;
                       eat : BOOLEAN) : INTEGER is

        require
            is_open : not closed

        do
            result := write (buf.buf_data, buf.rpos, len)
            if result > 0 and eat then
                buf.rseek_rel (result)
            end
        end
----------------------

    get_fd : INTEGER is

        deferred
        end
----------------------

    addr : ADDRESS is

        require
            is_open : not closed

        deferred
        end
----------------------

    peer : ADDRESS is

        require
            is_open : not closed

        deferred
        end
----------------------

    eof : BOOLEAN is

        require
            is_open : not closed

        deferred
        end
----------------------------

    get_principal : PRINCIPAL is

        do
            create result.make_with_transport (current)
        end
----------------------

    bad : BOOLEAN
----------------------

    errormsg : STRING is

        do
            result := ""
            result.from_c (ext_errormsg)
        end
----------------------
feature { NONE } -- Implementation

    read (buf : POINTER; len : INTEGER) : INTEGER is

        require
            is_open     : not closed

        deferred
        end
----------------------

    write (buf : POINTER; start, len : INTEGER) : INTEGER is

        require
            is_open : not closed

        deferred
        end
----------------------

    ext_errormsg : POINTER is

        external "C"
        alias "MICO_transport_errormsg"

        end

end -- class TRANSPORT

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
