indexing

description: "A message describing a method invocation to be %
             %passed from a stub to a skeleton via the ORB.";
keywords: "message", "invocation"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_REQUEST

inherit
    INVOCATION_ADAPTER
        rename
            make as unused_make
        end;
    THE_FLAGS;
    EVENT_CONSTANTS;
    ORB_STATICS;
    INTERCEPTOR_STATICS


creation
    make, make2, make5, make7

feature -- Initialization

    make is

        do
        end
----------------------

    make2 (o : CORBA_OBJECT; op : STRING) is
        -- Initialize `current' with object reference `o' as target
        -- of the invocation and `op' as name of the method.

        require
            nonvoid_args : o  /= void and then
                           op /= void

        local
            orb : ORB
            ca  : CORBA_ANY

        do
            object         := o
            opname         := op
            invoke_pending := false
            orb            := o.orbnc
            context        := void
            environ        := orb.create_environment
            args           := orb.create_list (0)
            res            := orb.create_named_value
            elist          := orb.create_exception_list
            create ca.make
            res.set_value (ca)
            create {LOCAL_REQUEST} orbreq.make_with_request (current)
            iceptreq := client_create_request (object, opname,
                                               orbreq.get_context, current)
            cb := void
        end
----------------------

    make5 (o : CORBA_OBJECT; c : CORBA_CONTEXT; op : STRING;
           a : CORBA_NV_LIST; rslt : CORBA_NAMED_VALUE) is
        -- Initialize `current' with object reference `o' as target
        -- of the invocation and `op' as name of the method.
        -- `c' is the context of the invocation, `a' the list of
        -- actual arguments, `rslt' will eventually contain the
        -- result.

        require
            nonvoid_args : o    /= void and then
                           op   /= void and then
                           a    /= void and then
                           rslt /= void

        local
            orb : ORB

        do
            object         := o
            context        := c
            opname         := op
            args           := a
            res            := rslt
            invoke_pending := false
            orb            := o.orbnc
            environ        := orb.create_environment
            clist          := orb.create_context_list
            elist          := orb.create_exception_list
            create {LOCAL_REQUEST} orbreq.make_with_request (current)
            iceptreq := client_create_request (object, opname,
                                               orbreq.get_context, current)
            cb := void
        end
----------------------

    make7 (o : CORBA_OBJECT; c : CORBA_CONTEXT; op : STRING;
           a : CORBA_NV_LIST; rslt : CORBA_NAMED_VALUE;
           el : INDEXED_LIST [CORBA_TYPECODE];
           cl : INDEXED_LIST [STRING]) is
        -- Initialize `current' with object reference `o' as target
        -- of the invocation and `op' as name of the method.
        -- `c' is the context of the invocation, `a' the list of
        -- actual arguments, `rslt' will eventually contain the
        -- result, `el' is the list of exception types the method
        -- could potentially raise and `cl' the list of contexts
        -- given in the method declaration.

        require
            nonvoid_args : o    /= void and then
                           op   /= void and then
                           a    /= void and then
                           rslt /= void

        local
            orb : ORB

        do
            object         := o
            context        := c
            opname         := op
            args           := a
            res            := rslt
            elist          := el
            clist          := cl
            invoke_pending := false
            orb            := o.orbnc
            environ        := orb.create_environment
            create {LOCAL_REQUEST} orbreq.make_with_request (current)
            iceptreq := client_create_request (object, opname,
                                               orbreq.get_context, current)
            cb := void
        end
----------------------
feature -- Access

    target : CORBA_OBJECT is

        do
            result := object
        end
----------------------

    operation : STRING is

        do
            result := opname
        end
----------------------

    arguments : CORBA_NV_LIST is

        do
            result := args
        end
----------------------

    invoke_result : CORBA_NAMED_VALUE is

        do
            result := res
        end
----------------------

    env : ENVIRONMENT is

        do
            result := environ
        end
----------------------

    exceptions : INDEXED_LIST [CORBA_TYPECODE] is

        do
            result := elist
        end
----------------------

    contexts : INDEXED_LIST [STRING] is

        do
            result := clist
        end
----------------------

    ctx : CORBA_CONTEXT is

        do
            result := context
        end
----------------------
feature -- Mutation

    set_ctx (c : CORBA_CONTEXT) is

        do
            context := c
        end
----------------------
feature -- Invocation

    invoke is
        -- Send the method invocation `current'
        -- off to the servant.

        local
            stat : INTEGER

        do
            send
            get_response
        end
