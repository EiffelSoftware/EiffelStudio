indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class IIOP_PROXY

inherit
    GIOP_CONSTANTS;
    THE_LOGGER;
    ORB_STATICS;
    IOR_STATICS;
    OBJECT_ADAPTER;
    GIOP_CONN_CALLBACK

creation
    make

feature -- Initialization

    make (o : ORB) is

        do
            -- These are the IOR profile types we can handle.
            -- They are sorted by priority, i. e. we will
            -- first try to use valid_profiles.at (1),
            -- then valid_profiles.at (2), ...
            create valid_profiles.make (false)
            valid_profiles.append (Tag_unix_iop)
            valid_profiles.append (Tag_internet_iop)
            valid_profiles.append (Tag_ssl_unix_iop)
            valid_profiles.append (Tag_ssl_internet_iop)

            my_orb := o
            my_orb.register_oa (current)
            create conns.make
            create ids.make
        end
----------------------

    get_oaid : STRING is

        do
            result := "mico-iiop-proxy"
        end
----------------------

    has_object (obj : CORBA_OBJECT) : BOOLEAN is

        local
            ior  : IOR
            i, n : INTEGER

        do
            -- we have every object whose IOR has a profile tag
            -- that is listed in valid_profiles. we don't need to
            -- check the concrete address, bcause the orb will
            -- will ask local object adapters first ...
            from
                ior := obj.get_ior
                i   := valid_profiles.low_index
                n   := valid_profiles.high_index
            until
                i > n or else result
            loop
                result :=
                  (ior.profile1 (valid_profiles.at (i)) /= void)
                i := i + 1
            end
        end
----------------------

    address_used_for_object (obj : CORBA_OBJECT) : ADDRESS is
        -- Used by ORB to find out where `current' would send
        -- an invocation for `obj'.

        local
            i, n : INTEGER
            prof : IOR_PROFILE
            ior  : IOR

        do
            from
                ior := obj.get_ior
                i   := valid_profiles.low_index
                n   := valid_profiles.high_index
            until
                i > n or else (result /= void)
            loop
                prof := ior.profile1 (valid_profiles.at (i))
                if prof/= void then
                    result := prof.addr
                end
                i := i + 1
            end
        end
----------------------

    is_local : BOOLEAN is

        do -- result = false
        end
----------------------

    invoke5 (msgid        : INTEGER;
             obj          : CORBA_OBJECT;
             req          : ORB_REQUEST;
             pr           : PRINCIPAL;
             response_exp : BOOLEAN) : BOOLEAN is

        local
            gconn  : GIOP_CONNECTION
            ex     : COMM_FAILURE
            csid   : INTEGER
            csidr  : INTEGER_REF
            wcsid  : INTEGER
            wcsidr : INTEGER_REF
            conv   : CODESET_CONVERTER
            wconv  : CODESET_CONVERTER
            greq   : GIOP_REQUEST
            r      : BOOLEAN
            outc   : GIOP_OUT_CONTEXT
            rec    : IIOP_PROXY_INVOKE_RECORD

        do
            gconn := make_conn_obj (obj)

            if gconn = void then
                create ex.make
                req.set_out_args_ex (ex)
                my_orb.answer_invoke (msgid, Invoke_sys_ex, void, req)
            else
                -- set up code set converters
                if equal (req.type, "giop") then
                    -- it's a GIOP request, use code sets that the
                    -- client selected
                    greq  ?= req
                    csid  := greq.csid
                    wcsid := greq.wcsid
                    if csid /= 0 then
                        conv := the_codeset_db.find (csid, csid)
                    end
                    if wcsid /= 0 then
                        wconv := the_codeset_db.find (wcsid, wcsid)
                    end
                else -- run code set selection algorithm
                    create csidr
                    create wcsidr
                    r     := get_codeset_ids (obj, csidr, wcsidr)
                    check
                        got_codeset_ids : r
                    end
                    csid  := csidr.item
                    wcsid := wcsidr.item
                    if csid /= 0 then
                        conv := the_codeset_db.find
                                    (special_cs (Native_cs).id, csid)
                    end
                    if wcsid /= 0 then
                        wconv := the_codeset_db.find
                                      (special_cs (Native_wcs).id, wcsid)
                    end
                end -- if equal (req.type, "giop") then ...
                create outc.make3 (gconn.codec, conv, wconv)
                r := gconn.codec.put_invoke_request (outc, msgid,
                                            response_exp, obj, req, pr)

                if response_exp then
                    create rec.make4 (gconn, req, csid, wcsid)
                    add_invoke (msgid, rec)
                end
                gconn.output_from_buffer (outc.retn)
                result := true
            end -- if gconn /= void then ...
        end
