indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class IIOP_SERVER

inherit
    INVOCATION_ADAPTER;
    EVENT_CONSTANTS;
    GIOP_CONSTANTS;
    THE_LOGGER;
    ORB_STATICS;
    GIOP_CONN_CALLBACK;
    TRANSPORT_SERVER_CALLBACK

creation
    make

feature

    listen_at (addr : ADDRESS) is

        local
            tserv : TRANSPORT_SERVER
            a     : ARRAY [INTEGER]
            mc    : MULTI_COMPONENT
            prof  : IOR_PROFILE
            log   : IO_MEDIUM

        do
            tserv := addr.make_transport_server
            tserv.bind (addr)
            tserv.set_nonblocking
            tserv.aselect (my_orb.dispatcher, current)

            create a.make (1, 1)
            a.put (0, 1) -- zero-terminated
            create mc.make
            prof := tserv.addr.make_ior_profile (a, mc)

            -- install an IIOP profile tag in the ORB's object
            -- template. object adapters will use this template to
            -- generate new object references ...
            log := logger.log (logger.Log_info, "General", 
                               "IIOP_SERVER", "listen_at")
            log.put_string ("binding to ")
            log.put_string (prof.addr.stringify)
            log.put_string (" with fd = ")
            log.put_integer (tserv.get_fd)
            log.new_line
            my_orb.ior_template.add_profile (prof)

            if tservers = void then
                create tservers.make (false)
            end
            tservers.append (tserv)
        end
----------------------

    callback_o (o : ORB; msgid : INTEGER; ev : INTEGER) is

        do
            inspect ev

            when ORB_invoke then
                handle_invoke_reply (msgid)

            when ORB_locate then
                handle_locate_reply (msgid)

            when ORB_bind then
                handle_bind_reply (msgid)
            
            end
        end
----------------------

    callback_g (conn : GIOP_CONNECTION; ev : INTEGER) is

        local
            addr : ADDRESS
            dum  : BOOLEAN
            log  : IO_MEDIUM

        do
            inspect ev

            when GIOP_input_ready then
                handle_input (conn)

            when GIOP_idle then
                log := logger.log (logger.Log_info, "General", "IIOP_SERVER",
                                                                 "callback_g")
                log.put_string ("Shutting down idle connection with fd ")
                log.putint (conn.transport.get_fd)
                log.new_line
                -- XXX better send CloseConnection ...
                kill_conn (conn)

            when GIOP_closed then
                log := logger.log (logger.Log_info, "General", "IIOP_SERVER",
                            "callback_g")
                log.put_string ("Connection with fd ")
                log.putint (conn.transport.get_fd)
                log.put_string (" closed or broken%N")