----------------------

    send_oneway is
        -- Send the method invocation `current'
        -- off to the servant but don't expect an
        -- answer ... not even an exception.

        local
            dum : BOOLEAN
            mid : INTEGER
            orb : ORB

        do
            if client_exec_initialize_request (iceptreq, environ) then
                orb := object.orbnc
                mid := orb.invoke_async4 (object, orbreq, void, false)
                dum := client_exec_after_marshal (iceptreq, environ)
            end
        end
----------------------

    send, send_deferred0 is
        -- Send the method invocation `current'
        -- off to the servant asynchronously.

        local
            stat : INTEGER

        do
            stat := send_deferred1 (void)
        end
----------------------

    send_deferred1 (a_cb : REQUEST_CALLBACK) : INTEGER is
        -- Send the method invocation `current'
        -- off to the servant asynchronously;
        -- when an answer comes, call `a_cb.callback'.

        local
            orb : ORB

        do
            cb := a_cb
            if not client_exec_initialize_request (iceptreq, environ) then
                if cb /= void then
                    cb.callback (current, Request_done)
                    cb := void
                end
            else
                invoke_pending := true
                orb            := object.orbnc
                if cb /= void then
                    msgid := orb.invoke_async5 (object, orbreq, void,
                                                true, current)
                else
                    msgid := orb.invoke_async5 (object, orbreq, void,
                                                true, void)
                end

                if not client_exec_after_marshal (iceptreq, environ) then
                    orb.cancel (msgid)
                    invoke_pending := false
                    if cb /= void then
                        cb.callback (current, Request_done)
                        cb := void
                    end
                end -- if not client_exec_after_marshal ...
            end -- if not client_exec_initialize_request ...
        end
----------------------

    get_response, get_response_blocking is
        -- Fetch the answer to the method
        -- invocation `current'. Block if it
        -- is not yet back.

        local
            stat : INTEGER

        do
            stat := get_response1 (true)
        end
----------------------

    get_response1 (block : BOOLEAN) : INTEGER is
        -- Fetch the answer to the method
        -- invocation `current'. Block if it
        -- is not yet back depending on the
        -- value of `block'.

        local
            orb   : ORB
            nobj  : ANY_REF
            obj   : CORBA_OBJECT
            stat  : INTEGER
            done  : BOOLEAN
            orr   : ANY_REF
            r     : BOOLEAN

        do
            from
                orb := object.orbnc
            until
                done or else not invoke_pending
            loop
                if block then
                    r := orb.wait1 (msgid)
                    check
                        wait_ok : r
                    end
                else -- not block
                    if not orb.wait2 (msgid, 1) then
                        result := 1
                        done   := true
                    end
                end -- if block then ...
                if not done then
                    -- XXX called multiple times in case of Forward
                    if not client_exec_before_unmarshal (iceptreq,
                                                         environ) then
                        orb.cancel (msgid)
                        invoke_pending := false
                        cb             := void
                        result         := 0
                        done           := true
                    else
                        create nobj
                        create orr
                        stat := orb.get_invoke_reply (msgid, nobj, orr)
                        inspect  stat

                        when Invoke_forward then
                            -- XXX what if `object' is not a stub???
                            obj ?= nobj.item
                            object.copy (obj)
                            msgid := orb.invoke_async3 (object,
                                                        orbreq, void)
                            
                        when Invoke_ok, Invoke_sys_ex then
                            invoke_pending := false

                        when Invoke_usr_ex then
                            decode_user_exception
                            invoke_pending := false
                        end -- inspect
                    end
                end -- if not done then ...
            end -- loop

            if not done then
                r      := client_exec_finish_request (iceptreq,
                                                      environ)
                cb     := void
                result := 0
            end -- if not done then ...
        end
