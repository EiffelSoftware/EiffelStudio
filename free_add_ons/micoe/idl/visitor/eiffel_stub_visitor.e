indexing

description: "Generates code for stubs";
keywords: "Visitor Pattern", "code generation";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class EIFFEL_STUB_VISITOR

inherit
    EIFFEL_CODE_VISITOR
        redefine
            generate_project_helper
        end

creation
    make

feature

    interfaces_deferred : BOOLEAN is

        do
          result := false
        end
----------------------

    is_a_stub : BOOLEAN is

        do
            result := true
        end
----------------------

    is_a_skeleton : BOOLEAN is

        do
            result := false
        end
----------------------

    is_an_implementation : BOOLEAN is

        do
            result := false
        end
----------------------

    is_a_servant : BOOLEAN is

        do
            result := false
        end
----------------------

    standard_parent : STRING is

        once
            result := "STANDARD_STUB"
        end
----------------------

    visitor_type : INTEGER is

        do
            result := 1
        end
----------------------

    root : STRING is

        do
            result := clone (path_prefix)
            result := fs.concat_paths (result, "stub")
            if not fs.cluster_exists (result) then
                fs.add_cluster (result, "lm.lm")
            end
        end
----------------------

    class_name_suffix : STRING is

        do
            result := "_STUB"
        end
----------------------

    generate_interface_inherit (in : INTERFACE) is

        local
            help : STRING
            name : STRING
            i, n : INTEGER

        do
            name := scoped_name_to_class_name (in.name)
            help := clone (project)
            help.append ("_helper")
            help.to_upper
            io.put_string ("%Ninherit%N")
            if in.parent_count = 0 then
                indent_to (1)
                io.put_string (help)
                io.new_line
                indent_to (2)
                io.put_string ("undefine%N")
                indent_to (3)
                io.put_string ("copy, is_equal%N")
                indent_to (2)
                io.put_string ("end;%N")
                indent_to (1)
                io.put_string ("STANDARD_STUB%N")
                indent_to (2)
                io.put_string ("redefine%N")
                indent_to (3)
                io.put_string ("make_with_peer%N")
                indent_to (2)
                io.put_string ("end;%N")
                indent_to (1)
                io.put_string (name)
                io.new_line
                indent_to (2)
                io.put_string ("undefine%N")
                indent_to (3)
                io.put_string ("implementation, copy, is_equal%N")
                indent_to (2)
                io.put_string ("redefine%N")
                indent_to (3)
                io.put_string ("make%N")
                indent_to (2)
                io.put_string ("end%N")
            else -- in.parent_count > 0
                from
                    indent_to (1)
                    io.put_string (help)
                    io.new_line
                    indent_to (2)
                    io.put_string ("undefine%N")
                    indent_to (3)
                    io.put_string ("copy, is_equal%N")
                    indent_to (2)
                    io.put_string ("end;%N")
                    indent_to (1)
                    io.put_string (name)
                    io.new_line
                    indent_to (2)
                    io.put_string ("undefine%N")
                    indent_to (3)
                    io.put_string ("implementation%N")
                    indent_to (2)
                    io.put_string ("end;%N")
                    i := 1
                    n := in.parent_count
                until
                    i > n
                loop
                    indent_to (1)
                    name := scoped_name_to_class_name (in.parent_at (i))
                    io.put_string (name)
                    io.put_string ("_STUB")
                    io.new_line
                    indent_to (2)
                    io.put_string ("undefine%N")
                    indent_to (3)
                    io.put_string ("copy, is_equal, make,%N")
                    indent_to (3)
                    io.put_string ("repoid, type_name,%N")
                    indent_to (3)
                    io.put_string ("consume, valid_message_type,%N")
                    indent_to (3)
                    io.put_string ("template")
                    if i > 1 then
                        io.put_string (", make_with_peer, implementation%N")
                    else
                        io.new_line
                    end -- if i > 1 then ...
                    indent_to (2)
                    io.put_string ("end")
                    if i < n then
                        io.put_string (";%N")
                    end
                    i := i + 1
                end
            end
            io.new_line
            io.new_line
        end
