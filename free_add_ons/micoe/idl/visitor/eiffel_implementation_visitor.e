indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class EIFFEL_IMPLEMENTATION_VISITOR

inherit
    TYPECODE_CONSTANTS;
    EIFFEL_CODE_VISITOR
        redefine
            generate_struct_make,
            generate_except_make,
            generate_member_attributes,
            generate_member_mutators_and_accessors,
            generate_union_make,
            generate_union_set_value,
            generate_union_get_value,
            generate_union_set_default,
            generate_union_get_discriminator,
            generate_union_attribute,
            generate_enum_constants,
            generate_enum_make,
            generate_enum_get_value,
            generate_enum_set_value,
            generate_enum_attribute,
            generate_sequence_make,
            generate_sequence_get_value,
            generate_sequence_set_value,
            generate_sequence_attribute,
            generate_sequence_length,
            generate_array_make,
            generate_array_get_value,
            generate_array_set_value,
            generate_array_attribute,
            generate_consume,
            generate_valid_message_type,
            generate_template           
        end

creation
    make

feature

    interfaces_deferred : BOOLEAN is

        do
            result := true
        end
----------------------

    is_a_stub : BOOLEAN is

        do
            result := false
        end
----------------------

    is_a_skeleton : BOOLEAN is

        do
            result := false
        end
----------------------

    is_an_implementation : BOOLEAN is

        do
            result := true
        end
----------------------

    is_a_servant : BOOLEAN is

        do
            result := false
        end
----------------------

    visitor_type : INTEGER is

        do
            result := 3
        end
----------------------

    standard_parent : STRING is

        do
            result := "CONSUMER"
        end
----------------------

    root : STRING is

        do
            result := clone (path_prefix)
            result := fs.concat_paths (result, "base")
            if not fs.cluster_exists (result) then
                fs.add_cluster (result, "lm.lm")
            end
        end
----------------------

    class_name_suffix : STRING is

        do
            -- none
        end
