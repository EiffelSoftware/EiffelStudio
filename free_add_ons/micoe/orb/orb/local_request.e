indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class LOCAL_REQUEST

inherit
    ORB_REQUEST


creation
    make, make_with_request

feature

    make is

        do
            make_with_request (void)
        end
----------------------

    make_with_request (r : CORBA_REQUEST) is

        do
            req         := r
            have_except := false
            have_result := false
            create svc.make (false)
        end
----------------------

    op_name : STRING is

        do
            result := req.operation
        end
----------------------

    get_in_args_nvl (iparams : CORBA_NV_LIST; ctx : ANY_REF) : BOOLEAN is

        do
            iparams.copy (req.arguments)
            ctx.set_item (req.ctx)
            result := true
        end
----------------------

    get_in_args_sal (iparams : INDEXED_LIST [STATIC_ANY];
                     ctx     : ANY_REF) : BOOLEAN is

        local
            ec   : SIMPLE_ENCODER
            dc   : SIMPLE_DECODER
            args : CORBA_NV_LIST
            nv   : CORBA_NAMED_VALUE
            sa   : STATIC_ANY
            i, n : INTEGER

        do
            -- The slow way ...
            result := true
            from
                create ec.make
                create dc.make1 (ec.get_buffer)         
                args := req.arguments
                i    := 1
                n    := args.count
            until
                i > n
            loop
                nv := args.item (i)
                if (nv.my_flags &
                    (Flags.Arg_in | Flags.Arg_inout)).value /= 0 then
                    nv.value.marshal (ec)
                end
                i := i + 1
            end
            from
                i := 1
                n := iparams.count
            until
                i > n or else not result
            loop
                sa := iparams.at (i)
                if (sa.flags &
                 (Flags.Arg_in | Flags.Arg_inout)).value /= 0 then
                    result := sa.demarshal (dc)
                end
                i := i + 1
            end
            if result then
                ctx.set_item (req.ctx)
            end
        end
----------------------

    get_in_args_de (de : DATA_ENCODER) : BOOLEAN is

        local
            nv   : CORBA_NAMED_VALUE
            i, n : INTEGER

        do
        -- Do CORBA_ANY.marshal (de) for each `in' or `inout' argument.
        -- This will be the Request Body of a GIOP Invoke Request message.
        -- Cf. GIOP_CODEC.put_args.
            from
                i := 1
                n := req.arguments.count
            until
                i > n
            loop
                nv := req.arguments.item (i)
                if (nv.my_flags &
                    (Flags.Arg_in | Flags.Arg_inout)).value /= 0 then
                    nv.value.marshal (de)
                end
                i := i + 1
            end
            if req.ctx /= void then
                de.put_context (req.ctx, req.contexts)
            end
            result := true
        end
----------------------

    get_out_args_nvl (res     : CORBA_ANY;
                      oparams : CORBA_NV_LIST;
                      ex      : ANY_REF) : BOOLEAN is

        local
            e    : CORBA_EXCEPTION
            ec   : SIMPLE_ENCODER
            dc   : SIMPLE_DECODER
            nvl  : CORBA_NV_LIST
            nv   : CORBA_NAMED_VALUE
            i, n : INTEGER

        do
            if have_except then
                e := req.env.exception
                check
                    nonvoid_exception : e /= void
                end

                ex.set_item (e)
            else
                ex.set_item (void)
                if have_result and then res /= void then
                    res.copy (req.invoke_result.value)
                    oparams.copy_using_flags (req.arguments,
                                         (Flags.Arg_in| Flags.Arg_inout))
                end
            end
            result := true
        end
----------------------

    get_out_args_sal (res     : STATIC_ANY;
                      oparams : INDEXED_LIST [STATIC_ANY];
                      ex      : ANY_REF) : BOOLEAN is

        local
            e    : CORBA_EXCEPTION
            ec   : SIMPLE_ENCODER
            dc   : SIMPLE_DECODER
            args : CORBA_NV_LIST
            nv   : CORBA_NAMED_VALUE
            sa   : STATIC_ANY
            i, n : INTEGER

        do
            result := true
            if have_except then
                e := req.env.exception
                check
                    nonvoid_exception : e /= void
                end

                ex.set_item (e)
            else
                -- This is *slow* ...
                create ec.make
                create dc.make1(ec.get_buffer)

                if have_result and then res /= void then
                    req.invoke_result.value.marshal (ec)
                    result := res.demarshal (dc)
                end
                ec.get_buffer.reset (Buffer_minsize)
                args := req.arguments
                from
                    i := 1
                    n := args.count
                until
                    i > n or else not result
                loop
                    nv := args.item (i)
                    if (nv.my_flags &
                     (Flags.Arg_out | Flags.Arg_inout)).value /= 0 then
                       nv.value.marshal (ec)
                    end
                    i := i + 1
                end
                from
                    i := 1
                    n := oparams.count
                until
                    i > n or else not result
                loop
                    sa := oparams.at (i)
                    if (sa.flags &
                     (Flags.Arg_out | Flags.Arg_inout)).value /= 0 then
                        result := sa.demarshal (dc)
                    end
                    i := i + 1
                end
            end

        end