----------------------

    generate_interface_creators is

        do
            io.put_string ("creation%N")
            indent_to (1)
            io.put_string ("make, make_with_peer%N%N")
        end
----------------------

    generate_interface_make (in : INTERFACE) is

        do
            if in.parent_count = 0 then
                indent_to (1)
                io.put_string ("make is%N%N")
                indent_to (2)
                io.put_string ("do%N")
                indent_to (3)
                io.put_string ("precursor%N")
                indent_to (3)
                io.put_string ("am_a_stub := true%N")
                indent_to (2)
                io.put_string ("end%N%N")
                indent_to (1)
                io.put_string ("make_with_peer (o : CORBA_OBJECT) is%N%N")
                indent_to (2)
                io.put_string ("do%N")
                indent_to (3)
                io.put_string ("precursor (o)%N")
                indent_to (3)
                io.put_string ("am_a_stub := true%N")
                indent_to (3)
                io.put_string ("ior := o.ior%N")
                indent_to (2)
                io.put_string ("end%N%N")
            end
        end
----------------------

    generate_project_helper is

        local
            help  : STRING
            he    : STRING
            path  : STRING

        do

            help := clone (project)
            help.append ("_helper")
            he   := clone (help)
            he.append (".e")
            help.to_upper
            path := fs.concat_paths (root, he)
            create tf.make_open_write (path)
            io.set_file_default (tf)
            io.put_string ("class ")
            io.put_string (help)
            io.new_line
            generate_standard_warning
            io.put_string ("%Ninherit%N")
            indent_to (1)
            io.put_string (constant_classname)
            io.put_string (";%N")
            indent_to (1)
            io.put_string ("STANDARD_NARROW_HELPER%N%N")
            io.put_string ("feature%N%N")
            generate_narrows
            io.put_string ("end -- class ")
            io.put_string (help)
            io.new_line
            tf.close
        end
