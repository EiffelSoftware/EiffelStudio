indexing

description: "Data structure in which the microORB stores information %
             %about pending invoke, locate or bind operations.";
keywords: "Asynchronous", "invoke", "locate", "bind";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class INVOKE_RECORD

inherit
    ORB_STATICS

creation
    make_invoke4, make_invoke5,
    make_locate4, make_locate5,
    make_bind5, make_bind6

feature -- Initialization

    make_invoke4 (o : ORB; mid : INTEGER; r : ORB_REQUEST;
                  a_cb : ORB_CALLBACK) is

        do
            make_invoke5 (o, mid, r, a_cb, void)
        end
---------------------------------------------------------------

    make_invoke5(o : ORB; mid : INTEGER; r : ORB_REQUEST;
                 a_cb : ORB_CALLBACK; an_oa : OBJECT_ADAPTER) is

        do
            have_result := false
            type        := Request_invoke

            myorb   := o
            myid    := mid
            obj     := void
            req     := r
            adapter := an_oa
            cb      := a_cb
        end
---------------------------------------------------------------

    make_locate4 (o : ORB; mid : INTEGER; ob : CORBA_OBJECT;
                  a_cb : ORB_CALLBACK) is

        do
            make_locate5 (o, mid, ob, a_cb, void)
        end
---------------------------------------------------------------

    make_locate5 (o : ORB; mid : INTEGER; ob : CORBA_OBJECT;
                  a_cb : ORB_CALLBACK; an_oa : OBJECT_ADAPTER) is

        do
            have_result := false
            type        := Request_locate

            myorb   := o
            myid    := mid
            obj     := void
            req     := void
            adapter := an_oa
            cb      := a_cb
        end
---------------------------------------------------------------

    make_bind5 (o : ORB; mid : INTEGER; repoid : STRING;
                oid : ARRAY [INTEGER]; a_cb : ORB_CALLBACK) is

        do
            make_bind6 (o, mid, repoid, oid, a_cb, void)
        end
---------------------------------------------------------------

    make_bind6 (o : ORB; mid : INTEGER; repoid : STRING;
                oid : ARRAY [INTEGER]; a_cb : ORB_CALLBACK;
                an_oa  : OBJECT_ADAPTER) is

        do
            have_result := false
            type        := Request_bind

            myorb   := o
            myid    := mid
            obj     := void
            req     := void
            adapter := an_oa
            cb      := a_cb
            objtag  := oid
        end
---------------------------------------------------------------
feature -- Access

    id : INTEGER is

        do
            result := myid
        end
---------------------------------------------------------------

    completed : BOOLEAN is

        do
            result := have_result
        end
---------------------------------------------------------------

    oa : OBJECT_ADAPTER is

        do
            result := adapter
        end
---------------------------------------------------------------

    request_type : INTEGER is

        do
            result := type
        end
---------------------------------------------------------------

    request : ORB_REQUEST is

        do
            result := req
        end
---------------------------------------------------------------

    tag : ARRAY [INTEGER] is

        do
            result := objtag
        end
---------------------------------------------------------------

    callback : ORB_CALLBACK is

        do
             result := cb
        end
---------------------------------------------------------------

    get_answer_invoke (state : INTEGER_REF;
                       o     : ANY_REF;
                       r     : ANY_REF) : BOOLEAN is

        require
            nonvoid_args : state /= void and then
                           o     /= void and then
                           r     /= void


        do
            check
                right_type : type = Request_invoke
            end

            if not have_result then
                result := false
            else
                state.set_item (invoke_stat)
                o.set_item (obj)
                r.set_item (req)
                result := true
            end
        end
---------------------------------------------------------------

    get_answer_bind (state : INTEGER_REF;
                     o     : ANY_REF) : BOOLEAN is

        require
            nonvoid_args : state /= void and then
                           o /= void

        do
            check
                right_type : type = Request_bind
            end

            if not have_result then
                result := false
            else
                state.set_item (locate_stat)
                o.set_item (obj)
                result := true
            end
        end
---------------------------------------------------------------

    get_answer_locate (state : INTEGER_REF;
                       o     : ANY_REF) : BOOLEAN is

        require
            nonvoid_args : state /= void and then
                           o /= void

        do
            check
                right_type : type = Request_locate
            end

            if not have_result then
                result := false
            else
                o.set_item (obj)
                state.set_item (locate_stat)
                result := true
            end
        end                     
---------------------------------------------------------------
feature -- Mutation

    set_oa (an_oa : OBJECT_ADAPTER) is

        do
            adapter := an_oa
        end
---------------------------------------------------------------

    set_answer_invoke (state : INTEGER;
                       o     : CORBA_OBJECT;
                       r     : ORB_REQUEST) is

        local
            ex  : MARSHAL

        do
            check
                right_type : type = Request_invoke
            end

            check
                no_result_yet : not have_result
            end

            have_result := true
            invoke_stat := state

            inspect state

            when Invoke_ok, Invoke_sys_ex, Invoke_usr_ex then
                if not req.copy_out_args (r) then
                    create ex.make
                    req.set_out_args_ex (ex)
                    invoke_stat := Invoke_sys_ex
                end
                

            when Invoke_forward then
                obj := o
            end
        end
---------------------------------------------------------------

    set_answer_bind (state : INTEGER; o : CORBA_OBJECT) is

        do
            check
                right_type : type = Request_bind
            end
            check
                no_result_yet : not have_result
            end
            
            have_result := true
            locate_stat := state

            inspect state

            when Locate_unknown, Locate_forward then
                -- do nothing

            when Locate_here then
                obj := o
                if obj.get_ior.get_objectkey.count = 1 and then
                    objtag.count > 1                      then
                    obj.get_ior.set_objectkey (objtag, objtag.count)
                else
                    objtag := obj.get_ior.get_objectkey
                end
            end
        end
---------------------------------------------------------------

    set_answer_locate (state : INTEGER; o : CORBA_OBJECT) is

        do
            check
                right_type : type = Request_locate
            end
            check
                no_result_yet : not have_result
            end

            have_result := true
            locate_stat := state

            inspect state

            when Locate_unknown, Locate_here then
                -- Do nothing

            when Locate_forward then
                obj := o

            end
        end
---------------------------------------------------------------
feature { INVOKE_RECORD } -- Implementation

    myid        : INTEGER
    type        : INTEGER
    have_result : BOOLEAN
    invoke_stat : INTEGER
    locate_stat : INTEGER
    adapter     : OBJECT_ADAPTER
    obj         : CORBA_OBJECT
    req         : ORB_REQUEST
    cb          : ORB_CALLBACK
    myorb       : ORB
    objtag      : ARRAY [INTEGER]

end -- class INVOKE_RECORD

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