----------------------

    get_out_args_de (ec : DATA_ENCODER; is_ex : BOOLEAN_REF) : BOOLEAN is

        local
            e    : CORBA_EXCEPTION
            nvl  : CORBA_NV_LIST
            nv   : CORBA_NAMED_VALUE
            i, n : INTEGER

        do
            if have_except then
                is_ex.set_item (true)
                e := req.env.exception
                check
                    nonvoid_exception : e /= void
                end

                e.encode (ec)
            else
                is_ex.set_item (false)
                if have_result then
                    req.invoke_result.value.marshal (ec)
                end
                nvl := req.arguments
                from
                    i := 1
                    n := nvl.count
                until
                    i > n
                loop
                    nv := nvl.item (i)
                    if (nv.my_flags &
                      (Flags.Arg_out | Flags.Arg_inout)).value /= 0 then
                        nv.value.marshal (ec)
                    end
                    i := i + 1
                end
            end
            result := true
        end
----------------------

    set_out_args_nvl (res : CORBA_ANY; oparams : CORBA_NV_LIST) : BOOLEAN is

        do
            if res /= void then
                have_result := true
                req.invoke_result.set_value (res)
            end
            if oparams /= void then
                req.arguments.copy_using_flags (oparams,
                                       (Flags.Arg_out | Flags.Arg_inout))
            end
            result := true
        end
----------------------

    set_out_args_sal (res     : STATIC_ANY;
                      oparams : INDEXED_LIST [STATIC_ANY]) : BOOLEAN is

        local
            tc   : CORBA_TYPECODE
            ec   : SIMPLE_ENCODER
            dc   : SIMPLE_DECODER
            args : CORBA_NV_LIST
            sa   : STATIC_ANY
            nv   : CORBA_NAMED_VALUE
            i, n : INTEGER
            dum  : BOOLEAN

        do
            -- This is *slow* ...
            create ec.make
            create dc.make1 (ec.get_buffer)

            if res /= void then
                have_result := true
                res.marshal (ec)
                tc          := req.invoke_result.value.type
                dum := req.invoke_result.value.demarshal (tc, dc)
            end
            ec.get_buffer.reset (Buffer_minsize)
            args := req.arguments
            from
                i := 1
                n := oparams.count
            until
                i > n
            loop
                sa := oparams.at (i)
                if (sa.flags &
                    (Flags.Arg_out | Flags.Arg_in)).value /= 0 then
                   sa.marshal (ec) 
                end
                i := i + 1
            end
            from
                i := 1
                n := args.count
            until
                i > n
            loop
                nv := args.item (i)
                if (nv.my_flags &
                  (Flags.Arg_out | Flags.Arg_inout)).value /= 0 then
                    tc := nv.value.type
                    dum := nv.value.demarshal (tc, dc)
                end
                i := i + 1
            end
            result := true
        end
----------------------

    set_out_args_ex (ex : CORBA_EXCEPTION) is

        do
            have_except := true
            req.env.set_exception (ex)
        end
----------------------

    set_out_args_dc (dc : DATA_DECODER; is_ex : BOOLEAN) : BOOLEAN is

        local
            tc   : CORBA_TYPECODE
            e    : CORBA_EXCEPTION
            nvl  : CORBA_NV_LIST
            nv   : CORBA_NAMED_VALUE
            test : FLAGS
            i, n : INTEGER

        do
            result := true
            if is_ex then
                have_except := true
                e           := exception_decode_decoder (dc)
                check
                    valid_exception : e /= void
                end
                req.env.set_exception (e)
            else
                have_result := true

                tc := req.invoke_result.value.type
                if tc.kind = Tk_void then
                    result := true
                else
                    result := req.invoke_result.value.demarshal (tc, dc)
                end
                if result then
                    test := Flags.Arg_out | Flags.Arg_inout
                    from
                        nvl := req.arguments
                        i   := 1
                        n   := nvl.count
                    until
                        i > n or else not result
                    loop
                        nv := nvl.item (i)
                        if (nv.my_flags & test).value /= 0 then
                            tc     := nv.value.type
                            result := nv.value.demarshal (tc, dc)
                        end
                        i := i + 1
                    end
                end
            end
        end
----------------------

    copy_out_args (other : ORB_REQUEST) : BOOLEAN is

        local
            ex  : ANY_REF
            e   : CORBA_EXCEPTION
            dum : BOOLEAN

        do
            create ex
            svc.copy (other.svc)
            dum := other.get_out_args_nvl (req.invoke_result.value,
                                           req.arguments, ex)
            if ex.item /= void then
                have_except := true
                have_result := false
                e           ?= ex.item
                req.env.set_exception (e)
            else
                have_result := true
                have_except := false
            end
            result := true
        end
-----------------------------------------

    copy_in_args (other : like current) : BOOLEAN is

        do
            check
                never_called : false
            end
        end
-----------------------------------------

    type : STRING is

        do
            result := "local"
        end
-----------------------------------------

    request : CORBA_REQUEST is

        do
            result := req
        end
-----------------------------------------
feature { ORB_REQUEST } -- Implementation

    req         : CORBA_REQUEST
    have_except : BOOLEAN
    have_result : BOOLEAN

end -- class LOCAL_REQUEST

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