----------------------------------------------------

    generate_narrows is

        local
            it     : ITERATOR
            sn     : SCOPED_NAME
            repoid : STRING
            lnc    : STRING

        do
            from
                it := types_defined_here.iterator
            until
                it.finished
            loop
                sn  := types_defined_here.item (it)
                lnc := sn.last_name_component
                if not equal (lnc, "TypeCode") then
                    repoid := scoped_name_to_repoid (sn)
                    indent_to (1)
                    io.put_string (scoped_name_to_narrow_name (sn))
                    io.put_string (" (o : CORBA_OBJECT) : ")
                    io.put_string (scoped_name_to_class_name (sn))
                    io.put_string (" is%N%N")
                    indent_to (2)
                    io.put_string ("require%N")
                    indent_to (3)
                    io.put_string ("nonvoid_arg: o /= void%N%N")
                    indent_to (2)
                    io.put_string ("local%N")
                    indent_to (3)
                    io.put_string ("id : STRING%N%N")
                    indent_to (2)
                    io.put_string ("do%N")
                    indent_to (3)
                    io.put_string ("id := o.repoid%N")
                    indent_to (3)
                    io.put_string ("if equal (id, %"")
                    io.put_string (repoid)
                    io.put_string ("%") then%N")
                    indent_to (4)
                    io.put_string ("if not local_objects.has (id) then%N")
                    indent_to (5)
                    io.put_string ("if o.simplified_is_a_remote (id) then%N")
                    indent_to (6)
                    io.put_string ("create {")
                    io.put_string (scoped_name_to_class_name (sn))
                    io.put_string ("_STUB}")
                    io.put_string (" result.make_with_peer (o)%N")
                    indent_to (5)
                    io.put_string ("elseif o.is_a_stub then%N")
                    indent_to (6)
                    io.put_string ("result ?= o%N")
                    indent_to (5)
                    io.put_string ("else%N")
                    indent_to (6)
                    io.put_string ("result ?= horb.bind (o, %"local:%")%N")
                    indent_to (5)
                    io.put_string ("end%N")
                    indent_to (5)
                    io.put_string ("local_objects.put (result, id)%N")
                    indent_to (4)
                    io.put_string ("end -- if not local_objects.has (id) %
                                   %then ...%N")
                    indent_to (3)
                    io.put_string ("end -- if equal (id, %"")
                    io.put_string  (repoid)
                    io.put_string ("%") then ...%N")
                    indent_to (3)
                    io.put_string ("if result = void and then %
                                   %local_objects.has (id) then%N")
                    indent_to (4)
                    io.put_string ("result ?= local_objects.at (id)%N")
                    indent_to (3)
                    io.put_string ("end%N")
                    indent_to (2)
                    io.put_string ("end%N%N")
                end -- if not equal (lnc, "TypeCode") then ...
                it.forth
            end
            from
                it := exceptions.iterator
            until
                it.finished
            loop
                sn := exceptions.key (it)
                indent_to (1)
                io.put_string (scoped_name_to_narrow_name (sn))
                io.put_string (" (ex : CORBA_EXCEPTION) : ")
                io.put_string (scoped_name_to_class_name (sn))
                io.put_string (" is%N%N")
                indent_to (2)
                io.put_string ("require%N")
                indent_to (3)
                io.put_string ("nonvoid_arg : ex /= void%N%N")
                indent_to (2)
                io.put_string ("local%N")
                indent_to (3)
                io.put_string ("uuex : UNKNOWN_USER_EXCEPTION%N%N")
                indent_to (2)
                io.put_string ("do%N")
                indent_to (3)
                io.put_string ("uuex ?= ex%N")
                indent_to (3)
                io.put_string ("if uuex /= void then%N")
                indent_to (4)
                io.put_string ("create result.make_default%N")
                indent_to (4)
                io.put_string ("result.exception_from_any (%N")
                indent_to (4)
                io.put_string ("   uuex.exception_from_typecode (")
                io.put_string (scoped_name_to_tcname (sn))
                io.put_string ("))%N")
                indent_to (3)
                io.put_string ("end%N")
                indent_to (2)
                io.put_string ("end%N%N")
                it.forth
            end
        end
----------------------

    generate_undefines (extra : STRING) is

        do
            indent_to (2)
            io.put_string ("undefine%N")
            indent_to (3)
            io.put_string ("copy, is_equal")
            if extra /= void then
                io.put_string (", ")
                io.put_string (extra)
            end
            io.new_line
        end
----------------------

    generate_attributes (ad : ATTR_DCL) is

        do
        end
----------------------

    generate_attribute_mutators (ad : ATTR_DCL) is

        local
            i, n   : INTEGER
            name   : STRING
            type   : STRING
            vname  : STRING
            sn     : SCOPED_NAME
            cplx   : ARRAY [BOOLEAN]
            ctypes : ARRAY [SCOPED_NAME]

        do
            vname := safe_name ("value", true)
            type  := param_type_spec_to_string (ad.param_type_spec)

            from
                i   := 1
                n   := ad.component_count
            until
                i > n
            loop
                name := "_set_"
                name.append (ad.component_at (i).identifier)
                sn ?= ad.param_type_spec
                if sn /= void       and then
                   is_complex_type (sn) then
                    create cplx.make (1, 1)
                    cplx.put (true, 1)
                    create ctypes.make (1, 1)
                    ctypes.put (sn, 1)
                end
                indent_to (1)
                io.put_string ("set_")
                ad.component_at (i).accept (current)
                io.put_string (" (")
                io.put_string (vname)
                io.put_string (" : ")
                is_param_type_spec := true
                ad.param_type_spec.accept (current)
                is_param_type_spec := false
                io.put_string (") is%N%N")
                if cplx /= void then
                    indent_to (2)
                    io.put_string ("local%N")
                    indent_to (3)
                    io.put_string ("ca : CORBA_ANY%N%N")
                end
                indent_to (2)
                io.put_string ("do%N")
                generate_request (current_classname, name,
                                  "void", void, void, void,
                                  <<"value">>, <<"in">>, <<type>>,
                                  void, cplx, ctypes, void, false)
                indent_to (2)
                io.put_string ("end%N%N")
                i := i + 1
            end
        end
----------------------

    generate_attribute_accessors (ad : ATTR_DCL) is

        local
            i, n   : INTEGER
            name   : STRING
            type   : STRING
            rtype  : STRING
            tcfunc : STRING
            sn     : SCOPED_NAME
            lnc    : STRING
            nname  : STRING

        do
            sn ?= ad.param_type_spec
            if sn /= void then
                lnc := sn.last_name_component
            end
            if sn /= void               and then
               types_defined_here.has (lnc) then
                type  := "ref"
                nname := scoped_name_to_narrow_name (sn)
            else
                type := param_type_spec_to_string (ad.param_type_spec)
            end
            if sn /= void       and then
               is_complex_type (sn) then
                tcfunc := scoped_name_to_tcname (sn)
                rtype  := complex_type_from_scoped_name (sn)
            end
            from
                i   := 1
                n   := ad.component_count
            until
                i > n
            loop
                name := "_get_"
                name.append (ad.component_at (i).identifier)
                indent_to (1)
                ad.component_at (i).accept (current)
                io.put_string (" : ")
                ad.param_type_spec.accept (current)
                io.put_string (" is%N%N")
                if nname /= void then
                    indent_to (2)
                    io.put_string ("local%N")
                    indent_to (3)
                    io.put_string ("o : CORBA_OBJECT%N%N")
                end
                indent_to (2)
                io.put_string ("do%N")
                generate_request (current_classname, name,
                                  type, tcfunc, rtype, nname,
                                  dummy, dummy, dummy,
                                  void, void, void, void, false)
                indent_to (2)
                io.put_string ("end%N%N")
                i := i + 1
            end
        end
----------------------

    generate_routine_body (od : OP_DCL) is

        local
            oname    : STRING
            cname    : STRING
            i, n     : INTEGER
            pd       : PARAM_DCL
            anames   : ARRAY [STRING]
            aattrs   : ARRAY [STRING]
            atypes   : ARRAY [STRING]
            otypes   : ARRAY [STRING]
            complex  : ARRAY [BOOLEAN]
            ctypes   : ARRAY [SCOPED_NAME]
            ret_type : STRING
            nar_name : STRING
            rtype    : STRING
            atype    : STRING
            tc_func  : STRING
            a        : STRING
            m        : STRING
            t        : STRING
            lnc      : STRING
            sn       : SCOPED_NAME
            outv     : BOOLEAN
            need_ca  : BOOLEAN
            need_ob  : BOOLEAN

        do
            oname := clone (od.name)
            cname := clone (current_interface)
            sn    ?= od.op_type_spec
            if sn /= void then
                lnc      := sn.last_name_component
                need_ob  := types_defined_here.has (lnc)
                if not equal (sn.last_name_component, "Object") then
                    nar_name := scoped_name_to_narrow_name (sn)
                end
                if is_complex_type (sn) then
                    tc_func := scoped_name_to_tcname (sn)
                    rtype   := complex_type_from_scoped_name (sn)
                end -- if is_complex_type (sn) then ...
            end -- if sn /= void and then ...
            ret_type := op_type_spec_to_string (od.op_type_spec)
            ret_type := return_type (ret_type)


            from
                i := 1
                n := od.component_count
                create anames.make (1, n)
                create aattrs.make (1, n)
                create atypes.make (1, n)
                create otypes.make (1, n)
                create complex.make (1, n)
                create ctypes.make (1, n)
            until
                i > n
            loop
                pd    := od.component_at (i)
                sn    ?= pd.param_type_spec
                if sn /= void and then is_complex_type (sn) then
                    need_ca := true
                    complex.put (true, i)
                    ctypes.put (sn, i)
                    atype := complex_type_from_scoped_name (sn)
                else
                    atype := param_type_spec_to_string (pd.param_type_spec)
                end
                atypes.put (atype, i)
                sn ?= pd.param_type_spec
                if sn /= void then
                    atype := sn.last_name_component
                else
                    atype := param_type_spec_to_string_orig (
                                                pd.param_type_spec)
                end
                otypes.put (atype, i)
                outv := outv or else not equal (pd.param_attribute, "in")
                anames.put (pd.declarator, i)
                aattrs.put (pd.param_attribute, i)
                i := i + 1
            end -- loop
            if outv    or else
               need_ca or else
               need_ob    then
                indent_to (2)
                io.put_string ("local%N")
                from
                    i := 1
                until
                    i > n
                loop
                    pd := od.component_at (i)
                    a  := aattrs.item (i)
                    m  := anames.item (i)
                    t  := arg_type (atypes.item (i))
                    if (equal (t, "ref") or else equal (t, "string"))
                        and then not equal (a, "in") then
                        indent_to (3)
                        io.put_string (m)
                        io.put_string ("out : ")
                        is_param_type_spec := true
                        pd.param_type_spec.accept (current)
                        is_param_type_spec := false
                        io.new_line
                    end
                    i := i + 1 
                end
                if need_ca then
                    indent_to (3)
                    io.put_string ("ca : CORBA_ANY%N")
                end
                if need_ob then
                    indent_to (3)
                    io.put_string ("o : CORBA_OBJECT%N")
                end
                io.new_line
            end -- if outv then ...
            indent_to (2)
            io.put_string ("do%N")
            generate_request (cname, oname, ret_type,
                              tc_func, rtype, nar_name,
                              anames, aattrs, atypes, otypes, complex,
                              ctypes, od.raises_expr, od.oneway)
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    arg_type (t : STRING) : STRING is

        local
            t1 : STRING

        do
            t1 := clone (t)
            t1.to_lower
            if is_basic_type (t1)   or else
               equal (t1, "any")    or else
               equal (t1, "string") or else
               equal (t1, "wstring") then
                result := t1
            elseif equal (t1, "fixed") then
                result := "double"
            elseif equal (t1, "typecode") then
                result := "typecode"
            else
                result := "ref"
            end
        end
----------------------

    return_type (t : STRING) : STRING is

        do
            if equal (t, "void") then
                result := t
            else
                result := arg_type (t)
            end
        end
----------------------

    frozen generate_request (cl_name, op_name, ret_type,
                             tc_func, rtype, nname : STRING;
                             arg_names  : ARRAY [STRING];
                             arg_attrs  : ARRAY [STRING];
                             arg_types  : ARRAY [STRING];
                             orig_types : ARRAY [STRING];
                             complex    : ARRAY [BOOLEAN];
                             com_types  : ARRAY [SCOPED_NAME];
                             excep      : RAISES_EXPR;
                             oneway     : BOOLEAN) is

        require
            nonvoid_args    : cl_name /= void and then op_name /= void
                              and then ret_type /= void and then
                              arg_names /= void and then arg_attrs /= void
                              and then arg_types /= void
            matching_lowers : arg_names.lower = arg_attrs.lower and then
                              arg_names.lower = arg_types.lower
            matching_uppers : arg_names.upper = arg_attrs.upper and then
                              arg_names.upper = arg_types.upper
            nonvoid_com     : complex /= void implies
                              com_types /= void
            nonvoid_rtype   : tc_func /= void implies
                              rtype /= void

        local
            i, n   : INTEGER
            a, m   : STRING
            t, t1  : STRING
            cplx   : BOOLEAN
            sn     : SCOPED_NAME

        do
            indent_to (3)
            io.put_string ("begin_request (%"")
            io.put_string (op_name)
            io.put_string ("%")%N")
            from
                i := arg_names.lower
                n := arg_names.upper
            until
                i > n
            loop
                t1 := arg_types.item (i)
                t  := arg_type (t1)
                a  := arg_attrs.item (i)
                m  := arg_names.item (i)
                if complex /= void then
                    cplx := complex.item (i)
                    if cplx then
                        sn := com_types.item (i)
                    end
                end
                generate_parameter_marshalling_code (t, t1, a, m, cplx, sn)
                i := i + 1
            end

            if excep /= void then
                excep.accept (current)
            end

            if not equal (ret_type, "void") and then
               not oneway then
                indent_to (3)
                io.put_string ("result_is_")
                if tc_func /= void then
                    io.put_string ("of_type (")
                    io.put_string (tc_func)
                    io.putchar (')')
                else
                io.put_string (ret_type)    
                end
                io.new_line
            end

            indent_to (3)
            if oneway then
                io.put_string ("send_oneway%N")
            else
                io.put_string ("invoke%N")
            end
            if not oneway then
                from
                    i := arg_names.lower
                until
                    i > n
                loop
                    if not equal (arg_attrs.item (i), "in") then
                        indent_to (3)
                        t1 := arg_types.item (i)
                        if complex.item (i) then
                            t := complex_type_from_scoped_name
                                                (com_types.item (i))
                        else
                            t := arg_type (t1)
                        end
                        t1 := orig_types.item (i)
                        a  := arg_names.item (i)
                        generate_out_parameter_demarshalling_code (t, t1, a)
                    end
                    i := i + 1
                end
                if not equal (ret_type, "void") then
                    generate_result_demarshalling_code (rtype,
                                                        ret_type,
                                                        nname,
                                                        (tc_func /= void))
                end
            end -- if not oneway then ...
            indent_to (3)
            io.put_string ("end_request%N")
        end
----------------------

    generate_parameter_marshalling_code (t, t1, a, m : STRING;
                                         cplx : BOOLEAN;
                                         sn : SCOPED_NAME) is
        -- `t' is "ref", if the parameter is an interface type.
        -- `a' is the parameter attribute: in, out, inout.
        -- `m' is the name of the parameter.
        -- `cplx = true' means it's a complex type: struct sequence, etc.
        -- if `cplx = true' `sn' is the scoped name of the parameter type.
        -- `t1' is the Eiffel type.

        do
            if cplx then
                if not equal (a, "out") then
                    indent_to (3)
                    io.put_string ("create ca.make1 (")
                    io.put_string (scoped_name_to_tcname (sn))
                    io.put_string (")%N")
                    indent_to (3)
                    io.put_string (safe_name (m, true))
                    io.putchar ('.')
                    io.put_string (complex_type_from_scoped_name (sn))
                    io.put_string ("_to_any (ca)%N")
                end -- if not equal (a, "out") then ...
                indent_to (3)
                io.put_string ("stub_add_")
                io.put_string (a)
                if equal (a, "out") then
                    io.put_string ("_arg_with_type (%"")
                    io.put_string (safe_name (m, true))
                    io.put_string ("%", ")
                    io.put_string (scoped_name_to_tcname (sn))
                    io.put_string (")%N")
                else -- it's "in" or "inout"
                    io.put_string ("_arg_any (%"")
                    io.put_string (safe_name (m, true))
                    io.put_string ("%", ca)%N")
                end
            else -- not cplx
                indent_to (3)
                io.put_string ("stub_add_")
                io.put_string (a)
                io.put_string ("_arg_")
                io.put_string (t)
                io.put_string (" (%"")
                io.put_string (m)
                io.putchar ('"')
                if equal (a, "out") then
                    io.put_string (")%N")
                elseif not equal (a, "out") then
                    io.put_string (", ")
                    if equal (t, "ref") then
                        io.put_string (safe_name (m, true))
                        if equal (t1, "CORBA_OBJECT") then
                            io.put_string (".class_name, ")
                        else
                            io.put_string (".type_name, ")    
                        end
                    end
                    io.put_string (safe_name (m, true))
                    if equal (t, "ref")     and then
                       not equal (t1, "CORBA_OBJECT") then
                        io.put_string (".implementation")
                    end
                    io.put_string (")%N")
                end
            end -- if cplx then ...
        end
----------------------

    generate_out_parameter_demarshalling_code (t, t1, a : STRING) is
        -- `t' is "ref" if it's an interface type; it the type is a
        -- complex type (struct, sequence, ...) then `t' says which.
        -- `t1' is the original IDL type.
        -- `a' is the parameter name.

        local
            sname : STRING

        do
            sname := safe_name (a, true)
            if equal (t, "string") or else equal (t, "ref") then
                io.put_string (sname)
                io.put_string ("out ?= get_out_result_")
                io.put_string (t)
                io.put_string (" (%"")
                if equal (t, "ref") then
                    io.put_string (t1)
                    io.put_string ("%", %"")
                end
                io.put_string (a)
                io.put_string ("%")%N")
                indent_to (3)
                if equal (t, "ref") then
                    io.put_string (sname)
                    io.put_string (".set_item (")
                    io.put_string (sname)
                    io.put_string ("out)%N")
                else
                    io.put_string ("if ")
                    io.put_string (sname)
                    io.put_string ("out /= void then%N")
                    indent_to (4)
                    io.put_string (sname)
                    io.put_string (".copy (")
                    io.put_string (sname)
                    io.put_string ("out)%N")
                    indent_to (3)
                    io.put_string ("end%N")
                end
            elseif local_is_complex_type (t) then
                io.put_string ("create ")
                io.put_string (sname)
                io.put_string ("out.make_default%N")
                indent_to (3)
                io.put_string ("ca := get_out_result_any (%"")
                io.put_string (a)
                io.put_string ("%")%N")
                indent_to (3)
                io.put_string (sname)
                io.put_string ("out.")
                io.put_string (t)
                io.put_string ("_from_any (ca)%N")
                indent_to (3)
                io.put_string (sname)
                io.put_string (".copy (")
                io.put_string (sname)
                io.put_string ("out)%N")
            else
                io.put_string (sname)
                io.put_string (".set_item (get_out_result_")
                io.put_string (t)
                io.put_string (" (%"")
                io.put_string (a)
                io.put_string ("%"))%N")
            end -- if equal (t, "string") or else ...
        end
----------------------

    generate_result_demarshalling_code (t, t1, n : STRING; cplx : BOOLEAN) is
        -- `cplx = true' means it's a struct, sequence, etc.
        -- `t' says which of these it is, if `cplx = true'.
        -- `t1' is the type of the return value: integer, boolean, etc.
        -- `n' is the name of the _narrow function in cases where
        -- it is needed.

        do
            indent_to (3)
            if cplx then
                if equal (t, "struct")   or else
                   equal (t, "sequence") or else
                   equal (t, "enum")        then
                    io.put_string ("create result.make_default%N")
                else
                    io.put_string ("create result.make%N")
                end
                indent_to (3)
                io.put_string ("result.")
                io.put_string (t)
                io.put_string ("_from_any (get_result_as_any)")
            elseif equal (t1, "typecode") then
                io.put_string ("result := get_result_typecode")
            elseif n /= void then
                io.put_string ("o := get_result_ref%N")
                indent_to (3)
                io.put_string ("result := ")
                io.put_string (n)
                io.put_string (" (o)")
            elseif equal (t1, "ref") then
                io.put_string ("result := get_result_ref")
            else
                io.put_string ("result := get_result_")
                if equal (t1, "any") then
                    io.put_string ("as_")
                end
                io.put_string (t1)
            end
            io.new_line
        end
----------------------

    dummy : ARRAY [STRING] is
        -- An array of length 0

        once
            create result.make (1, 0)
        end

end -- class EIFFEL_STUB_VISITOR

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
