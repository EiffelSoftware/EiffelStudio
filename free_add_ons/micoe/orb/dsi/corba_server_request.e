indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_SERVER_REQUEST

inherit
    ORB_STATICS;
    SERVER_REQUEST_BASE

creation
    make, make5

feature

    make is

        do
        end
----------------------

    make5 (r : ORB_REQUEST; o : CORBA_OBJECT;
          the_msgid : INTEGER;
          the_oa : OBJECT_ADAPTER; pr : PRINCIPAL) is

        -- Used by the object adapter to prepare a newly arrived
        -- method invocation for the skeleton.

        do
            oa    := the_oa
            msgid := the_msgid
            obj   := o
            req   := r
            create env.make_with_principal (pr)
            dir_params := void
            aborted    := false

            context    := void
            iceptreq   := server_create_request (obj, r.op_name,
                                               r.get_context, current)
        end
----------------------

    finish_request is
        -- This is actually the destructor. It does all
        -- housekeeping needed at the end of a method
        -- invocation. In particular it sends the response back
        -- to the caller. It is fatal to forget to call `finish_request'.

        local
            stat   : INTEGER
            sys_ex : CORBA_SYSTEM_EXCEPTION
            e      : CORBA_EXCEPTION

        do
            if not canceled then
                if not aborted and then
                   not server_exec_before_marshal (iceptreq, env) then
                    aborted := true
                end
                -- copy back result and out args into ORBRequest
                set_out_args

                -- tell OA we are done
                stat := Invoke_ok
                e    := exception
                if e /= void then
                   sys_ex ?= e
                   if sys_ex /= void then
                        stat := Invoke_sys_ex
                   else
                        stat := Invoke_usr_ex
                   end

                end
                oa.answer_invoke (msgid, obj, req, stat)

                if not aborted and then
                   not server_exec_finish_request (iceptreq, env) then
                        -- XXX how do we abort the request here???
                end
            end
        end
----------------------
feature -- The official interface

    arguments, evaluate_arguments (nvl : CORBA_NV_LIST) is
        -- The name `arguments' (specified by the OMG) doesn't
        -- even approximately describe what happens here. The
        -- server-side ORB is not in a position to evaluate the
        -- actual arguments delivered by GIOP. A CORBA_SERVER_REQUEST
        -- is a kind of ``thunk'' permitting late evaluation; this is
        -- where that happens. `nvl' must have one entry for each
        -- formal argument with name, type and attribute ``in'',
	-- ``out'' or ``inout''. Only the value is missing; this
        -- routine fills it in. Actually the names are irrelevant,
	-- since GIOP does not transport names; only the order is
        -- important; it must agree with the order in the IDL specification
        -- of the method being invoked.

        local
            dummy : BOOLEAN

        do
            dummy := set_params (nvl)
        end
----------------------

    set_result (val : CORBA_ANY) is

        do
            env.clear
            res := val
        end
----------------------

    set_exception (val : CORBA_ANY) is

        do
            mico_set_exception (val)
        end
----------------------

    ctx : CORBA_CONTEXT is

        do
            result := context
        end
----------------------
feature -- the MICO interface

    request : ORB_REQUEST is

        do
            result := req
        end
----------------------

    set_out_args is
        -- Prepare the values of the out- and inout-arguments
        -- for transport back to the client. If the method was
        -- a function its value should be prepared for the
        -- return trip as well. If an exception was raised,
        -- then it should be prepared for the return journey
        -- instead.

        local
            mex : MARSHAL

        do
            if env.exception /= void then
                req.set_out_args_ex (env.exception)
            else
                if not req.set_out_args_nvl (res, dir_params) then
                    create mex.make
                    req.set_out_args_ex (mex)
                end -- if not req.set_out_args_nvl ...
            end -- if env.exception /= void then ...
        end
----------------------

    the_arguments : CORBA_NV_LIST is

        do
            result := dir_params
        end
----------------------

    set_arguments (params : CORBA_NV_LIST) is
        -- This is probably not what you want; take a look at
        -- `set_params'.

        do
            dir_params := params
        end
----------------------

    set_params (params : CORBA_NV_LIST) : BOOLEAN is
        -- The choice of names seemed unfortunate at first until
        -- I realized this is the routine that evaluates the
        -- actual arguments of the method. `params' must have
        -- been constructed to have the correct flags (in, out, inout)
        -- and the correct types. Only the values are missing and
        -- this routine fills them in.

        local
            mex : MARSHAL
            cr  : ANY_REF

        do
            result := true
            check
                dir_params_void : dir_params = void
            end
            dir_params := params

            if not server_exec_initialize_request (iceptreq, env) then
                aborted := true
                result  := false
            else
                create cr
                cr.set_item (context)
                if not req.get_in_args_nvl (dir_params, cr) then
                    logger.log (logger.Log_warning, "General", 
                                "CORBA_SERVER_REQUEST",
                                "set_params").put_string (
                                    "ServerRequest.params: cannot %
                                    %decode the arguments%N")
                    create mex.make
                    set_exception_ex (mex)
                    aborted := true
                    result  := false
                else
                    context ?= cr.item
                    if not server_exec_after_unmarshal (iceptreq, env) then
                        aborted := true
                        result  := false
                    end
                end
            end
        end
----------------------

    get_result : CORBA_ANY is

        do
            result := res
        end
----------------------

    exception : CORBA_EXCEPTION is

        do
            result := env.exception
        end
----------------------

    environment : ENVIRONMENT is

        do
            result := env
        end
----------------------

    operation : STRING is
        -- Name of the method being invoked.

        do
            result := req.op_name
        end
----------------------

    mico_set_result (r : CORBA_ANY) is
        -- This is a MICO extension; there is also a
        -- set_result specified by CORBA 2.2. See below.

        do
            env.clear
            res := r
        end
----------------------

    mico_set_exception (e : CORBA_ANY) is
        -- This is a MICO extension; there is also a
        -- set_exception spcified by CORBA 2.2. See below.

        do
            res := void
            env.set_exception (exception_decode_any (e))
        end
----------------------

    op_name : STRING is

        do
            result := req.op_name
        end
----------------------

    op_def : CORBA_OPERATIONDEF is

        local
            iface : CORBA_INTERFACEDEF
            cont  : CORBA_OBJECT

        do
            iface := obj.get_interface
            check
                got_iface : iface /= void
            end

            cont := iface.lookup (op_name)

            check
                op_name_found : cont /= void
            end

            result ?= cont

        ensure
            nonvoid_result : result /= void
        end
----------------------

    set_exception_any (val : CORBA_ANY) is
        -- This is the one prescribed by CORBA 2.2

        do
            res := void
            env.set_exception (exception_decode_any (val))
        end
----------------------

    set_exception_ex (ex : CORBA_EXCEPTION) is

        do
            res := void
            env.set_exception (ex)
        end
----------------------
feature { NONE } -- Implementation

    msgid      : INTEGER
    oa         : OBJECT_ADAPTER
    obj        : CORBA_OBJECT
    req        : ORB_REQUEST
    dir_params : CORBA_NV_LIST
    context    : CORBA_CONTEXT
    res        : CORBA_ANY
    env        : ENVIRONMENT
    iceptreq   : LWSERVER_REQUEST
    aborted    : BOOLEAN

end -- class CORBA_SERVER_REQUEST

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