----------------------

    bind (msgid  : INTEGER;
          repoid : STRING;
          oid    : ARRAY [INTEGER];
          addr   : ADDRESS) : BOOLEAN is

        local
            gconn : GIOP_CONNECTION
            outc  : GIOP_OUT_CONTEXT
            rec   : IIOP_PROXY_INVOKE_RECORD
            dum   : BOOLEAN

        do
            if addr /= void and then not addr.is_local then
                gconn := make_conn_addr (addr)
                if gconn = void then
                    my_orb.answer_bind (msgid, Locate_unknown, void)
                    result := true
                else
                    create outc.make1 (gconn.codec)
                    dum := gconn.codec.put_bind_request
                                     (outc, msgid, repoid, oid)
                    check
                        fresh_msgid : not ids.has (msgid)
                    end
                    create rec.make1 (gconn)
                    add_invoke (msgid, rec)
                    gconn.output_from_buffer (outc.retn)
                    result := true
                end -- if gconn = void then ...
            end -- if addr /= void and then ...
        end
----------------------

    locate (msgid : INTEGER;
            obj   : CORBA_OBJECT) is

        local
            gconn : GIOP_CONNECTION
            outc  : GIOP_OUT_CONTEXT
            rec   : IIOP_PROXY_INVOKE_RECORD
            dum   : BOOLEAN

        do
            gconn := make_conn_obj (obj)
            if gconn /= void then
                my_orb.answer_locate (msgid, Locate_unknown, void) 
            else
                create outc.make1 (gconn.codec)
                dum := gconn.codec.put_locate_request (outc, msgid, obj)
                check
                    fresh_msgid : not ids.has (msgid)
                end
                create rec.make1 (gconn)
                add_invoke (msgid, rec)
                gconn.output_from_buffer (outc.retn)
            end -- if gconn /= void then ...
        end
----------------------

    skeleton (obj : CORBA_OBJECT) : CORBA_OBJECT is

        do
        end
----------------------

    cancel (msgid : INTEGER) is

        local
            rec  : IIOP_PROXY_INVOKE_RECORD
            outc : GIOP_OUT_CONTEXT
            dum  : BOOLEAN

        do
            rec := get_invoke (msgid)
            if rec /= void then
                create outc.make1 (rec.get_conn.codec)
                dum := rec.get_conn.codec.put_cancel_request (outc, msgid)
                rec.get_conn.output_from_buffer (outc.retn)
                del_invoke (msgid)
            end -- if rec /= void then
        end
----------------------

    shutdown (wait_for_completion : BOOLEAN) is

        do
            -- XXX make sure all invocations have completed
            my_orb.answer_shutdown (current)
        end
----------------------

    answer_invoke (n    : INTEGER;
                   o    : CORBA_OBJECT;
                   req  : ORB_REQUEST;
                   stat : INTEGER) is

        do
            check
                never_called : false
            end
        end
----------------------

    callback_g (gconn : GIOP_CONNECTION; ev : INTEGER) is

        local
            log : IO_MEDIUM

        do
            inspect ev

            when GIOP_Input_ready then
                handle_input (gconn)

            when GIOP_Idle then
                log := logger.log (logger.Log_info, "General", "IIOP_PROXY",
                                                                "callback_g")
                log.put_string ("Shutting down idle connection with fd ")
                log.putint (gconn.transport.get_fd)
                log.new_line
                kill_conn (gconn)

            when GIOP_Closed then
                log := logger.log (logger.Log_info, "General", "IIOP_PROXY",
                                                                "callback_g")
                log.put_string ("Connection with fd ")
                log.putint (gconn.transport.get_fd)
                log.put_string (" closed or broken%N")
                kill_conn (gconn)

            end -- inspect
        end    
----------------------
feature { NONE } -- Implementation

    valid_profiles : INDEXED_LIST [INTEGER]
    ids            : DICTIONARY [IIOP_PROXY_INVOKE_RECORD, INTEGER]
    conns          : DICTIONARY [GIOP_CONNECTION, ADDRESS]
    my_orb         : ORB