-- XXX The following code is commented out until TRANSPORT.peer has been
-- fixed. At this point (4/10/99) `conn_exec_client_disconnect' is a
-- dummy anyway.
--                addr := conn.transport.peer
--                check
--                    valid_peer : addr /= void
--                end                
--                dum := conn_exec_client_disconnect (addr.stringify)
                kill_conn (conn)

            end
        end
----------------------

    callback_ts (tserv : TRANSPORT_SERVER; ev : INTEGER) is

        local
            t     : TRANSPORT
            addr  : ADDRESS
            conn  : GIOP_CONNECTION
            codec : GIOP_CODEC
            ec    : CDR_ENCODER
            dc    : CDR_DECODER
            break : BOOLEAN
            log   : IO_MEDIUM

        do
            inspect ev

            when Accept_ev then
                t := tserv.accept
                if t /= void then
                    if t.bad then
                        log := logger.log (logger.Log_warning, "General",
                                           "IIOP_SERVER", "callback_ts")
                        log.put_string ("bad connection: ")
                        log.put_string (t.errormsg)
                        log.new_line
                        t.delete
                    else -- not t.bad
-- XXX The following code is commented out until we've fixed
-- TRANSPORT.peer. At this point (4/10/99) `conn_exec_client_connect'
-- is a dummy anyway. However, if the client disconnects at this
-- point the server won't notice it.
--                        addr := t.peer
--                        if addr = void then
--                            log := logger.log (logger.log_warning, "General",
--                                               "IIOP_SERVER", "callback_ts")
--                            log.put_string ("unknown peer %
--                                            %possibly disconnected")
--                            log.new_line
--                        elseif not conn_exec_client_connect
--                                      (addr.stringify) then
--                            t.delete
--                            break := true
--                        end
                        if not break then
                            create ec.make
                            create dc.make
                            create codec.make (dc, ec)
                            create conn.make (my_orb, t, current,
                                         codec, 0) -- no tmout
                            if conns = void then
                                create conns.make (false)
                            end
                            conns.append (conn)
                        end -- if not break then ...
                    end -- if t.bad then ...
                else -- t = void
                    logger.log (logger.Log_warning, "General", "IIOP_SERVER",
                                "callback_ts").put_string ("accept failed%N")
                end -- if t /= void then ...
            end
        end
----------------------
feature { NONE } -- Implementation

    tservers : INDEXED_LIST [TRANSPORT_SERVER]
    conns    : INDEXED_LIST [GIOP_CONNECTION]
    orbids   : DICTIONARY [IIOP_SERVER_INVOKE_RECORD, INTEGER]

----------------------

    get_invoke_reqid (msgid : INTEGER;
                      conn  : GIOP_CONNECTION) : IIOP_SERVER_INVOKE_RECORD is

        local
            it : ITERATOR

        do
            -- XXX slow but only needed for cancel
            from
                it := orbids.iterator
            until
                it.finished
            loop
                result := orbids.item (it)
                if result.reqid = msgid and then
                   result.conn  = conn      then
                    it.stop
                else
                    it.forth
                end
            end            
        end
----------------------

    get_invoke_orbid (msgid : INTEGER) : IIOP_SERVER_INVOKE_RECORD is

        do
            if orbids.has (msgid) then
                result := orbids.at (msgid)
            end
        end
----------------------

    add_invoke (rec : IIOP_SERVER_INVOKE_RECORD) is

        do
            if orbids = void then
                create orbids.make
            end
            check
                new_id : not orbids.has (rec.orbid)
            end
            orbids.put (rec, rec.orbid)
        end
----------------------

    del_invoke_reqid (msgid : INTEGER;
                      conn  : GIOP_CONNECTION) is

        local
            it  : ITERATOR
            rec : IIOP_SERVER_INVOKE_RECORD

        do
            -- XXX slow, but rarely used
            from
                it := orbids.iterator
            until
                it.finished
            loop
                rec := orbids.item (it)
                if rec.reqid = msgid and then
                   rec.conn  = conn      then
                    it.stop
                    orbids.remove (msgid)
                else
                    it.forth
                end
            end
        end
----------------------

    del_invoke_orbid (msgid : INTEGER) is

        do
            orbids.remove (msgid)
        end
----------------------

    kill_conn (conn : GIOP_CONNECTION) is

        local
            i, n : INTEGER
            it   : ITERATOR
            kill : INDEXED_LIST [INTEGER]

        do
            from
                conns.search (conn)
            until
                not conns.found
            loop
                conns.remove_at (conns.index)
                conns.search (conn)
            end
            if orbids /= void then
                from
                    it := orbids.iterator
                    create kill.make (false)
                until
                    it.finished
                loop
                    if orbids.item (it).conn = conn then
                        kill.append (orbids.key (it))
                    end
                    it.forth
                end -- loop
            end -- if orbids /= void then ...
            if kill /= void and then kill.count > 0 then
                from
                    i := kill.low_index
                    n := kill.high_index
                until
                    i > n
                loop
                    my_orb.cancel (kill.at (i))
                    orbids.remove (kill.at (i))
                    i := i + 1
                end -- loop
            end -- if kill /= void and then kill.count > 0 then ...
        end
----------------------

    conn_error1 (conn : GIOP_CONNECTION) is

        do
            conn_error (conn, true)
        end
----------------------

    conn_error (conn : GIOP_CONNECTION; send_error : BOOLEAN) is

        local
            outc : GIOP_OUT_CONTEXT
            dum  : BOOLEAN

        do
            if not send_error then
                kill_conn (conn)
            else
                create outc.make1 (conn.codec)
                dum := conn.codec.put_error_msg (outc)
                conn.output_from_buffer (outc.retn)
                -- prepare shutdown (i.e. wait until MessageError
                -- has been sent)
                conn.check_idle
            end
        end
----------------------

    handle_input (conn : GIOP_CONNECTION) is

        local
            in   : GIOP_IN_CONTEXT
            mt   : INTEGER_REF
            size : INTEGER_REF
            fl   : OCTET

        do
            create in.make2 (conn.codec, conn.input (true))
            create mt
            create size
            create fl.make (0)
            if not conn.codec.get_header (in, mt, size, fl) then
                -- XXX size is wrong for fragmented messages ...
                logger.log (logger.Log_warning, "General", "IIOP_SERVER",
                            "handle_input").put_string (
                                "cannot decode header%N")
                conn_error1 (conn)
            else
                inspect mt.item

                when GIOP_request then
                    handle_invoke_request (conn, in)

                when GIOP_locate_request then
                    handle_locate_request (conn, in)

                when GIOP_message_error then
                    if not conn.codec.get_error_msg (in) then
                        logger.log (logger.Log_warning, "General", "IIOP_SERVER",
                                    "handle_input").put_string (
                                        "cannot decode MessageError%N")
                        conn_error (conn, false)
                    else
                        logger.log (logger.Log_info, "General", "IIOP_SERVER",
                                    "handle_input").put_string (
                                        "got MessageError%N")
                        kill_conn (conn)
                    end

                when GIOP_cancel_request then
                    handle_cancel_request (conn, in)

                end -- inspect
            end -- if not conn.codec.get_header ...
        end
----------------------

    exec_invoke_request (in       : GIOP_IN_CONTEXT;
                         obj      : CORBA_OBJECT;
                         req      : ORB_REQUEST;
                         pr       : PRINCIPAL;
                         resp_exp : BOOLEAN;
                         conn     : GIOP_CONNECTION;
                         orbid    : INTEGER) : INTEGER is

        local
            repoid : STRING
            oid    : ARRAY [INTEGER]
            r      : BOOLEAN
        do
            if equal (req.op_name, "_bind") then
                repoid := ""
                create oid.make (1, 0)
                r := conn.codec.get_bind_request (in, repoid, oid)
                check
                    get_bind_request : r
                end
                -- orb makes copies of repoid and oid so we can
                -- delete them after the call to bind_async
                result := my_orb.bind_async5 (repoid, oid, void,
                                              current, orbid)
                obj.get_ior.set_objectkey (oid, oid.count)
            else
                result := my_orb.invoke_async6 (obj, req, pr,
                                                resp_exp, current, orbid)
            end
        end
----------------------

    handle_invoke_request (conn : GIOP_CONNECTION;
                           in   : GIOP_IN_CONTEXT) is

        local
            req_id : INTEGER_REF
            resp   : BOOLEAN_REF
            req    : ANY_REF
            oreq   : ORB_REQUEST
            pr     : PRINCIPAL
            obj    : CORBA_OBJECT
            ior    : IOR
            prof   : GIOP_SIMPLE_PROFILE
            rec    : IIOP_SERVER_INVOKE_RECORD
            orbid  : INTEGER
            orbid2 : INTEGER

        do
            -- XXX take care, get_invoke_request does an in.retn
            create req_id
            create resp
            create req
            ior := clone (my_orb.ior_template)
            create obj.make_with_ior (ior)
            pr := conn.transport.get_principal
            create prof.make
            obj.get_ior.add_profile (prof)
            if not conn.codec.get_invoke_request (in, req_id, resp,
                                                  obj, req, pr) then
                logger.log (logger.Log_warning, "General", "IIOP_SERVER",
                            "handle_invoke_request").put_string (
                                "cannot decode Request%N")
                conn_error1 (conn)
            else
                -- XXX obj is incomplete, see IOR.is_equal ...
                -- code sets are set up in get_contextlist.
                -- GIOPRequest will set up converters for out args,
                -- so we don't need to do anything special.
                -- We must install the invocation record before we
                -- call the ORB, because somebody may invoke callback_xx
                -- before we return from `exec_invoke_request' ...
                orbid := my_orb.new_msgid
                oreq ?= req.item
                create rec.make6 (conn, req_id.item, orbid, oreq, obj, pr)
                add_invoke (rec)
                orbid2 := exec_invoke_request (in, obj, oreq,
                                               pr, resp.item, conn, orbid)

                check
                    matching_ids : orbid = orbid2 or else
                                   (orbid2 = 0 and then not resp.item)
                end

                if not resp.item then
                    del_invoke_orbid (orbid)
                    conn.check_idle
                end
            end -- if not conn.codec.get_invoke_request ...
        end
----------------------

    handle_locate_request (conn : GIOP_CONNECTION;
                           in   : GIOP_IN_CONTEXT) is

        local
            req_id : INTEGER_REF
            ior    : IOR
            obj    : CORBA_OBJECT
            orbid  : INTEGER
            orbid2 : INTEGER
            rec    : IIOP_SERVER_INVOKE_RECORD

        do
            create req_id
            ior := clone (my_orb.ior_template)
            create obj.make_with_ior (ior)

            if not conn.codec.get_locate_request (in, req_id, obj) then
                logger.log (logger.Log_warning, "General", "IIOP_SERVER",
                            "handle_locate_request").put_string (
                                "cannot decode LocateRequest%N")
                conn_error1 (conn)
            else
                -- XXXobj is incomplete, see IOR.is_equal ...
                -- must install the invocation record before we
                -- call the ORB, because may invoke callback
                -- before returning from invoke_async ...
                orbid := my_orb.new_msgid
                create rec.make4 (conn, req_id.item, orbid, obj)
                add_invoke (rec)
                orbid2 := my_orb.locate_async3 (obj, current, orbid)
                check
                    matching_ids : orbid2 = orbid
                end
            end -- if not conn.codec.get_locate_request ...
        end
----------------------

    handle_cancel_request (conn : GIOP_CONNECTION;
                           in   : GIOP_IN_CONTEXT) is

        local
            req_id : INTEGER_REF
            rec    : IIOP_SERVER_INVOKE_RECORD

        do
            create req_id
            if not conn.codec.get_cancel_request (in, req_id) then
                logger.log (logger.Log_warning, "General", "IIOP_SERVER",
                            "handle_cancel_request").put_string (
                                "cannot decode CancelRequest%N")
                conn_error1 (conn)
            else
                conn.cancel (req_id.item)
                rec := get_invoke_reqid (req_id.item, conn)
                if rec = void then
                    -- request already finished or no such id
                else
                    my_orb.cancel (rec.orbid)

                    -- maybe rec.conn /= conn ...
                    rec.conn.check_idle
                    del_invoke_orbid (rec.orbid)
                end -- if rec /= void then ...
            end -- if not conn.codec.get_cancel_request ...
        end
----------------------

    handle_invoke_reply (msgid : INTEGER) is

        local
            req       : ANY_REF
            obj       : ANY_REF
            o         : CORBA_OBJECT
            r         : ORB_REQUEST
            stat      : INTEGER
            giop_stat : INTEGER
            rec       : IIOP_SERVER_INVOKE_RECORD
            outc      : GIOP_OUT_CONTEXT
            dum       : BOOLEAN

        do
            create req
            create obj
            stat      := my_orb.get_invoke_reply (msgid, obj, req)
            giop_stat := GIOP_no_exception
            inspect stat

            when Invoke_sys_ex then
                giop_stat := GIOP_system_exception

            when Invoke_usr_ex then
                giop_stat := GIOP_user_exception

            when Invoke_ok then
                giop_stat := GIOP_no_exception

            when Invoke_forward then
                giop_stat := GIOP_location_forward

            end -- inspect

            rec := get_invoke_orbid (msgid)
            check
                got_record : rec /= void
            end
            create outc.make1 (rec.conn.codec)
            o   ?= obj.item
            r   ?= req.item
            dum := rec.conn.codec.put_invoke_reply (outc, rec.reqid,
                                                    giop_stat, o, r)

            rec.conn.output_from_buffer (outc.retn)
            del_invoke_orbid (rec.orbid)
        end
----------------------

    handle_locate_reply (msgid : INTEGER) is

        local
            o         : ANY_REF
            obj       : CORBA_OBJECT
            rec       : IIOP_SERVER_INVOKE_RECORD
            outc      : GIOP_OUT_CONTEXT
            stat      : INTEGER
            giop_stat : INTEGER
            dummy     : BOOLEAN

        do
            create o
            stat := my_orb.get_locate_reply (msgid, o)
            obj  ?= o.item

            giop_stat := GIOP_object_here
            inspect stat

            when Locate_here then
                giop_stat := GIOP_object_here

            when Locate_unknown then
                giop_stat := GIOP_unknown_object

            when Locate_forward then
                giop_stat := GIOP_object_forward

            end -- inspect

            rec := get_invoke_orbid (msgid)
            check
                known_invocation : rec /= void
            end
            create outc.make1 (rec.conn.codec)
            dummy := rec.conn.codec.put_locate_reply (outc, rec.reqid,
                                                      giop_stat, obj)
            rec.conn.output_from_buffer (outc.retn)
            rec.conn.check_idle
            del_invoke_orbid (rec.orbid)
        end
----------------------

    handle_bind_reply (msgid : INTEGER) is

        local
            o         : ANY_REF
            obj       : CORBA_OBJECT
            rec       : IIOP_SERVER_INVOKE_RECORD
            outc      : GIOP_OUT_CONTEXT
            stat      : INTEGER
            giop_stat : INTEGER
            dummy     : BOOLEAN

        do
            create o
            stat := my_orb.get_bind_reply (msgid, o)
            obj  ?= o.item

            giop_stat := GIOP_object_here
            inspect stat

            when Locate_here then
                giop_stat := GIOP_object_here

            when Locate_unknown then
                giop_stat := GIOP_unknown_object

            when Locate_forward then
                giop_stat := GIOP_object_forward

            end -- inspect
            rec := get_invoke_orbid (msgid)
            check
                known_invocation : rec /= void
            end
            create outc.make1 (rec.conn.codec)
            dummy := rec.conn.codec.put_bind_reply (outc, rec.reqid,
                                                   giop_stat, obj)
            rec.conn.output_from_buffer (outc.retn)
            rec.conn.check_idle
            del_invoke_orbid (rec.orbid)
        end

end -- class IIOP_SERVER

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
