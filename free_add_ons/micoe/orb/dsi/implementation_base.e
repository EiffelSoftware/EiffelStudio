indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class IMPLEMENTATION_BASE

inherit
    TYPECODE_STATICS
        undefine
            copy, is_equal
        end;
    THE_FLAGS
        undefine
            copy, is_equal
        end;
    CONSUMER
        undefine
            is_equal
        redefine
            copy
        select
            copy
        end;
    CORBA_OBJECT
        rename
            make     as omake,
            orb      as oorb,
            copy     as ocopy
        redefine
            orbnc
        end;

feature

    make is

        local
            theo : THE_ORB
            o    : OCTET
            impl : IMPLEMENTATION_DEFINITION

        do
           if not created then
              created := true
              omake
              create theo.make (0, void, "")
              serv_orb   := theo.ORB_instance
              serv_boa   := serv_orb.BOA_instance1 ("mico-local-boa")
              --            impl := find_impl (repoid, type_name)
              ior := clone (ior)
              -- All servants inherit from this class;
              -- we don't want them all to use the same IOR ...
              create_ref (void, void, impl, repoid)
              ior.set_repoid (repoid)
           end
        end
----------------------

    implementation : CORBA_OBJECT is

        do
            result := current
        end
----------------------

    save_object : BOOLEAN is

        do
        end
----------------------

    create_ref (id : ARRAY [INTEGER]; interf : CORBA_INTERFACEDEF;
                im : IMPLEMENTATION_DEFINITION; rep : STRING) is

        local
            p       : like current
            old_orb : ORB
            old_boa : BOA

        do
            p ?= serv_boa.create_ref (id, interf, im, current, rep)
            check
                object_created : p /= void
            end
            old_orb := serv_orb
            old_boa := serv_boa
            copy (p)
                -- `copy' forgets `serv_orb' and `serv_boa'.
            serv_orb := old_orb
            serv_boa := old_boa
        end
----------------------

    restore_ref (orig_obj : CORBA_OBJECT;
                 id       : ARRAY [INTEGER];
                 interf   : CORBA_INTERFACEDEF;
                 im       : IMPLEMENTATION_DEFINITION) is

        local
            p : like current

        do
            p ?= serv_boa.restore (orig_obj, id, interf, im, current)
            check
                object_restored : p /= void
            end

            copy (p)
        end
----------------------

    dispose_ref is

        do
            serv_boa.dispose (current)
        end
----------------------

    impl_name (n : STRING) : STRING is

        do
            result := serv_boa.get_impl_name
        end
----------------------

    find_impl (rep, a_name : STRING) : IMPLEMENTATION_DEFINITION is

        local
            imr     : IMPLEMENTATION_REPOSITORY
            impls   : ARRAY [IMPLEMENTATION_DEFINITION]
            repoids : INDEXED_LIST [STRING]
            i, n    : INTEGER

        do
            a_name.copy (impl_name (a_name))
            imr ?= orbnc.resolve_initial_references
                        ("ImplementationRepository")

--            check
--                got_implrepository : imr /= void
--            end

--            impls   := imr.find_by_name (a_name)
            create impls.make (1, 0) -- just until the IMR is working
            if impls.count > 0 then
                result  := impls.item (impls.lower)
                repoids := result.repoids
                from
                    i := repoids.low_index
                    n := repoids.high_index
                until
                    i > n or equal (rep, repoids.at (i))
                loop
                    i := i + 1
                end
                if i >= n then -- add a new repoid
                    repoids.append (rep)
                    result.set_repoids (repoids)
                end
            else -- impls.count = 0; creat an entry
                create repoids.make (false)
                repoids.append (rep)
            end -- if impls.count > 0 then ...
        end
----------------------

    find_iface (rep : STRING) : CORBA_INTERFACEDEF is

        local
            obj   : CORBA_OBJECT
            ir    : CORBA_REPOSITORY

        do
            ir ?= orbnc.resolve_initial_references
                          ("InterfaceRepository")
            check
                got_ir : ir /= void
            end
            result ?= ir.lookup_id (rep)
        end
----------------------

    make_request (req : ORB_REQUEST;
                  o   : CORBA_OBJECT;
                  mid : INTEGER;
                  oa  : OBJECT_ADAPTER;
                  pr  : PRINCIPAL) : SERVER_REQUEST_BASE is

        do
            create {CORBA_SERVER_REQUEST} result.make5 (req, o, mid, oa, pr)
        end