----------------------

    get_codeset_ids (o : CORBA_OBJECT; csid, wcsid : INTEGER_REF) : BOOLEAN is

        require
            nonvoid_args : o    /= void and then
                           csid /= void and then
                           wcsid /= void

        local
            prof : MULTI_COMPONENT_PROFILE
            csc  : CODESET_COMPONENT
            mc   : MULTI_COMPONENT
            cs   : CODESET
            wcs  : CODESET

        do
            prof ?= o.get_ior.profile2 (Tag_multiple_components, true)

            if prof /= void then
                mc  := prof.components
                csc ?= mc.component (Tag_code_sets)
            end

            if csc /= void then
                csid.set_item (csc.get_selected_cs)
                wcsid.set_item (csc.get_selected_wcs)
            else -- no code set info, use defaults ...
                cs := special_cs (Default_cs)
                if cs /= void then
                    csid.set_item (cs.id)
                end
                wcs := special_cs (Default_wcs)
                if wcs /= void then
                    wcsid.set_item (wcs.id)
                end
            end
            result := true
        end
----------------------

    get_invoke (id : INTEGER) : IIOP_PROXY_INVOKE_RECORD is

        local
            it : ITERATOR

        do
            from
                it := ids.iterator
            until
                it.finished
            loop
                if ids.key (it) = id then
                    it.stop
                else
                    it.forth
                end
            end
            if it.inside then
                result := ids.item (it)
            end
        end
----------------------

    add_invoke (id : INTEGER; rec : IIOP_PROXY_INVOKE_RECORD) is

        do
            ids.put (rec, id)
        end
----------------------

    del_invoke (id : INTEGER) is

        do
            ids.remove (id)
        end
----------------------

    make_conn_obj (obj : CORBA_OBJECT) : GIOP_CONNECTION is

        local
            addr : ADDRESS

        do
            addr := address_used_for_object (obj)
            check
                nonvoid_addr : addr /= void
            end
            result := make_conn_addr (addr)
        end
----------------------

    make_conn_addr (addr : ADDRESS) : GIOP_CONNECTION is

        local
            it : ITERATOR
            t  : TRANSPORT
            ec : CDR_ENCODER
            dc : CDR_DECODER
            gc : GIOP_CODEC
            log : IO_MEDIUM

        do
            if conns /= void then
                from
                    it := conns.iterator
                until
                    it.finished
                loop
                    if equal (conns.key (it), addr) then
                        it.stop
                        result := conns.item (it)
                    else
                        it.forth
                    end
                end
            end -- if conns /= void then ...
            if result = void then
                t := addr.make_transport
                create ec.make
                create dc.make
                create gc.make (dc, ec)
                t.connect (addr)
                if t.bad then
                    log := logger.log (logger.Log_err, "General",
                                       "IIOP_PROXY", "make_conn_addr")
                    log.put_string ("Cannot connect to ")
                    log.put_string (addr.stringify)
                    log.new_line
                else
                    log := logger.log (logger.Log_info, "General",
                                       "IIOP_PROXY", "make_conn_addr")
                log.put_string ("made new connection to ")
                log.put_string (addr.stringify)
                log.put_string (" with fd = ")
                log.put_integer (t.get_fd)
                log.new_line
                create result.make (my_orb, t, current, gc, 0)
                            -- no tmout
-- XXX The following is a stop-gap measure until TRANSPORT.peer is fixed
--                conns.put (result, t.peer)
                conns.put (result, addr)
                end
            end -- if result = void then ...
        end
----------------------

    kill_conn (gconn : GIOP_CONNECTION) is

        local
            kill   : INDEXED_LIST [ADDRESS]
            erase  : INDEXED_LIST [INTEGER]
            it     : ITERATOR
            i, n   : INTEGER
            id     : INTEGER
            obj    : CORBA_OBJECT
            rec    : IIOP_PROXY_INVOKE_RECORD
            req    : CORBA_REQUEST
            orbreq : LOCAL_REQUEST
            ex     : COMM_FAILURE
            log    : IO_MEDIUM

        do
            from
                it := conns.iterator
                create kill.make (false)
            until
                it.finished
            loop
                if equal (gconn, conns.item (it)) then
                    kill.append (conns.key (it))
                end
                it.forth
            end

            from
                n := kill.high_index
                i := kill.low_index
            until
                i > n
            loop
                conns.remove (kill.at (i))
                i := i + 1
            end

            from
                it := ids.iterator
                create erase.make (false)
            until
                it.finished
            loop
                rec := ids.item (it)
                if equal (gconn, rec.get_conn) then
                    id := ids.key (it)
                    erase.append (id)
                    log := logger.log (logger.Log_notice, "General",
                                       "IIOP_PROXY", "kill_conn")
                    log.put_string ("invocation(")
                    log.putint (id)
                    log.put_string (") aborted%N")

                    -- XXX notify orb about failed invocation ...
                    inspect my_orb.request_type (id)

                    when Request_invoke then
                        create obj.make
                        create req.make2 (obj, "someop")
                        create orbreq.make_with_request (req)
                        create ex.make
                        orbreq.set_out_args_ex (ex)
                        my_orb.answer_invoke (id, Invoke_sys_ex, void, orbreq)
                    when Request_locate then
                        my_orb.answer_locate (id, Locate_unknown, void)

                    when Request_bind then
                        my_orb.answer_bind (id, Locate_unknown, void)

                    end -- inspect id ...
                end -- if equal (gconn, rec.conn) then ...
                it.forth
            end

            from
                n := erase.high_index
                i := erase.low_index
            until
                i > n
            loop
                ids.remove (erase.at (i))
                i := i + 1
            end
        end
