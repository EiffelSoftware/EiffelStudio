indexing

description: "A transport endpoint using the SSL";
keywords: "GIOP framework", "transport", "secure";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_TRANSPORT

inherit
    ORB_STATICS;
    TRANSPORT_CALLBACK;
    TRANSPORT
        redefine
            get_principal, accept, read_to_buffer, write_from_buffer
        end

creation
    make, make1, make2

feature -- Initialization

        make is

            do
            end
----------------------

        make1 (a : SSL_ADDRESS) is

            do
                make2 (a, void)
            end
----------------------

        make2 (a : SSL_ADDRESS; t : TRANSPORT) is

            local
                r : BOOLEAN

            do
                my_transp     := t
                my_local_addr := a
                my_peer_addr  := a
                my_rcb        := void
                my_wcb        := void

--                r := ssl_setup_ctx
--                check
--                    could_setup : r
--                end

--                create my_bio.make (BIO_mico)
--                check
--                    nonvoid_bio : my_bio /= void
--                end

--                my_ssl := SSL_new (ssl_ctx)
--                SSL_set_bio (my_ssl, my_bio, my_bio)
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
            my_transp.rselect (orb.dispatcher, void)
            my_transp.wselect (orb.dispatcher, void)
            my_rcb := void
            my_wcb := void

--            SSL_shutdown (my_ssl)
--            SSL_free (my_ssl)
                -- BIO is freed in SSL_free
                -- XXX what if shutdown cannot be sent immediately ???
        
            my_transp.delete
        end
----------------------

    rselect (disp : DISPATCHER; cb : TRANSPORT_CALLBACK) is

        do
            my_rcb := cb
            if cb /= void then
                my_transp.rselect (disp, current)
            else
                my_transp.rselect (disp, void)
            end
        end
----------------------

    wselect (disp : DISPATCHER; cb : TRANSPORT_CALLBACK) is

        do
            my_wcb := cb
            if cb /= void then
                my_transp.wselect (disp, current)
            else
                my_transp.wselect (disp, void)
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
            my_transp.bind (sa.content)
        end
----------------------

    connect (a : ADDRESS) is

        local
            sa       : SSL_ADDRESS
            blocking : BOOLEAN

        do
            check
                valid_proto : equal (a.proto, "ssl")
            end
            sa ?= a

            blocking := my_transp.is_blocking
            my_transp.set_blocking
            my_transp.connect (sa.content)
--          SSL_connect (my_ssl)

        rescue
            if blocking then
                my_transp.set_blocking
            else
                my_transp.set_nonblocking
            end
        end
----------------------

    accept is

        local
            blocking : BOOLEAN

        do
            blocking := my_transp.is_blocking
            my_transp.set_blocking
--            SSL_accept (my_ssl)
            if blocking then
                my_transp.set_blocking
            else
                my_transp.set_nonblocking
            end
        end
----------------------

    close is

        do
            -- XXX What if shutdown cannot be sent immediately ???
--            SSL_shutdown (my_ssl)
--            SSL_set_connect_state (my_ssl)
            my_transp.close
        end
----------------------

    set_blocking is

        do
            my_transp.set_blocking
        end
----------------------

    set_nonblocking is

        do
            my_transp.set_nonblocking
        end
----------------------

    is_blocking : BOOLEAN is

        do
            result := my_transp.is_blocking
        end
----------------------

    addr : ADDRESS is

        do
        end
----------------------

    peer : ADDRESS is

        do
        end
----------------------

    eof : BOOLEAN is

        do
            result := my_transp.eof
        end
----------------------

    get_fd : INTEGER is

        do
            result := my_transp.get_fd
        end
----------------------

    closed : BOOLEAN is

        do
            result := my_transp.closed
        end
----------------------

    get_principal : SSL_Principal is

        do
--            create {SSL_PRINCIPAL} result.make3 (
--                        SSL_get_peer_certificate (my_ssl),
--                        SSL_get_cipher (my_ssl), current)
        end
----------------------

    read_to_buffer (buf : BUFFER; len : INTEGER) : INTEGER is

        do
--            result := SSL_read (my_ssl, buf, len)
        end
----------------------

    write_from_buffer (buf : BUFFER;
                       len : INTEGER;
                       eat : BOOLEAN) : INTEGER is

        do
--            result := SSL_write (my_ssl, buf, len)
        end
----------------------
feature { SSL_TRANSPORT } -- Implementation

    my_transp     : TRANSPORT
    my_local_addr : SSL_ADDRESS
    my_peer_addr  : SSL_ADDRESS
--    my_bio        : BIO
--    my_ssl        : SSL
    my_rcb        : TRANSPORT_CALLBACK
    my_wcb        : TRANSPORT_CALLBACK
----------------------

    callback_t (t : TRANSPORT; ev : INTEGER) is

        do
            inspect ev

            when Read_ev then
                my_rcb.callback_t (current, ev)

            when Write_ev then
                my_wcb.callback_t (current, ev)

            when Remove_ev then
                if my_rcb /= void then
                    my_rcb.callback_t (current, ev)
                end
                if my_wcb /= void then
                    my_wcb.callback_t (current, ev)
                end
                my_rcb := void
                my_wcb := void
            end
        end
----------------------

    read (buf : POINTER; len : INTEGER) : INTEGER is

        do
            -- not used here
        end
----------------------

    write (buf : POINTER; start, len : INTEGER) : INTEGER is

        do
            -- not used here
        end

end -- class SSL_TRANSPORT

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