----------------------

    doinvoke (req : SERVER_REQUEST_BASE; env : ENVIRONMENT) is

        do
            -- should not be deferred because of the stubs
        end
----------------------

    boa : BOA is

        do
            result := serv_boa
        end
----------------------

    orbnc : ORB is

        do
            result := serv_boa.orb
        end
----------------------

    this : CORBA_OBJECT is

        do
            result := current
        end
----------------------
feature -- mico/E extras

    object_to_implementation (o : CORBA_OBJECT) : IMPLEMENTATION_BASE is

        do
            result := serv_boa.object_to_implementation (o)
        end
----------------------

    raise_exception (e : CORBA_EXCEPTION) is

        do
            if the_message /= void then
                the_message.set_exception_ex (e)
                serv_orb.set_pending_exception (e)
            end
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            ocopy (other)
            serv_boa := other.serv_boa
            serv_orb := other.serv_orb
        end
----------------------

    begin_invoke is

        do
            create nvl.make
        end
----------------------

    finish_invoke is

        do
            nvl := void
        end
----------------------

    add_in_arg_integer (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_in).value.set_type (Tc_long)
        end
----------------------

    add_in_arg_double (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_in).value.set_type (Tc_double)
        end
----------------------

    add_in_arg_real (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_in).value.set_type (Tc_float)
        end
----------------------

    add_in_arg_character (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_in).value.set_type (Tc_char)
        end
----------------------

    add_in_arg_boolean (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_in).value.set_type (Tc_boolean)
        end
----------------------

    add_in_arg_string (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_in).value.set_type (Tc_string)
        end
----------------------

    add_in_arg_wstring (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_in).value.set_type (Tc_wstring)
        end
----------------------

    add_in_arg_ref (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_in).value.set_type (Tc_object)
        end
----------------------

    add_in_arg_with_type (nm : STRING; tc : CORBA_TYPECODE) is

        do
            nvl.add_item (nm, flags.Arg_in).value.set_type (tc)
        end
----------------------

    add_inout_arg_integer (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_inout).value.set_type (Tc_long)
        end
----------------------

    add_inout_arg_double (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_inout).value.set_type (Tc_double)
        end
----------------------

    add_inout_arg_real (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_inout).value.set_type (Tc_float)
        end
----------------------

    add_inout_arg_character (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_inout).value.set_type (Tc_char)
        end
----------------------

    add_inout_arg_boolean (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_inout).value.set_type (Tc_boolean)
        end
----------------------

    add_inout_arg_string (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_inout).value.set_type (Tc_string)
        end
----------------------

    add_inout_arg_wstring (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_inout).value.set_type (Tc_wstring)
        end
----------------------

    add_inout_arg_ref (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_inout).value.set_type (Tc_object)
        end
----------------------

    add_inout_arg_with_type (nm : STRING; tc : CORBA_TYPECODE) is

        do
            nvl.add_item (nm, flags.Arg_inout).value.set_type (tc)
        end
----------------------

    add_out_arg_integer (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_out).value.set_type (Tc_long)
        end
----------------------

    add_out_arg_double (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_out).value.set_type (Tc_double)
        end
----------------------

    add_out_arg_real (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_out).value.set_type (Tc_float)
        end
----------------------

    add_out_arg_character (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_out).value.set_type (Tc_char)
        end
----------------------

    add_out_arg_boolean (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_out).value.set_type (Tc_boolean)
        end
----------------------

    add_out_arg_string (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_out).value.set_type (Tc_string)
        end
----------------------

    add_out_arg_wstring (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_out).value.set_type (Tc_wstring)
        end
----------------------

    add_out_arg_ref (nm : STRING) is

        do
            nvl.add_item (nm, flags.Arg_out).value.set_type (Tc_object)
        end
----------------------

    add_out_arg_with_type (nm : STRING; tc : CORBA_TYPECODE) is

        do
            nvl.add_item (nm, flags.Arg_out).value.set_type (tc)
        end
----------------------
feature { IMPLEMENTATION_BASE } -- Implementation

    nvl         : CORBA_NV_LIST
    serv_boa    : BOA
    serv_orb    : ORB
    the_message : CORBA_SERVER_REQUEST
    created     : BOOLEAN
----------------------

    message : CORBA_SERVER_REQUEST is

        do
            result := the_message
        end

    type_name : STRING is

        deferred
        end

invariant
    nonvoid_boa_and_orb : not am_a_stub implies
                          (serv_boa /= void and
                           serv_orb /= void)

end -- class IMPLEMENTATION_BASE

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