----------------------

    conn_error_and_send (gconn : GIOP_CONNECTION) is

        do
            conn_error (gconn, true)
        end
----------------------

    conn_error (gconn : GIOP_CONNECTION; send_error : BOOLEAN) is

        local
            outc : GIOP_OUT_CONTEXT
            dum  : BOOLEAN

        do
            if not send_error then
                kill_conn (gconn)
            else
                create outc.make1 (gconn.codec)
                dum := gconn.codec.put_error_msg (outc)
                gconn.output_from_buffer (outc.retn)
                -- prepare shutdown (i.e. wait until MessageError has
                -- been sent
                gconn.check_idle
            end
        end
----------------------

    handle_input (gconn : GIOP_CONNECTION) is

        require
            nonvoid_arg : gconn /= void

        local
            in   : GIOP_IN_CONTEXT
            mt   : INTEGER_REF
            size : INTEGER_REF
            fl   : OCTET
            log  : IO_MEDIUM

        do
            create in.make2 (gconn.codec, gconn.input (true))
            create mt
            create size
            create fl.make (0)
            if not gconn.codec.get_header (in, mt, size, fl) then
                -- XXX size is wrong for fragmented messages ...
                logger.log (logger.Log_warning, "General", "IIOP_PROXY",
                            "handle_input").put_string (
                                "cannot_decode_header%N")
                conn_error_and_send (gconn)
            else
                inspect mt.item

                when GIOP_reply then
                    handle_invoke_reply (gconn, in)

                when GIOP_locate_reply then
                    handle_locate_reply (gconn, in)

                when GIOP_close_connection then
                    if not gconn.codec.get_close_msg (in) then
                        logger.log (logger.Log_warning, "General", "IIOP_PROXY",
                                    "handle_input").put_string (
                                        "cannot decode CloseConnection%N")
                        conn_error_and_send (gconn)
                    else
                        logger.log (logger.Log_info, "General", "IIOP_PROXY",
                                    "handle_input").put_string ("got CloseConnection%N")
                        kill_conn (gconn)
                    end -- if not gconn.codec.get_close_msg ...

                
                when GIOP_message_error then
                    if not gconn.codec.get_error_msg (in) then
                        logger.log (logger.Log_warning, "General", "IIOP_PROXY",
                                    "handle_input").put_string (
                                        "cannot decode MessageError%N")
                        conn_error (gconn, false)
                    else
                        logger.log (logger.Log_info, "General", "IIOP_PROXY",
                                    "handle_input").put_string ("got MessageError%N")
                        kill_conn (gconn)
                    end -- if not gconn.codec.get_error_msg ...

                else
                    log := logger.log (logger.Log_warning, "General", "IIOP_PROXY",
                                       "handle_input")
                    log.put_string ("bad message type ")
                    log.putint (mt.item)
                    log.new_line
                end -- inspect
            end -- if not gconn.codec.get_header ...
        end
----------------------

    exec_invoke_reply (in : GIOP_IN_CONTEXT; req_id, stat : INTEGER;
                       obj : CORBA_OBJECT; req : ORB_REQUEST;
                       gconn : GIOP_CONNECTION) is

        local
            bind_stat : INTEGER_REF
            bind_obj  : ANY_REF
            o         : CORBA_OBJECT
            orb_stat  : INTEGER

        do
            inspect my_orb.request_type (req_id)

            when Request_bind then
                create bind_stat
                create bind_obj
                if stat /= No_exception
                   or else 
                   not gconn.codec.get_bind_reply (in, bind_stat, bind_obj)
                   or else 
                   bind_stat.item /= Object_here then
                    my_orb.answer_bind (req_id, Locate_unknown, void)
                else
                    o ?= bind_obj.item
                    my_orb.answer_bind (req_id, Locate_here, o)
                end

            when Request_invoke then
                orb_stat := Invoke_ok

                inspect stat

                when No_exception then
                    orb_stat := Invoke_ok

                when User_exception then
                    orb_stat := Invoke_usr_ex

                when System_exception then
                    orb_stat := Invoke_sys_ex

                when Location_forward then
                    orb_stat := Invoke_forward

                end -- inspect stat
                my_orb.answer_invoke (req_id, orb_stat, obj, req)

            when Request_unknown then
                -- request cancelled or reply contains invalid id
                -- ignore it

            end -- inspect
        end
----------------------

    handle_invoke_reply (gconn : GIOP_CONNECTION; in : GIOP_IN_CONTEXT) is

        require
            nonvoid_args : gconn /= void and then
                           in    /= void

        local
            req_id : INTEGER_REF
            stat   : INTEGER_REF
            obj    : CORBA_OBJECT
            ctx    : INDEXED_LIST [SERVICE_CONTEXT]
            rec    : IIOP_PROXY_INVOKE_RECORD
            conv   : CODESET_CONVERTER
            wconv  : CODESET_CONVERTER
            ex     : MARSHAL

        do
            -- XXX take care, get_invoke_reply does a in.rtn
            create req_id
            create stat
            create ctx.make (false)
            if not gconn.codec.get_invoke_reply1 (in, req_id, stat, ctx) then
                logger.log (logger.Log_warning, "General", "IIOP_PROXY", 
                            "handle_invoke_reply").put_string (
                                "cannot decode Reply1%N")
                conn_error_and_send (gconn)
            else
                rec := get_invoke (req_id.item)
                check
                    nonvoid_record : rec /= void
                end
                -- set up code set converters. this must be done
                -- before get_invoke_reply2, because it creates
                -- a GIOP_REQUEST which needs these converters.

                if rec.get_csid /= 0 then
                    conv := the_codeset_db.find (rec.get_csid,
                                        special_cs (Native_cs).id)
                end
                if rec.get_wcsid /= 0 then
                    wconv := the_codeset_db.find (rec.get_wcsid,
                                         special_cs (Native_wcs).id)
                end
                in.set_converters (conv, wconv)
                create obj.make
                if not gconn.codec.get_invoke_reply2 (in,
                                                      req_id,
                                                      stat.item,
                                                      obj,
                                                      rec.request,
                                                      ctx) then
                    logger.log (logger.Log_warning, "General", "IIOP_PROXY",
                                "handle_invoke_reply").put_string (
                                    "reply marshalling error%N")
                    if rec.request /= void then
                        create ex.make
                        rec.request.set_out_args_ex (ex)
                        stat.set_item (System_exception)
                    end -- if rec.request /= void then ...
                end -- if not gconn.codec.get_invoke_reply2 ...
                exec_invoke_reply (in, req_id.item, stat.item, obj,
                                   rec.request, gconn)
                del_invoke (req_id.item)
            end -- if not gconn.codec.get_invoke_reply1 ...
        end
----------------------

    handle_locate_reply (gconn : GIOP_CONNECTION;  in : GIOP_IN_CONTEXT) is

        require
            nonvoid_args : gconn /= void and then
                           in    /= void

        local
            req_id   : INTEGER_REF
            stat     : INTEGER_REF
            orb_stat : INTEGER
            obj      : ANY_REF
            o        : CORBA_OBJECT

        do
            create req_id
            create stat
            create obj
            orb_stat := Locate_here

            if not gconn.codec.get_locate_reply (in, req_id, stat, obj) then
                logger.log (logger.Log_warning, "General", "IIOP_PROXY",
                            "handle_locate_reply").put_string (
                                "cannot decode LocateReply%N")
                conn_error_and_send (gconn)
            else
                inspect stat.item

                when Unknown_object then
                    orb_stat := Locate_unknown

                when Object_here then
                    orb_stat := Locate_here

                when Object_forward then
                    orb_stat := Locate_forward

                end -- inspect
                o ?= obj.item
                my_orb.answer_locate (req_id.item, orb_stat, o)
                del_invoke (req_id.item)
            end -- if not gconn.codec.get_locate_reply ...
        end

end -- class IIOP_PROXY

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