----------------------

    poll_response : BOOLEAN is
        -- Is an answer to `current' available?

        local
            stat: INTEGER

        do
            -- XXX call get_response to check for redirections ...
            stat   := get_response1 (false)
            result := not invoke_pending
        end
----------------------
feature -- Entering and recovering arguments

    add_arg_in (name  : STRING;
                value : CORBA_ANY) is
        -- This is the routine specified in our Eiffel binding.
        -- You will not find it in MICO.

        local
            nv : CORBA_NAMED_VALUE

        do
            nv := arguments.add_value (name, value, flags.Arg_in)
        end
----------------------

    add_arg_out (name  : STRING;
                 value : CORBA_ANY) is
        -- This is the routine specified in our Eiffel binding.
        -- You will not find it in MICO.

        local
            nv : CORBA_NAMED_VALUE

        do
            nv := arguments.add_value (name, value, flags.Arg_out)
        end
----------------------

    add_arg_inout (name  : STRING;
                   value : CORBA_ANY) is
        -- This is the routine specified in our Eiffel binding.
        -- You will not find it in MICO.

        local
            nv : CORBA_NAMED_VALUE

        do
            nv := arguments.add_value (name, value, flags.Arg_inout)
        end
----------------------

    add_in_arg : CORBA_ANY is

        do
            result := arguments.add (flags.Arg_in).value
        end
----------------------

    add_in_arg_with_name (name : STRING) : CORBA_ANY is

        do
            result := arguments.add_item (name, flags.Arg_in).value
        end
----------------------

    add_inout_arg : CORBA_ANY is

        do
            result := arguments.add (flags.Arg_inout).value
        end
----------------------

    add_inout_arg_with_name (name : STRING) : CORBA_ANY is

        do
            result := arguments.add_item (name, flags.Arg_inout).value
        end
----------------------

    add_out_arg : CORBA_ANY is

        do
            result := arguments.add (flags.Arg_out).value
        end
----------------------

    add_out_arg_with_name (name : STRING) : CORBA_ANY is

        do
            result := arguments.add_item (name, flags.Arg_out).value
        end
----------------------

    set_return_type (type : CORBA_TYPECODE) is

        do
            res.value.set_type (type)
        end
----------------------

    add_exception (etype : CORBA_TYPECODE) is

        do
            elist.append (etype)
        end
----------------------

    return_value : CORBA_ANY is

        do
            result := res.value
        end
----------------------

    get_out_arg_integer (name : STRING) : INTEGER is

        do
            result := args.get_integer_value_by_name (name)
        end
----------------------

    get_out_arg_boolean (name : STRING) : BOOLEAN is

        do
            result := args.get_boolean_value_by_name (name)
        end
----------------------

    get_out_arg_character (name : STRING) : CHARACTER is

        do
            result := args.get_character_value_by_name (name)
        end
----------------------

    get_out_arg_real (name : STRING) : REAL is

        do
            result := args.get_real_value_by_name (name)
        end
----------------------

    get_out_arg_double (name : STRING) : DOUBLE is

        do
            result := args.get_double_value_by_name (name)
        end
----------------------

    get_out_arg_string (name : STRING) : STRING is

        do
            result := args.get_string_value_by_name (name)
        end
----------------------

    get_out_arg_wstring (name : STRING) : ARRAY [INTEGER] is

        do
            result := args.get_wstring_value_by_name (name)
        end
----------------------

    get_out_arg_any (name : STRING) : CORBA_ANY is

        do
            result := args.get_any_value_by_name (name)
        end
----------------------

    get_out_arg_ref (clss, name : STRING) : CORBA_OBJECT is

        do
            result := args.get_ref_value_by_name (clss, name)
        end
----------------------

    returned_exception : CORBA_EXCEPTION is

        do
            result := environ.exception
        end
----------------------
feature { CORBA_REQUEST } -- Implementation

    object         : CORBA_OBJECT
    context        : CORBA_CONTEXT
    opname         : STRING
    args           : CORBA_NV_LIST
    res            : CORBA_NAMED_VALUE
    elist          : INDEXED_LIST [CORBA_TYPECODE]
    clist          : INDEXED_LIST [STRING]
    environ        : ENVIRONMENT
    msgid          : INTEGER
    invoke_pending : BOOLEAN
    orbreq         : ORB_REQUEST
    cb             : REQUEST_CALLBACK
    iceptreq       : LWREQUEST
----------------------

    decode_user_exception is
        -- I realize this is a very peculiar looking procedure;
        -- it *appears* not to change the state of the system
        -- in any way. However, the calls to uuex.except_repoid
        -- uuex.exception_from_typecode have hidden side effects.
        -- When this procedure is finished, environ.exception
        -- "knows" what kind of exception it is.

        require
            nontrivial_raises_clause : elist /= void and then
                                       elist.count > 0

        local
            ex     : CORBA_EXCEPTION
            tc     : CORBA_TYPECODE
            a      : CORBA_ANY
            uuex   : UNKNOWN_USER_EXCEPTION
            repoid : STRING
            i, n   : INTEGER
            break  : BOOLEAN

        do
            ex := environ.exception
            if ex /= void and then elist.count > 0 then
                uuex ?= ex
                if uuex /= void then
                    -- decode uuex using elist
                    repoid := uuex.except_repoid
                    from
                        i  := elist.low_index
                        n  := elist.high_index
                    until
                        i > n or else break
                    loop
                        tc := elist.at (i)
                        if equal (repoid, tc.id) then
                            a     := uuex.exception_from_typecode (tc)
                            break := true
                        else
                            i  := i + 1
                        end
                    end
                end
            end
        end
----------------------

    callback_o (orb : ORB; id, evt : INTEGER) is

        do
            invoke
            if cb /= void then
                cb.callback (current, Request_done)
                cb := void
            end
        end

end -- class CORBA_REQUEST

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