----------------------

    generate_interface_inherit (in : INTERFACE) is

        local
            cname : STRING
            name  : STRING
            hname : STRING
            i, n  : INTEGER

        do
            cname := constant_classname
            hname := clone (project)
            hname.append ("_helper")
            hname.to_upper
            io.put_string ("%Ninherit%N")
            if in.parent_count = 0 then
                indent_to (1)
                io.put_string ("IMPLEMENTATION_BASE%N")
                indent_to (2)
                io.put_string ("redefine%N")
                indent_to (3)
                io.put_string ("repoid, consume, valid_message_type%N")
                indent_to (2)
                io.put_string ("end")

                if cname = void and then in.parent_count = 0 then
                    io.new_line
                else
                    io.put_string (";%N")
                end
            end -- if in.parent_count = 0 then ...

            if cname /= void then
                indent_to (1)
                io.put_string (cname)
                io.new_line
                generate_undefines (void)
                indent_to (2)
                io.put_string ("end;%N")
            end

            indent_to (1)
            io.put_string (hname)
            io.new_line
            generate_undefines (void)
            indent_to (2)
            if in.parent_count > 0 then
                io.put_string ("end;%N")
            else
                io.put_string ("end%N%N")
            end

            if in.parent_count > 0 then
                from
                    i     := 1
                    n     := in.parent_count
                until
                    i > n
                loop
                    indent_to (1)
                    name := scoped_name_to_class_name (in.parent_at (i))
                    io.put_string (name)
                    io.new_line
                    indent_to (2)
                    if i > 1 then
                        io.put_string ("undefine%N")
                        indent_to (3)
                        io.put_string ("repoid, type_name, consume, %
                                       %valid_message_type, template%N")
                    else
                        io.put_string ("redefine%N")
                        indent_to (3)
                        io.put_string ("repoid, type_name, %
                                       %consume, valid_message_type%N")
                    end
                    indent_to (2)
                    io.put_string ("end%N")

                    if i < n then
                        io.put_string (";%N")
                    else
                        io.new_line
                    end
                    i := i + 1
                end -- loop
            end
        end
----------------------

    generate_interface_creators is

        do
            -- Base class is deferred
        end
----------------------

    generate_interface_make (in : INTERFACE) is

        do
            -- Not needed in base classes.
        end
----------------------

    standard_sequence_length : INTEGER is
        -- Unbounded sequences begin life this size.

        do
            result := 20
        end
----------------------

    generate_consume is

        local
            mname  : STRING
            tname  : STRING
            i, n   : INTEGER
            j, m   : INTEGER
            k, l   : INTEGER
            p      : INTEGER
            sn     : SCOPED_NAME
            od     : OP_DCL
            pd     : PARAM_DCL
            name   : STRING
            type1  : STRING
            type2  : STRING
            namel  : INDEXED_LIST [STRING]
            typel  : INDEXED_LIST [STRING]
            ltypel : INDEXED_LIST [STRING]
            refl   : INDEXED_LIST [BOOLEAN]
            map1   : DICTIONARY [INTEGER, STRING]
            map2   : DICTIONARY [INTEGER, STRING]
                -- The indices used so far for this type.

        do
            from
                create namel.make (false)
                create typel.make (false)
                create ltypel.make (false)
                create refl.make (false)
                create map1.make
                i := 1
                k := 1
                n := pending_routines.count
            until
                i > n
            loop
                od    := pending_routines.at (i)
                type1 := op_type_spec_to_string (od.op_type_spec)
                if not equal (type1, "void") then
                    if not map1.has (type1) then
                        if equal (type1, "any") then
                            type2 := "CORBA_ANY"
                        elseif equal (type1, "typecode") then
                            type2 := "CORBA_TYPECODE"
                        else
                            type2 := clone (type1)
                            type2.to_upper
                        end
                        name := "x"
                        name.append_integer (k)
                        namel.append (name)
                        typel.append (type2)
                        ltypel.append (type2)
                        refl.append (false)
                        map1.put (k, type1)
                        k := k + 1
                    end
                end
                i := i + 1
            end
            from
                i := 1
                n := pending_routines.count
                create map2.make
            until
                i > n
            loop
                od := pending_routines.at (i)
                from
                    j := 1
                    m := od.component_count
                until
                    j > m
                loop
                    pd := od.component_at (j)
                    type1 := param_type_spec_to_string (pd.param_type_spec)
                    if not map2.has (type1) then
                        l     := max_args (type1)
                        map2.put (k, type1)
                        from
                            p := 0
                        until
                            p >= l
                        loop
                            name := "x"
                            name.append_integer (k + p)
                            namel.append (name)
                            typel.append (type1)
                            if equal (type1, "any") then
                                type2 := "CORBA_ANY"
                            elseif equal (type1, "typecode") then
                                type2 := "CORBA_TYPECODE"
                            else
                                type2 := clone (type1)
                                type2.to_upper
                            end
                            if equal (pd.param_attribute, "in") then
                                refl.append (false)
                                ltypel.append (type2)
                            else
                                refl.append (true)
                                sn ?= pd.param_type_spec
                                if sn /= void then
                                    if is_complex_type (sn) then
                                        type2 := scoped_name_to_class_name (sn)
                                        ltypel.append (type2)
                                    else
                                        ltypel.append (sn.last_name_component)
                                    end
                                else
                                    ltypel.append (type2)
                                end
                            end
                            p := p + 1
                        end
                        k := k + l
                    end
                    j := j + 1
                end
                i := i + 1
            end

            mname := safe_name ("msg", true)
            tname := safe_name ("type", true)

            io.put_string ("feature { COURIER, CONSUMER }%N%N")
            indent_to (1)
            io.put_string ("consume (")
            io.put_string (mname)
            io.put_string (" : ANY; ")
            io.put_string (tname)
            io.put_string (" : INTEGER) is %N%N")
            if pending_routines.count > 0 then
                indent_to (2)
                io.put_string ("local%N")
                indent_to (3)
                io.put_string ("req : CORBA_SERVER_REQUEST%N")
                indent_to (3)
                io.put_string ("ca  : CORBA_ANY%N")
                indent_to (3)
                io.put_string ("o   : CORBA_OBJECT%N")
                indent_to (3)
                io.put_string ("dum : BOOLEAN%N")
                from
                    i := 1
                    n := namel.count
                until
                    i > n
                loop
                    indent_to (3)
                    io.put_string (namel.at (i))
                    io.put_string ("  : ")
                    if refl.at (i) then
                        if equal (ltypel.at (i), "Object")     or else
                           types_defined_here.has (ltypel.at (i)) then
                            type2 := "ANY_REF"
                        elseif is_basic_type (ltypel.at (i)) then
                            type2 := eiffel_type (ltypel.at (i))
                            type2.append ("_REF")
                        else
                            type2 := ltypel.at (i)
                        end
                    else
                        type2 := eiffel_type (ltypel.at (i))
                    end
                    io.put_string (type2)
                    io.new_line
                    i := i + 1
                end
                io.new_line
            end -- if pending_routines.count > 0 then ...
            indent_to (2)
            io.put_string ("do%N")


            if pending_routines.count > 0 then
                indent_to (3)
                io.put_string ("req ?= ")
                io.put_string (mname)
                io.new_line
                indent_to (3)
                io.put_string ("create ca.make%N")
                indent_to (3)
                io.put_string ("req.mico_set_result (ca)%N")
                indent_to (3)
                io.put_string ("begin_invoke%N%N")
                indent_to (3)
                io.put_string ("inspect ")
                io.put_string (tname)
                io.put_string ("%N%N")
            end
            if pending_routines.count > 0 then
                from
                    i := 1
                    n := pending_routines.count
                until
                    i > n
                loop
                    od := pending_routines.at (i)
                    indent_to (3)
                    io.put_string ("when ")
                    io.putint (i)
                    io.put_string (" then%N")
                    generate_routine_call (od, map1, map2)
                    i := i + 1
                end
                indent_to (3)
                io.put_string ("end%N")
                indent_to (3)
                io.put_string ("finish_invoke%N")
            else
                indent_to (3)
                io.put_string ("check%N")
                indent_to (4)
                io.put_string ("never_called : false%N")
                indent_to (3)
                io.put_string ("end%N")
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    max_args (type : STRING) : INTEGER is
        -- How many local entities of type `type' will
        -- consume need at the most?

        local
            i, n  : INTEGER
            j, m  : INTEGER
            cnt   : INTEGER
            od    : OP_DCL
            pd    : PARAM_DCL
            type1 : STRING

        do
            from
                i := 1
                n := pending_routines.count
            until
                i > n
            loop
                od := pending_routines.at (i)
                i  := i + 1
                from
                    j   := 1
                    m   := od.component_count
                    cnt := 0
                until
                    j > m
                loop
                    pd := od.component_at (j)
                    j  := j + 1
                    type1 := param_type_spec_to_string (pd.param_type_spec)
                    if equal (type, type1) then
                        cnt := cnt + 1
                    end
                end
                if cnt > result then
                    result := cnt
                end
            end
        end
----------------------

    generate_routine_call (od : OP_DCL;
                           map1 : DICTIONARY [INTEGER, STRING];
                           map2 : DICTIONARY [INTEGER, STRING]) is
        -- If there are l local entities of type t then they have
        -- the indices k, k + 1, ..., k + l - 1 where k = map2.at (t).

        local
            i, n  : INTEGER
            k     : INTEGER
            pd    : PARAM_DCL
            sn    : SCOPED_NAME
            lnc   : STRING
            type1 : STRING
            type2 : STRING
            rtype : STRING
            ptype : STRING
            oname : STRING
            used  : DICTIONARY [INTEGER, STRING]
                -- The highest index used yet for this type.
            outp : INDEXED_CATALOG [STRING_PAIR, STRING]
                -- The indices of all out or inout parameters of this type.
            it      : ITERATOR
            need_tc : BOOLEAN

        do
            -- first initialize `used'.
            from
                create used.make
                create outp.make
                it := map2.iterator
            until
                it.finished
            loop
                used.put (0, map2.key (it))
                it.forth
            end
            -- build the CORBA_NV_LIST to be filled in by
            -- CORBA_SERVER_REQUEST.set_params
            from
                i := 1
                n := od.component_count
            until
                i > n
            loop
                pd      := od.component_at (i)
                i       := i + 1
                generate_parameter_reporting_code (pd)
            end
            if n > 0 then
                indent_to (4)
                io.put_string ("dum := req.set_params (nvl)%N")
            end

            from
                i := 1
                n := od.component_count
            until
                i > n
            loop
                pd    := od.component_at (i)
                generate_parameter_evaluating_code (pd, map2, used, outp)
                i := i + 1
            end -- loop over i
            type1 := op_type_spec_to_string (od.op_type_spec)
            type2 := clone (type1)
            if not equal (type1, "void") and then
               map1.has (type2)              then
                k := map1.at (type2)
                indent_to (4)
                io.putchar ('x')
                io.putint (k)
                io.put_string (" := ")
            else
                indent_to (4)
            end -- if not equal (type1, "void") ...
            oname := od.name
            if oname.substring_index ("_get_", 1) > 0 then
                oname := oname.substring (6, oname.count)
            elseif oname.substring_index ("_set_", 1) > 0 then
                oname := oname.substring (2, oname.count)
            end
            io.put_string (safe_name (oname, false))
            -- now reinitialize `used'.
            from
                create used.make
                it := map2.iterator
            until
                it.finished
            loop
                used.put (0, map2.key (it))
                it.forth
            end
            from
                i := 1
                n := od.component_count
                if n > 0 then
                    io.put_string (" (")
                end
            until
                i > n
            loop
                pd := od.component_at (i)
                type2 := param_type_spec_to_string (pd.param_type_spec)
                k := used.at (type2)
                used.put (k + 1, type2)
                io.putchar ('x')
                io.putint (map2.at (type2) + k)
                i := i + 1
                if i > n then
                    io.put_string (")")
                else
                    io.put_string (", ")
                end -- if i > n then ...
            end -- loop over i
            io.new_line
            if outp.count > 0 then
                generate_out_parameter_returning_code (outp)
            end
            generate_result_returning_code (od.op_type_spec, map1)
        end
----------------------

    generate_parameter_reporting_code (pd : PARAM_DCL) is

        local
            need_tc : BOOLEAN
            type1   : STRING
            sn      : SCOPED_NAME

        do
            need_tc := false
            type1 := param_type_spec_to_string (pd.param_type_spec)
            sn    ?= pd.param_type_spec
            type1.to_lower
            indent_to (4)
            io.put_string ("add_")
            io.put_string (pd.param_attribute)
            io.put_string ("_arg_")
            if is_basic_type (type1)    or else
               equal (type1, "wstring") or else
               equal (type1, "string")  then
               io.put_string (type1)
            elseif sn /= void and then is_complex_type (sn) then
                io.put_string("with_type")
                need_tc := true
            else
                io.put_string ("ref")
            end
            io.put_string (" (%"")
            io.put_string (pd.declarator)
            io.putchar ('"')
            if need_tc then
                io.put_string (", ")
                io.put_string (scoped_name_to_tcname (sn))
            end
            io.put_string (")%N")
        end
----------------------

    generate_parameter_evaluating_code (pd   : PARAM_DCL;
                             map2 : DICTIONARY [INTEGER, STRING];
                             used : DICTIONARY [INTEGER, STRING];
                             outp : INDEXED_CATALOG [STRING_PAIR, STRING]) is

        local
            k : INTEGER
            type1 : STRING
            type2 : STRING
            ptype : STRING
            lnc   : STRING
            sn    : SCOPED_NAME
            np    : STRING_PAIR
            arg   : STRING

        do
            type1 := param_type_spec_to_string (pd.param_type_spec)
            type2 := clone (type1)
            type2.to_lower
            sn ?= pd.param_type_spec
            if sn /= void then
                lnc := sn.last_name_component
                if is_complex_type (sn) then
                    ptype := scoped_name_to_complex_name (sn)
                    if ptype /= void then
                        ptype.to_lower
                    end
                elseif is_aliased_type (sn) then
                    ptype := aliased_type_from_scoped_name (sn)
                    if ptype /= void then
                        ptype.to_lower
                    end
                elseif types_defined_here.has (lnc) then
                    ptype := lnc
                elseif equal (lnc, "TypeCode") or else
                       equal (lnc, "Object")      then
                    ptype := lnc
                end -- if is_complex_type (sn) then ...
            end -- if sn /= void then ...
            if ptype = void then
                ptype := "any" -- desperation!
            end
            k := used.at (type1)
            used.put (k + 1, type1)

            if is_basic_type (type2)         or else
               equal (type2, "wstring")      or else
               equal (type2, "string")          then
                if equal (pd.param_attribute, "in") then
                    indent_to (4)
                    arg := "x"
                    arg.append_integer (map2.at (type1) + k)
                    io.put_string (arg)
                    io.put_string (" := nvl.get_")
                    io.put_string (type2)
                    io.put_string ("_value_by_name (%"")
                    io.put_string (pd.declarator)
                    io.put_string ("%")%N")
                elseif equal (pd.param_attribute, "inout") then
                    indent_to (4)
                    arg := "x"
                    arg.append_integer (map2.at (type1) + k)
                    io.put_string ("create ")
                    io.put_string (arg)
                    io.new_line
                    indent_to (4)
                    io.put_string (arg)
                    io.put_string (".set_item (nvl.get_")
                    io.put_string (type2)
                    io.put_string ("_value_by_name (%"")
                    io.put_string (pd.declarator)
                    io.put_string ("%"))%N")                    
                    !!np.make (pd.declarator, arg)
                    outp.add (np, type1)
                else -- it's an out parameter
                    arg := "x"
                    arg.append_integer (map2.at (type1) + k)
                    indent_to (4)
                    io.put_string ("create ")
                    io.put_string (arg)
                    io.new_line
                    !!np.make (pd.declarator, arg)
                    outp.add (np, type1)
                end
            elseif equal (ptype, "TypeCode") then
                arg := "x"
                arg.append_integer (map2.at (type1) + k)
                indent_to (4)
                io.put_string (arg)
                io.put_string (" := nvl.get_typecode_value_by_name (%"")
                io.put_string (pd.declarator)
                io.put_string ("%")%N")
            elseif equal (ptype, "Object") then
                arg := "x"
                arg.append_integer (map2.at (type1) + k)
                indent_to (4)
                io.put_string (arg)
                io.put_string (" := nvl.get_ref_value_by_name (%"Object%", %"")
                io.put_string (pd.declarator)
                io.put_string ("%")%N")
            elseif sn /= void then 
                if is_complex_type (sn) then
                    indent_to (4)
                    arg := "x"
                    arg.append_integer (map2.at (type1) + k)
                    io.put_string ("create ")
                    io.put_string (arg)
                    io.put_string (".make_default%N")
                    type2 := complex_type_from_scoped_name (sn)
                    if not equal (pd.param_attribute, "out") then
                        indent_to (4)
                        io.put_string (arg)
                        io.putchar ('.')
                        io.put_string (type2)
                        io.put_string ("_from_any (nvl.get_any_value_by_name %
                                       %(%"")
                        io.put_string (pd.declarator)
                        io.put_string ("%"))%N")
                    end
                    !!np.make (pd.declarator, arg)
                    outp.add (np, type2)
                elseif types_defined_here.has (lnc) then
                    type2 := scoped_name_to_narrow_name (
                                        types_defined_here. at (lnc))
                    indent_to (4)
                    if equal (pd.param_attribute, "out") then
                        -- create the ANY_REF
                        io.put_string ("create ")
                        arg := "x"
                        arg.append_integer (map2.at (type1) + k)
                        io.put_string (arg)
                        io.new_line
                        !!np.make (pd.declarator, arg)
                        outp.add (np, ptype)
                    else -- it's in or inout
                        io.put_string ("o := nvl.get_ref_value_by_name (%"")
                        io.put_string (ptype)
                        io.put_string ("%", %"")
                        io.put_string (pd.declarator)
                        io.put_string ("%")%N")
                        indent_to (4)
                        io.putchar ('x')
                        io.putint (map2.at (type1) + k)
                        io.put_string (" := ")
                        io.put_string (type2)
                        io.put_string (" (o)%N")
                    end
                end -- if is_complex_type (sn) then ...
            elseif equal (ptype, "string") then
                indent_to (4)
                io.putchar ('x')
                io.putint (map2.at (type1) + k)
                io.put_string (" := nvl.get_string_value_by_name (%"")
                io.put_string (pd.declarator)
                io.put_string ("%")%N")
            end
        end
----------------------

    micoe_idltype_to_eiffel_type (type : STRING) : STRING is

        do
            if equal (type, "ushort")    or else
               equal (type, "short")     or else
               equal (type, "ulong")     or else
               equal (type, "long")      or else
               equal (type, "ulonglong") or else
               equal (type, "longlong")     then
                result := "integer"
            elseif equal (type, "float") then
                result := "real"
            elseif equal (type, "double")  or else
                   equal (type, "longdouble") then
                result := "double"
            end
        end
----------------------

    generate_out_parameter_returning_code (
                        outp : INDEXED_CATALOG [STRING_PAIR, STRING]) is

        local
            l    : INDEXED_LIST [STRING_PAIR]
            t    : STRING
            it   : ITERATOR
            i, n : INTEGER
            np   : STRING_PAIR

        do
            from
                it := outp.iterator
            until
                it.finished
            loop
                l := outp.item (it)
                t := outp.key (it)
                from
                    i := l.low_index
                    n := l.high_index
                until
                    i > n
                loop
                    np := l.at (i)

                    if local_is_complex_type (t) then
                        indent_to (4)
                        io.put_string (np.second)
                        io.putchar ('.')
                        io.put_string (t)
                        io.put_string ("_to_any (nvl.get_any_value_by_name %
                                       %(%"")
                        io.put_string (np.first)
                        io.put_string ("%"))%N")
                    elseif is_basic_type (t) then
                        indent_to (4)
                        io.put_string ("ca.put_")
                        io.put_string (t)
                        io.put_string (" (")
                        io.put_string (np.second)
                        io.put_string (".item)%N")
                    else
                        indent_to (4)
                        io.put_string ("ca := nvl.item_by_name (%"")
                        io.put_string (np.first)
                        io.put_string ("%").value%N")
                        indent_to (4)
                        io.put_string ("o ?= ")
                        io.put_string (np.second)
                        io.put_string (".item%N")
                        indent_to (4)
                        io.put_string ("ca.put_object (%"")
                        io.put_string (t)
                        io.put_string ("%", o)%N")
                    end
                    i := i + 1
                end
                it.forth
            end
        end
----------------------

    generate_result_returning_code (ots  : OP_TYPE_SPEC;
                                    map1 : DICTIONARY [INTEGER, STRING]) is

        local
            type1 : STRING
            rtype : STRING
            k     : INTEGER
            sn    : SCOPED_NAME

        do
            type1 := op_type_spec_to_string (ots)
            sn ?= ots
            if sn /= void then
                rtype := scoped_name_to_complex_name (sn)
                if rtype /= void then
                    rtype.to_lower
                end
            end
            if not equal (type1, "void") and then
               map1.has (type1)              then
                k := map1.at (type1)
                indent_to (4)
                if is_basic_type (type1) then
                    io.put_string ("ca.put_")
                    io.put_string (ca_type (type1))
                    io.put_string (" (x")
                    io.putint (k)
                    io.put_string (")%N")
                elseif equal (type1, "string") then
                    io.put_string ("ca.put_string (x")
                    io.putint (k)
                    io.put_string (", 0)%N")
                elseif equal (type1, "wstring") then
                    io.put_string ("ca.put_wstring (x")
                    io.putint (k)
                    io.put_string (", 0)%N")
                elseif sn /= void and then is_complex_type (sn) then
                    io.put_string ("ca.make1 (")
                    io.put_string (scoped_name_to_tcname (sn))
                    io.put_string (")%N")
                    indent_to (4)
                    io.putchar ('x')
                    io.putint (k)
                    io.putchar ('.')
                    io.put_string (complex_type_from_scoped_name(sn))
                    io.put_string ("_to_any (ca)%N")
                elseif sn /= void and then is_aliased_type (sn) then
                    type1 := unaliased_type (sn)
                    if is_basic_type (type1)         or else
                       special_is_basic_type (type1) or else
                       equal (type1, "string")       or else
                       equal (type1, "wstring")         then
                        io.put_string ("ca.put_")
                        io.put_string (type1)
                        io.put_string (" (x")
                        io.putint (k)
                        if equal (type1, "string") then
                            io.put_string (", 0)%N")
                        else
                            io.put_string (")%N")
                        end
                    else
                        io.put_string ("ca.make1 (")
                        io.put_string (scoped_name_to_tcname (sn))
                        io.put_string (")%N")
                        indent_to (4)
                        io.putchar ('x')
                        io.putint (k)
                        io.putchar ('.')
                        io.put_string (aliased_type_from_scoped_name(sn))
                        io.put_string ("_to_any (ca)%N")
                    end
                elseif equal (type1, "any") then
                    io.put_string ("ca.put_any (x")
                    io.putint (k)
                    io.put_string (")%N")
                elseif equal (type1, "typecode") then
                    io.put_string ("ca.put_typecode (x")
                    io.putint (k)
                    io.put_string (")%N")
                else -- must be a ref
                    io.put_string ("ca.put_object (%"")
                    io.put_string (rtype)
                    io.put_string ("%", x")
                    io.putint (k)
                    io.put_string (")%N")
                end -- if is_basic_type (type1) then ...
            end -- if not equal (type1, "void") and then ...
        end
----------------------

    eiffel_type (in_type : STRING) : STRING is
        -- special to handle "wstring", but it may
        -- prove generally useful.

        do
            if equal (in_type, "wstring") then
                result := "ARRAY [INTEGER]"
            elseif types_defined_here.has (in_type) then
                result := "CORBA_OBJECT"
            elseif equal (in_type, "any") then
                result := "CORBA_ANY"
            else
                result := clone (in_type)
                result.to_upper
            end
        end
----------------------

    ca_type (t : STRING) : STRING is

        do
            if equal (t, "integer") then
                result := "long"
            elseif equal (t, "real") then
                result := "double"
            elseif equal (t, "character") then
                result := "char"
            else
                result := t
            end
        end
----------------------

    generate_valid_message_type is

        local
            mname, tname : STRING

        do
            mname := safe_name ("msg", true)
            tname := safe_name ("type", true)
            indent_to (1)
            io.put_string ("valid_message_type (")
            io.put_string (mname)
            io.put_string (" : ANY; ")
            io.put_string (tname)
            io.put_string (" : INTEGER) : BOOLEAN is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("result := (1 <= ")
            io.put_string (tname)
            io.put_string ( " and then ")
            io.put_string (tname)
            io.put_string (" <= ")
            io.putint (pending_routines.count)
            io.put_string (")%N")
            indent_to (3)
            io.put_string ("result := result and then ")
            io.put_string (mname)
            io.put_string (".conforms_to (template)%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_template is

        do
            io.put_string ("feature { NONE }%N%N")
            indent_to (1)
            io.put_string ("template : CORBA_SERVER_REQUEST is%N%N")
            indent_to (2)
            io.put_string ("once%N")
            indent_to (3)
            io.put_string ("create result.make%N")
            indent_to (2)
            io.put_string ("end%N%N")
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

    generate_union_make (ut : UNION_TYPE) is

        do
            indent_to (1)
            io.put_string ("make is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("create thunk.make1 (")
            io.put_string (scoped_name_to_tcname (ut.name))
            io.put_string (")%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_union_get_value (ut : UNION_TYPE; defcase : INTEGER) is

        local
            i, n  : INTEGER
            ca    : CASE
            lab   : CASE_LABEL
            es    : ELEMENT_SPEC

        do
            from
                i := 1
                n := ut.component_count
            until
                i > n
            loop
                if i /= defcase then
                    ca := ut.component_at (i)
                    es := ca.element_spec
                    generate_case_label_get_value (es, ut.switch_type_spec, i)
                end -- if i /= defcase then ...
                i := i + 1
            end
        end
----------------------

    generate_case_label_get_value (es : ELEMENT_SPEC;
                                   sts : SWITCH_TYPE_SPEC;
                                   index : INTEGER) is

        local
            ctype   : STRING
            is_enum : BOOLEAN
            sn      : SCOPED_NAME

        do
            sn      ?= sts
            is_enum := (sn /= void and then
                        enums.has (sn))
            indent_to (1)
            es.accept (current)
            io.put_string (" is%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("disc : ")
            if is_enum then
                io.put_string ("INTEGER%N%N")
            else
                sts.accept (current)
                io.put_string ("%N%N")
            end
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("thunk.union_get_begin%N")
            indent_to (3)
            io.put_string ("disc := thunk.get_")
            ctype := switch_type_spec_to_corbastring (sts)
            io.put_string (ctype)
            io.new_line
            indent_to (3)
            io.put_string ("thunk.union_get_selection(")
            io.putint (index)
            io.put_string (")%N")
            indent_to (3)
            sn    ?= es.type_spec
            ctype := type_spec_to_corbastring (es.type_spec)
            if sn /= void and then is_complex_type (sn) then
                io.put_string ("create result.make%N")
                indent_to (3)
                io.put_string ("result.")
                io.put_string (ctype)
                io.put_string ("_from_any (thunk)%N")
            else
                io.put_string ("result := thunk.get_")
                io.put_string (ctype)
                if equal (ctype.substring (1, 6), "object") then
                    io.put_string (")%N")
                else
                    io.new_line
                end
            end -- if sn /= void and then ...
            indent_to (3)
            io.put_string ("thunk.union_get_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_union_set_value (ut : UNION_TYPE; defcase : INTEGER) is

        local
            i, n  : INTEGER
            j, m  : INTEGER
            ca    : CASE
            es    : ELEMENT_SPEC
            name  : STRING
            lab   : CASE_LABEL
            labs  : INDEXED_CATALOG [CASE_LABEL, STRING]
            specs : INDEXED_LIST [ELEMENT_SPEC]

        do
            create labs.make
            create specs.make (false)
            from
                i := 1
                n := ut.component_count
            until
                i > n
            loop
                if i /= defcase then
                    ca := ut.component_at (i)
                    es := ca.element_spec
                    specs.append (es)
                    name := es.declarator.name.last_name_component
                    from
                        j := 1
                        m := ca.component_count
                    until
                        j > m
                    loop
                        lab := ca.component_at (j)
                        labs.add (lab, name)
                        j := j + 1
                    end -- loop over j
                end -- if i /= defcase then ...
                i := i + 1
            end
            generate_case_set_values (labs, specs, ut.switch_type_spec)
        end
----------------------

    generate_case_set_values (labs : INDEXED_CATALOG [CASE_LABEL, STRING];
                              specs : INDEXED_LIST [ELEMENT_SPEC];
                              sts : SWITCH_TYPE_SPEC) is

        local
            i, n : INTEGER
            name : STRING
            es   : ELEMENT_SPEC
            lab  : CASE_LABEL

        do
            from
                i := specs.low_index
                n := specs.high_index
            until
                i > n
            loop
                es   := specs.at (i)
                name := es.declarator.name.last_name_component
                if labs.at (name).count = 1 then
                    lab := labs.at (name).at (labs.at (name).low_index)
                    generate_case_set_unique_value (lab, es, sts, i)
                else
                    generate_case_set_nonunique_value (labs.at (name),
                                                       es, sts, i)
                end
                i := i + 1
            end
        end
----------------------

    generate_case_set_unique_value (lab : CASE_LABEL;
                                    es : ELEMENT_SPEC;
                                    sts : SWITCH_TYPE_SPEC;
                                    index : INTEGER) is

        local
            sn      : SCOPED_NAME
            is_enum : BOOLEAN
            ctype   : STRING

        do
            sn      ?= sts
            is_enum := (sn /= void and then
                        enums.has (sn))
            indent_to (1)
            io.put_string ("set_")
            es.declarator.accept (current)
            io.put_string (" (val : ")
            es.type_spec.accept (current)
            io.put_string (") is%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("disc : ")
            if is_enum then
                io.put_string ("INTEGER%N%N")
            else
                sts.accept (current)
                io.put_string ("%N%N")
            end
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("thunk.union_put_begin%N")
            indent_to (3)
            io.put_string ("thunk.union_put_selection (")
            io.putint (index)
            io.put_string (")%N")
            indent_to (3)
            io.put_string ("disc := ")
            io.put_string (evaluate_label (lab.const_exp, sts)) 
            io.new_line
            indent_to (3)
            io.put_string ("thunk.put_")
            ctype := switch_type_spec_to_corbastring (sts)
            io.put_string (ctype)
            io.put_string (" (disc)%N")
            indent_to (3)
            sn    ?= es.type_spec
            ctype := type_spec_to_corbastring (es.type_spec)
            if sn /= void and then is_complex_type (sn) then
                io.put_string ("val.")
                io.put_string (ctype)
                io.put_string ("_to_any (thunk)%N")    
            else
                io.put_string ("thunk.put_")
                io.put_string (ctype)
                if equal (ctype.substring (1, 6), "object") then
                    io.put_string (", val)%N")
                else
                    io.put_string (" (val)%N")
                end
            end -- if sn /= void and then ...
            indent_to (3)
            io.put_string ("thunk.union_put_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    switch_type_spec_to_corbastring (ts : SWITCH_TYPE_SPEC) : STRING is

        local
            it  : INTEGER_TYPE
            ct  : CHAR_TYPE
            bt  : BOOLEAN_TYPE
            sn  : SCOPED_NAME
            st  : STRING_TYPE

        do
            it ?= ts
            if it /= void then
                result := "long"
            end -- it it /= void then ...
            if result = void then
                ct  ?= ts
                if ct /= void then
                    result := "char"
                end
            end -- if result = void then ...
            if result = void then
                bt ?= ts
                if bt /= void then
                    result := "boolean"
                end
            end
            if result = void then
                st ?= ts
                if st /= void then
                    result := "string"
                end
            end
            if result = void then -- last attempt
                sn ?= ts
                if sn /= void then
                    if enums.has (sn) then
                        result := "enum"
                    end
                else
                    result := "unknown" -- give up
                end
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    generate_case_set_nonunique_value (labs : INDEXED_LIST [CASE_LABEL];
                                       es : ELEMENT_SPEC;
                                       sts : SWITCH_TYPE_SPEC;
                                       index : INTEGER) is

        local
            i, n    : INTEGER
            is_enum : BOOLEAN
            ctype   : STRING
            sn      : SCOPED_NAME

        do
            sn ?= sts
            is_enum := (sn /= void and then
                        enums.has (sn))
            indent_to (1)
            io.put_string ("set_")
            es.declarator.accept (current)
            io.put_string (" (val : ")
            es.type_spec.accept (current)
            io.put_string ("; disc : ")
            sts.accept (current)
            io.put_string (") is %N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            if is_enum then
                io.put_string ("valid_discriminator : disc.value = ")
            else
                io.put_string ("valid_discriminator : disc = ")
            end
            from
                i := labs.low_index
                n := labs.high_index
            until
                i > n
            loop
                io.put_string (evaluate_label (labs.at (i).const_exp, sts))
                if i < n then
                    io.put_string (" or%N")
                    indent_to (8)
                    if is_enum then
                        io.put_string ("  disc.value = ")
                    else
                        io.put_string ("  disc = ")
                    end
                else
                    io.put_string ("%N%N")
                end
                i := i + 1
            end
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("thunk.union_put_begin%N")
            indent_to (3)
            io.put_string ("thunk.union_put_selection (")
            io.putint (index)
            io.put_string (")%N")
            indent_to (3)
            io.put_string ("thunk.put_")
            ctype := switch_type_spec_to_corbastring (sts)
            io.put_string (ctype)
            if is_enum then
                io.put_string (" (disc.value)%N")
            else
                io.put_string (" (disc)%N")
            end
            indent_to (3)
            sn    ?= es.type_spec
            ctype := type_spec_to_corbastring (es.type_spec)            
            if sn /= void and then is_complex_type (sn) then
                io.put_string ("val.")
                io.put_string (ctype)
                io.put_string ("_to_any (thunk)%N")
            else
                io.put_string ("thunk.put_")
                io.put_string (ctype)
                if equal (ctype.substring (1, 6), "object") then
                    io.put_string (", val)%N")
                else
                    io.put_string (" (val)%N")
                end
            end -- if sn /= void and then ...
            indent_to (3)
            io.put_string ("thunk.union_put_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_union_get_discriminator (ut : UNION_TYPE) is

        local
            sn      : SCOPED_NAME
            ctype   : STRING
            is_enum : BOOLEAN

        do
            sn ?= ut.switch_type_spec
            is_enum := (sn /= void and then
                        enums.has (sn))

            indent_to (1)
            io.put_string ("discriminator : ")
            ut.switch_type_spec.accept (current)
            io.put_string (" is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("thunk.union.get_begin%N")
            ctype := switch_type_spec_to_corbastring (ut.switch_type_spec)
            indent_to (3)
            if is_enum then
                io.put_string ("create result.make (thunk.get_")
                io.put_string (ctype)
                io.put_string (")%N")
            else
                io.put_string ("result := thunk.get_")
                io.put_string (ctype)
                io.new_line
            end
            -- XXX it may be an error not to do a thunk.union_get_end
            -- here ...
            indent_to (2)
            io.put_string ("end%N%N") -- end of get_discriminator

            indent_to (1)
            io.put_string ("is_case (disc : ")
            ut.switch_type_spec.accept (current)
            io.put_string (") : BOOLEAN is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            if is_enum then
                io.put_string ("result := (disc.value = %
                               %discriminator.value)%N")
            else
                io.put_string ("result := (disc = discriminator)%N")
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_union_set_default (ut : UNION_TYPE) is

        local
            sts     : SWITCH_TYPE_SPEC
            ca      : CASE
            i, n    : INTEGER
            j, m    : INTEGER
            lab     : CASE_LABEL
            labs    : INDEXED_LIST [CASE_LABEL]
            sn      : SCOPED_NAME
            ctype   : STRING
            is_enum : BOOLEAN

        do
            sts     := ut.switch_type_spec
            sn      ?= sts
            is_enum := (sn /= void and then
                        enums.has (sn))

            from
                i := 1
                n := ut.component_count
                create labs.make (false)
            until
                i > n
            loop
                ca := ut.component_at (i)
                from
                    j := 1
                    m := ca.component_count
                until
                    j > m
                loop
                    lab := ca.component_at (j)
                    if not lab.is_default then
                        labs.append (lab)
                    end
                    j := j + 1
                end
                i := i + 1
            end

            indent_to (1)
            io.put_string ("set_default  (disc : ")
            ut.switch_type_spec.accept (current)
            io.put_string (") is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            if is_enum then
                io.put_string ("valid_discriminator : disc.value /= ")
            else
                io.put_string ("valid_discriminator : disc /= ")
            end
            from
                i := labs.low_index
                n := labs.high_index
            until
                i > n
            loop
                io.put_string (evaluate_label (labs.at (i).const_exp, sts))
                if i < n then
                    io.put_string (" and%N")
                    indent_to (8)
                    if is_enum then
                        io.put_string ("  disc.value /= ")
                    else
                        io.put_string ("  disc /= ")
                    end
                else
                    io.put_string ("%N%N")
                end
                i := i + 1
            end
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("thunk.union_put_begin%N")
            indent_to (3)
            io.put_string ("thunk.put_")
            ctype := switch_type_spec_to_corbastring (sts)
            io.put_string (ctype)
            if is_enum then
                io.put_string (" (disc.value)%N")
            else
                io.put_string (" (disc)%N")
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_union_attribute (ut : UNION_TYPE; defcase : INTEGER) is

        do
            indent_to (1)
            io.put_string ("thunk : CORBA_ANY%N%N")
        end
----------------------

    generate_array_make (name : STRING; dcl : ARRAY_DECLARATOR) is

        local
            i, total : INTEGER

        do
            from
                i     := dcl.size_count
                total := 1
            until
                i <= 0
            loop
                total := dcl.size_at (i) * total
                i := i - 1
            end

            indent_to (1)
            io.put_string ("make is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("create store.make(1, ")
            io.putint (total)
            io.put_string (")%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_array_get_value (dcl : ARRAY_DECLARATOR) is

        local
            i, n  : INTEGER
            total : INTEGER
            sizes : ARRAY [INTEGER]

        do
            from
                create sizes.make (1, dcl.size_count)
                i     := dcl.size_count
                total := 1
            until
                i <= 0
            loop
                sizes.put (total, i)
                total := dcl.size_at (i) * total
                i := i - 1
            end

            indent_to (1)
            io.put_string ("get_value (")
            from
                i := 1
                n := dcl.size_count
            until
                i > n
            loop
                io.putchar ('i')
                io.put_string (fmt.i2s ("1", i))
                if i < n then
                    io.put_string (", ")
                end
                i := i + 1
            end
            io.put_string (" : INTEGER) : ")
            dcl.type_spec.accept (current)
            io.put_string (" is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("valid_indices : ")
            from
                i := 1
            until
                i > n
            loop
                io.put_string ("1 <= ")
                io.putchar ('i')
                io.put_string (fmt.i2s("1", i))
                io.put_string (" and then ")
                io.putchar ('i')
                io.put_string (fmt.i2s ("1", i))
                io.put_string (" <= ")
                io.putint (dcl.size_at (i))
                io.new_line
                if i < n then
                    indent_to (3)
                    io.put_string ("                and then%N")
                    indent_to (3)
                    io.put_string ("                ")
                else
                    io.put_string ("%N%N")
                end
                i := i + 1
            end
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("result := store.item (")
            from
                i := 1
                n := dcl.size_count
            until
                i > n
            loop
                if i < n then
                    io.putint (sizes.item (i))
                    io.put_string (" * (")
                end

                io.putchar ('i')
                io.put_string (fmt.i2s ("1", i))
                if i < n then
                    io.put_string (" - 1) + ")
                else
                    io.put_string (")%N")
                end
                i := i + 1
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_array_set_value (dcl : ARRAY_DECLARATOR) is

        local
            i, n  : INTEGER
            total : INTEGER
            sizes : ARRAY [INTEGER]

        do
            from
                create sizes.make (1, dcl.size_count)
                i     := dcl.size_count
                total := 1
            until
                i <= 0
            loop
                sizes.put (total, i)
                total := dcl.size_at (i) * total
                i := i - 1
            end

            indent_to (1)
            io.put_string ("set_value (value : ")
            dcl.type_spec.accept (current)
            io.put_string ("; ")
            from
                i := 1
                n := dcl.size_count
            until
                i > n
            loop
                io.putchar ('i')
                io.put_string (fmt.i2s ("1", i))
                if i < n then
                    io.put_string (", ")
                end
                i := i + 1
            end
            io.put_string (" : INTEGER) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("valid_indices : ")
            from
                i := 1
            until
                i > n
            loop
                io.put_string ("1 <= ")
                io.putchar ('i')
                io.put_string (fmt.i2s("1", i))
                io.put_string (" and then ")
                io.putchar ('i')
                io.put_string (fmt.i2s ("1", i))
                io.put_string (" <= ")
                io.putint (dcl.size_at (i))
                io.new_line
                if i < n then
                    indent_to (3)
                    io.put_string ("                and then%N")
                    indent_to (3)
                    io.put_string ("                ")
                else
                    io.put_string ("%N%N")
                end
                i := i + 1
            end
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("store.put (value, ")
            from
                i := 1
                n := dcl.size_count
            until
                i > n
            loop
                if i < n then
                    io.putint (sizes.item (i))
                    io.put_string (" * (")
                end

                io.putchar ('i')
                io.put_string (fmt.i2s ("1", i))
                if i < n then
                    io.put_string (" - 1) + ")
                else
                    io.put_string (")%N")
                end
                i := i + 1
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_array_attribute (dcl : ARRAY_DECLARATOR) is

        do
            io.put_string ("feature { NONE }%N%N")
            indent_to (1)
            io.put_string ("store : ARRAY [")
            dcl.type_spec.accept (current)
            io.put_string ("]%N%N")
        end
----------------------

    generate_sequence_make (name : STRING; type : SEQUENCE_TYPE) is

        do
            indent_to (1)
            io.put_string ("make_default is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("create store.make(1, ")
            if type.length > 0 then
                io.putint (type.length)
            else
                io.putint (standard_sequence_length)
            end
            io.put_string (")%N")
            indent_to (3)
            io.put_string ("bound := ")
            io.putint (type.length)
            io.new_line
            indent_to (3)
            io.put_string ("length := 0%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_sequence_get_value (type : SEQUENCE_TYPE) is

        do
            indent_to (1)
            io.put_string ("get_value (index : INTEGER) : ")
            type.simple_type_spec.accept (current)
            io.put_string (" is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("valid_index : 1 <= index")
            if type.length > 0 then
                io.put_string (" and then index <= ")
                io.putint (type.length)
            end
            io.put_string ("%N%N")
            indent_to (2)
            io.put_string ("do%N")
            if type.length = 0 then
                indent_to (3)
                io.put_string ("if index <= store.upper then%N")
                indent_to (4)
                io.put_string ("result := store.item (index)%N")
                indent_to (3)
                io.put_string ("end%N")
            else
                indent_to (3)
                io.put_string ("result := store.item (index)%N")
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_sequence_set_value (type : SEQUENCE_TYPE) is

        do
            indent_to (1)
            io.put_string ("set_value (value : ")
            type.simple_type_spec.accept (current)
            io.put_string ("; index : INTEGER) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("valid_index : 1 <= index")
            if type.length > 0 then
                io.put_string (" and then index <= ")
                io.putint (type.length)
            end
            io.put_string ("%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            if type.length > 0 then
                io.put_string ("store.put (value, index)%N")
            else
                io.put_string ("store.force (value, index)%N")
            end
            indent_to (3)
            io.put_string ("if index > length then%N")
            indent_to (4)
            io.put_string ("length := index%N")
            indent_to (3)
            io.put_string ("end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_sequence_attribute (type : SEQUENCE_TYPE) is

        do
            io.put_string ("feature { NONE }%N%N")
            indent_to (1)
            io.put_string ("bound : INTEGER%N")
            indent_to (1)
            io.put_string ("store : ARRAY [")
            type.simple_type_spec.accept (current)
            io.put_string ("]%N%N")
        end
----------------------

    generate_sequence_length is

        do
            indent_to (1)
            io.put_string ("length : INTEGER%N%N")
            indent_to (1)
            io.put_string ("declared_length : INTEGER is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("result := bound%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_enum_constants (et : ENUM_TYPE) is

        local
            i, n : INTEGER
            name : STRING
            iot  : IO_TEXT
            pref : STRING
            sn   : SCOPED_NAME

        do
            iot  := active_constant_text
            sn   := et.name.duplicate
            sn.remove_last_name_component
            pref := scoped_name_to_string_with_dashes (sn)
            pref.extend ('_')
            from
                i := 1
                n := et.enumerator_count
            until
                i > n
            loop
                iot.indent_to (1)
                name := clone (et.enumerator_at (i))
                name.to_lower
                iot.put_string (pref)
                iot.put_string (name)
                iot.put_string (" : INTEGER is ")
                iot.putint (i - 1)
                iot.new_line
                i := i + 1
            end
            iot.indent_to (1)
            iot.put_string (scoped_name_to_string_with_dashes (et.name))
            iot.put_string ("_maxvalue : INTEGER is ")
            iot.putint (n - 1)
            iot.new_line
            iot.new_line
        end
----------------------

    generate_enum_make (et : ENUM_TYPE) is

        do
            indent_to (1)
            io.put_string ("make_default is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (2)
            io.put_string ("end%N%N")
            indent_to (1)
            io.put_string ("make (val : INTEGER) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("valid_value : 0 <= val and then val <= ")
            io.put_string (scoped_name_to_string_with_dashes (et.name))
            io.put_string ("_maxvalue%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("value := val%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_enum_set_value (et : ENUM_TYPE) is

        do
            indent_to (1)
            io.put_string ("set_value (val : INTEGER) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("valid_value : 0 <= val and then val <= ")
            io.put_string (scoped_name_to_string_with_dashes (et.name))
            io.put_string ("_maxvalue%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("value := val%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_enum_get_value (et : ENUM_TYPE) is

        do
            indent_to (1)
            io.put_string ("value : INTEGER%N%N")
        end
----------------------

    generate_enum_attribute (et : ENUM_TYPE) is

        do
        end
----------------------

    generate_struct_make (st : STRUCT_TYPE) is

        local
            i, n : INTEGER
            j, m : INTEGER
            me   : MEMBER

        do
            indent_to (1)
            io.put_string ("make_default is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (2)
            io.put_string ("end%N%N")
            indent_to (1)
            io.put_string ("make (")
            from
                i := 1
                n := st.component_count
            until
                i > n
            loop
                me := st.component_at (i)
                from
                    j := 1
                    m := me.component_count
                until
                    j > m
                loop
                    if i > 1 or else j > 1 then
                        indent_to (2)
                        io.put_string ("  ") 
                    end
                    me.component_at (j).accept (current)
                    io.put_string ("_val : ")
                    me.type_spec.accept (current)
                    if j < m then
                        io.put_string (";%N")
                    end
                    j := j + 1
                end
                if i < n then
                    io.put_string (";%N")
                else
                    io.put_string (") is%N%N")
                end
                i := i + 1
            end
            indent_to (2)
            io.put_string ("do%N")
            from
                i := 1
                n := st.component_count
            until
                i > n
            loop
                me := st.component_at (i)
                from
                    j := 1
                until
                    j > m
                loop
                    indent_to (3)
                    me.component_at (j).accept (current)
                    io.put_string (" := ")
                    me.component_at (j).accept (current)
                    io.put_string ("_val%N")
                    j := j + 1
                end
                i := i + 1
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_except_make (ed : EXCEPT_DCL) is

        local
            i, n : INTEGER
            j, m : INTEGER
            me   : MEMBER

        do
            indent_to (1)
            io.put_string ("make")
            if ed.component_count > 0 then
                from
                    i := 1
                    n := ed.component_count
                    io.put_string (" (")
                until
                    i > n
                loop
                    me := ed.component_at (i)
                    from
                        j := 1
                        m := me.component_count
                    until
                        j > m
                    loop
                        if i > 1 or else j > 1 then
                            indent_to (2)
                            io.put_string ("  ") 
                        end
                        me.component_at (j).accept (current)
                        io.put_string ("_val : ")
                        me.type_spec.accept (current)
                        if j < m then
                            io.put_string (";%N")
                        end
                        j := j + 1
                    end
                    if i < n then
                        io.put_string (";%N")
                    else
                        io.put_string (")")
                    end
                    i := i + 1
                end -- loop
            end -- if ed.component_count > 0 then ...
            io.put_string (" is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            from
                i := 1
                n := ed.component_count
            until
                i > n
            loop
                me := ed.component_at (i)
                from
                    j := 1
                until
                    j > m
                loop
                    indent_to (3)
                    me.component_at (j).accept (current)
                    io.put_string (" := ")
                    me.component_at (j).accept (current)
                    io.put_string ("_val%N")
                    j := j + 1
                end
                i := i + 1
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_member_attributes (me : MEMBER) is

        local
            i, n : INTEGER

        do
            from
                indent_to (1)
                i := 1
                n := me.component_count
            until
                i > n
            loop
                me.component_at (i).accept (current)
                if i < n then
                    io.put_string (", ")
                end
                i := i + 1
            end
            io.put_string (" : ")
            me.type_spec.accept (current)
            io.put_string ("%N%N")
        end
----------------------

    generate_member_mutators_and_accessors (me : MEMBER) is

        local
            i, n  : INTEGER
            vname : STRING

        do
            vname := safe_name ("value", true)
            from
                i := 1
                n := me.component_count
            until
                i > n
            loop
                -- Generate mutator method

                indent_to (1)
                io.put_string ("set_")
                me.component_at (i).accept (current)
                io.put_string (" (")
                io.put_string (vname)
                io.put_string (" : ")
                me.type_spec.accept (current)
                io.put_string (") is%N%N")
                indent_to (2)
                io.put_string ("do%N")
                indent_to (3)
                me.component_at (i).accept (current)
                io.put_string (" := ")
                io.put_string (vname)
                io.new_line
                indent_to (2)
                io.put_string ("end%N%N")

                i := i + 1
            end
        end
----------------------

    generate_attributes (ad : ATTR_DCL) is

        do
            -- They are now deferred functions.
        end
----------------------

    generate_attribute_mutators (ad : ATTR_DCL) is

        local
            i, n  : INTEGER
            vname : STRING

        do
            vname := safe_name ("value", true)
            from
                i := 1
                n := ad.component_count
            until
                i > n
            loop
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
                indent_to (2)
                io.put_string ("deferred%N")
                indent_to (2)
                io.put_string ("end%N%N")
                i := i + 1
            end
        end
----------------------

    generate_attribute_accessors (ad : ATTR_DCL) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := ad.component_count
            until
                i > n
            loop
                indent_to (1)
                ad.component_at (i).accept (current)
                io.put_string (" : ")
                ad.param_type_spec.accept (current)
                io.put_string (" is%N%N")
                indent_to (2)
                io.put_string ("deferred%N")
                indent_to (2)
                io.put_string ("end%N%N")
                i := i + 1
            end
        end
----------------------

    generate_routine_body (od : OP_DCL) is

        local
            refargs : INDEXED_LIST [STRING]
            i, n    : INTEGER
            sn      : SCOPED_NAME
            type    : STRING
            pd      : PARAM_DCL

        do
            from
                create refargs.make (false)
                i := 1
                n := od.component_count
            until
                i > n
            loop
                pd   := od.component_at (i)
                i    := i + 1
                type := param_type_spec_to_string (pd.param_type_spec)
                sn   ?= pd.param_type_spec
                if (equal (pd.param_attribute, "out")               and then
                    sn /= void                                      and then
                    types_defined_here.has (sn.last_name_component)) or else
                    (not equal(pd.param_attribute, "in")            and then
                     is_basic_type (type))                              then
                    refargs.append (pd.declarator)
                end
            end
            if refargs.count > 0 then
                indent_to (2)
                io.put_string ("require%N")
                indent_to (3)
                if refargs.count = 1 then
                    io.put_string ("nonvoid_arg : ")
                else
                    io.put_string ("nonvoid_args : ")
                end
                from
                    i := refargs.low_index
                    n := refargs.high_index
                until
                    i > n
                loop
                    if i > refargs.low_index then
                        indent_to (6)
                        io.put_string ("  ")
                    end
                    io.put_string (refargs.at (i))
                    io.put_string (" /= void")
                    if i < n then
                        io.put_string ("and then%N")
                    else
                        io.put_string ("%N%N")
                    end
                    i := i + 1
                end
            end
            indent_to (2)
            io.put_string ("deferred%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    evaluate_label (exp : CONST_EXP; sts : SWITCH_TYPE_SPEC) : STRING is
        -- `exp' is a constant expression whose type is specified
        -- by `ts'. Turn this expression into a string.

        local
            tc   : CORBA_TYPECODE
            iev  : INTEGER_EVALUATION_VISITOR
            bl   : BOOLEAN_LITERAL
            cl   : CHARACTER_LITERAL
            o    : OCTET
            sn   : SCOPED_NAME
            sn1  : SCOPED_NAME
            esn  : SCOPED_NAME
            i, n : INTEGER

        do
            tc := sts.typecode
            check
                typecode_known : tc /= void
            end
            inspect tc.kind

            when Tk_short, Tk_ushort, Tk_long, Tk_ulong then
                create iev
                exp.accept (iev)
                result := iev.value.out

            when Tk_boolean then
                bl ?= exp
                if bl = void then
                    error (<<"boolean case label is not a %
                             %boolean literal">>)    
                else
                    if bl.value then
                        result := "true"
                    else
                        result := "false"
                    end
                end

            when Tk_char then
                cl ?= exp
                if cl = void then
                    error (<<"char case label is not a %
                             %character literal">>)
                else
                    result := ""
                    result.extend(cl.value)
                end

            when Tk_enum then
                sn  ?= exp
                esn ?= sts
                if esn /= void then
                    sn1 := esn.duplicate
                    sn1.remove_last_name_component
                    result := sn1.to_string
                else
                    result := ""
                end
                if sn /= void then
                    -- ignore all but last component of `sn'
                    if result.count > 0 then
                        result.extend ('_')
                    end
                    result.append (sn.last_name_component)
                end
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    scoped_name_to_string_with_dashes (sn : SCOPED_NAME) : STRING is

        local
            i, n : INTEGER

        do
            from
                result := ""
                i      := 1
                n      := sn.name_component_count
                if i <= n then
                    result.append (sn.name_component_at (i))
                end
                if i < n then
                    result.append ("_")
                end
                i := i + 1
            until
                i > n
            loop
                result.append (sn.name_component_at (i))
                if i < n then
                    result.append ("_")
                end
                i := i + 1
            end
        end

end -- class EIFFEL_IMPLEMENTATION_VISITOR

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
