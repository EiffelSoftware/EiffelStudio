indexing

description: "Parent for code generating visitors";
keywords: "Visitor Pattern", "code generation";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class EIFFEL_CODE_VISITOR
    -- The descendants of this class
    -- generate Eiffel code for the
    -- stub, skeleton or implementation classes.

inherit
    THE_TABLE;
    SEMANTIC_VISITOR

feature

    frozen make (pref, project_name, vers, rep_pref : STRING;
                 noback : BOOLEAN;
                 repoids, versions : DICTIONARY [STRING, SCOPED_NAME]) is

        local
            sn : SCOPED_NAME

        do
            path_prefix    := pref
            repoid_prefix  := rep_pref
            project        := project_name
            global_version := vers
            local_versions := versions
            user_repoids   := repoids
            no_backups     := noback

            create constant_queue.make
            create interface_graph.make (true)
            create dummy_interface.make
            interface_graph.add_vertex (dummy_interface)
            create attr_queue.make
            create interfaces.make
            create types.make
            create esizes.make
            create integer_values.make
            create real_values.make
            create feature_names.make
            create pending_routines.make (false)
            create flat_version.make
            create types_defined_here.make
            create finished.make (true)
            create active_constant_text.make
            create top_constant_text.make

        ensure
            current_scope_at_top :
               (symbol_table.current_scope.name_component_count = 0)
        end
----------------------

    frozen finish is

        do
            generate_all_interfaces

            if is_an_implementation then
                generate_all_const_dcls
                generate_all_enums
                generate_all_unions
                generate_all_arrays
                generate_all_sequences
                generate_all_structs
                generate_all_exceptions
            end

            if is_a_stub then
                generate_project_helper
            end
            if is_an_implementation then
                generate_constants_trailer
            end
        end
----------------------

    frozen pass_complex_types (ecv : EIFFEL_CODE_VISITOR) is

        do
            ecv.set_complex_types (enums, structs, unions, sequences,
                                   arrays, exceptions, typedefs,
                                   feature_names)
        end
----------------------
feature { EIFFEL_CODE_VISITOR }

    frozen set_complex_types (en : DICTIONARY [ENUM_TYPE, SCOPED_NAME];
                        st : DICTIONARY [STRUCT_TYPE, SCOPED_NAME];
                        un : DICTIONARY [UNION_TYPE, SCOPED_NAME];
                        se : DICTIONARY [SEQUENCE_TYPE, SCOPED_NAME];
                        ar : DICTIONARY [ARRAY_DECLARATOR, SCOPED_NAME];
                        ex : DICTIONARY [EXCEPT_DCL, SCOPED_NAME];
                        ty : DICTIONARY [TYPEDEF_TYPE, SCOPED_NAME];
                        fn : DICTIONARY [SORTED_LIST [STRING], SCOPED_NAME]) is

        do
            enums         := en
            structs       := st
            unions        := un
            sequences     := se
            arrays        := ar
            exceptions    := ex
            typedefs      := ty
            feature_names := fn
        
        ensure
            complex_types_known : complex_types_known
        end
----------------------

    complex_types_known : BOOLEAN is 

        do
            result := (enums         /= void and
                       structs       /= void and
                       unions        /= void and
                       sequences     /= void and
                       arrays        /= void and
                       exceptions    /= void and
                       typedefs      /= void and
                       feature_names /= void)
        end
----------------------
feature { ABSTRACT_SYNTAX_ELEMENT }

    frozen visit_specification (sp : SPECIFICATION) is

        local
            i, n : INTEGER

        do
            if is_an_implementation then
                generate_constants_header
            end

            from
                -- Begin by unwinding all typedefs and
                -- computing all typecodes
                if enums = void then
                    -- Do this only once.
                    unalias (sp)
                end
                i := 1
                n := sp.component_count
            until
                i > n
            loop
                sp.component_at (i).accept (current)
                i := i + 1
            end
        end
----------------------

    frozen unalias (sp : SPECIFICATION) is

        do
            sp.accept (tuv)
            sp.accept (tcv)
            tuv.finish
            enums      := tuv.enums
            structs    := tuv.structs
            unions     := tuv.unions
            sequences  := tuv.sequences
            arrays     := tuv.arrays
            exceptions := tuv.exceptions
            typedefs   := tuv.typedefs

        ensure
            complex_types_known : complex_types_known
        end
----------------------

    tuv : TYPEDEF_UNWINDING_VISITOR is

        once
            create result.make
        end
----------------------

    tcv : TYPECODE_VISITOR is

        once
            create result.make (global_version, repoid_prefix,
                           user_repoids, local_versions)
        end
----------------------

    frozen visit_module (mo : MODULE) is

        local
            i, n       : INTEGER
            old_cqueue : QUEUE [CONST_DCL]
            old_ctext  : IO_TEXT

        do
            from
                symbol_table.descend (mo.name.last_name_component)
                    -- Begin new scope; needed for naming
                    -- constant classes.

                old_cqueue := constant_queue
                create constant_queue.make
                old_ctext := active_constant_text
                create active_constant_text.make
                i     := 1
                n     := mo.component_count
            until
                i > n
            loop
                mo.component_at(i).accept (current)
                i := i + 1
            end

            generate_all_interfaces

            if is_an_implementation then
                generate_constants_header
                generate_all_const_dcls
                generate_all_enums
                generate_all_unions
                generate_all_structs
                generate_all_sequences
                generate_all_exceptions
                generate_all_arrays
                generate_constants_trailer
            end

            constant_queue       := old_cqueue
            active_constant_text := old_ctext
            symbol_table.ascend
                -- Back to previous scope.
        end
----------------------

    frozen visit_interface (in : INTERFACE) is

        local
            i, n : INTEGER

        do
            symbol_table.descend (in.name.last_name_component)
            if not in.forward_declaration then
                if in.parent_count > 0 then
                    from
                        i := 1
                        n := in.parent_count
                    until    
                        i > n
                    loop
                        interface_graph.add_edge (in.parent_at (i),
                                                 in.name, 1.0)
                        i := i + 1
                    end
                else
                    interface_graph.add_edge (dummy_interface, in.name, 1.0)
                end
                interfaces.put (in, in.name)
                types_defined_here.put (in.name, in.name.last_name_component)
            end
            symbol_table.ascend
        end
----------------------

    frozen visit_value (va : VALUE) is

        do
        end
----------------------

    frozen visit_init_dcl (id : INIT_DCL) is

        do
        end
----------------------

    frozen visit_init_param_dcl (ipd : INIT_PARAM_DCL) is

        do
        end
----------------------

    frozen visit_state_member (sm : STATE_MEMBER) is

        do
        end
----------------------

    frozen visit_const_dcl (cd : CONST_DCL) is

        local
            tcov    : TYPE_COMPUTING_VISITOR
            iev     : INTEGER_EVALUATION_VISITOR
            rev     : REAL_EVALUATION_VISITOR

        do
            create tcov
            tcov.set_types (types, esizes)
            cd.accept (tcov)

            if tcov.type /= 'x' then
                types.put (tcov.type, cd.name)
                esizes.put (tcov.size, cd.name)
            end
            cd.set_type (tcov.type)

            -- Now unwind constant expression

            inspect tcov.type

            when 'i' then
                create iev
                iev.set_values (integer_values)
                cd.const_exp.accept (iev)
                integer_values.put (iev.value, cd.name)

            when 'r' then
                create rev
                rev.set_real_values (real_values)
                rev.set_integer_values (integer_values)
                cd.const_exp.accept (rev)
                real_values.put (rev.value, cd.name)

            else
                -- some non-numeric type; forget it!
            end

            if inside_interface and then
               is_an_implementation then
                generate_one_const_dcl (cd)
                io.new_line
            else
                constant_queue.add (cd)
            end
        end
----------------------

    frozen visit_except_dcl (ed : EXCEPT_DCL) is

        do
            if not exceptions.has (ed.name) then
                exceptions.put (ed, ed.name)
            end
        end
----------------------

    frozen visit_attr_dcl (ad : ATTR_DCL) is

        do
            attr_queue.add (ad)
            generate_attribute_accessors (ad)
            if not ad.is_readonly then
                generate_attribute_mutators (ad)
            end
        end
----------------------

    frozen visit_op_dcl (od : OP_DCL) is

        local
            i, n  : INTEGER
            pd    : PARAM_DCL
            vt    : VOID_TYPE
            oname : STRING

        do
            if not is_a_skeleton then
                indent_to (1)
                from
                    oname := od.name
                    if oname.substring_index ("_get_", 1) > 0 then
                        oname := oname.substring (6, oname.count)
                    elseif oname.substring_index ("_set_", 1) > 0 then
                        oname := oname.substring (2, oname.count)
                    end
                    io.put_string (safe_name (oname, false))
                    i := 1
                    n := od.component_count
                    if n > 0 then
                        io.put_string (" (")
                    end
                    is_param_type_spec := true
                until
                    i > n
                loop
                    if i > 1 then
                        indent_to (2)
                    end
                    pd := od.component_at (i)
                    pd.accept (current)    
                    if i < n then
                        io.put_string (";%N")
                    end
                    i := i + 1
                end
                if n > 0 then
                    io.putchar (')')
                end
                is_param_type_spec := false

                vt  ?= od.op_type_spec
                if vt = void then
                    io.put_string (" : ")
                    od.op_type_spec.accept (current)
                end

                io.put_string (" is%N%N")
                generate_routine_body (od)
            end

            add_if_new (od, pending_routines)
        end
----------------------

    frozen visit_param_dcl (pd : PARAM_DCL) is

        local
            bts : BASE_TYPE_SPEC

        do
            if not equal (pd.param_attribute, "in") then
                is_out_param := true
            end
            bts ?= pd.param_type_spec
            io.put_string (safe_name (pd.declarator, true))
            io.put_string (" : ")
            if bts /= void
               and then
               not equal (pd.param_attribute, "in") then
                io.put_string (base_type_to_ref_type (bts))
            else
                pd.param_type_spec.accept (current)
            end
            is_out_param := false
        end
----------------------

    frozen visit_raises_expr (exp : RAISES_EXPR) is

        local
            i, n : INTEGER
            tcn  : STRING

        do
            if is_a_stub then
                if exp.component_count = 1 then
                    tcn := scoped_name_to_tcname (exp.component_at (1))
                    indent_to (3)
                    io.put_string ("add_exception (")
                    io.put_string (tcn)
                    io.put_string (")%N")
                else
                    from
                        i := 1
                        n := exp.component_count
                    until
                        i > n
                    loop
                        tcn := scoped_name_to_tcname (exp.component_at (1))
                        indent_to (3)
                        io.put_string ("add_exception (")
                        io.put_string (tcn)
                        io.put_string (")%N")
                        i := i + 1
                    end -- loop
                end -- is exp.component_count = 1 then ...
            end -- if is_a_stub then ...
        end
----------------------

    frozen visit_context_expr (exp : CONTEXT_EXPR) is

        do
        end
----------------------

    frozen visit_scoped_name (sn : SCOPED_NAME) is

        local
            tt    : TYPEDEF_TYPE
            t1    : STRING
            lnc   : STRING
            cname : STRING
            done  : BOOLEAN
            sn1   : SCOPED_NAME

        do
            lnc := sn.last_name_component
            if types_defined_here.has (lnc) then
                io.put_string (type_mapping_policy (sn,
                                          is_param_type_spec, is_out_param))
                done := true
            end

            if not done then
                if equal (lnc, "TypeCode") then
                    io.put_string ("CORBA_TYPECODE")
                    done := true
                elseif equal (lnc, "Object") then
                    io.put_string ("CORBA_OBJECT")
                    done := true
                end
            end

            if not done then
                io.put_string (scoped_name_to_class_name (sn))
            end
        end
----------------------

    frozen type_mapping_policy (sn    : SCOPED_NAME;
                                ptype : BOOLEAN;
                                is_out : BOOLEAN) : STRING is
        -- This is an attempt to concentrate this policy all in
        -- one place for easier maintenance. The meaning of the
        -- second argument is:
        -- ptype: this is the type of a parameter

        require
            nonvoid_arg : sn /= void

        do
            result := scoped_name_to_class_name (sn)
            if ptype and then is_out then
                result := "ANY_REF"
            end
                -- The new policy of type_mapping_gamma

        ensure
            nonvoid_result : result /= void
        end
----------------------

    frozen visit_union_type (ut : UNION_TYPE) is

        do
            if not unions.has (ut.name) then
                unions.put (ut, ut.name)
            end
        end
----------------------

    frozen visit_case (ca : CASE) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := ca.component_count
            until
                i > n
            loop
                if i > 1 then
                    indent_to (1)
                end
                ca.component_at (i).accept (current)
                io.new_line
                i := i + 1
            end
            indent_to (1)
            ca.element_spec.accept (current)
        end
----------------------

    frozen visit_case_label (cl : CASE_LABEL) is

        local
            old_act : IO_TEXT

        do
            old_act := active_constant_text
            active_constant_text := void
                -- don't write it to constants ...
            cl.const_exp.accept (current)
            active_constant_text := old_act
        end
----------------------

    frozen visit_element_spec (es : ELEMENT_SPEC) is

        do
            es.declarator.accept (current)
            io.put_string (" : ")
            es.type_spec.accept (current)
        end
----------------------

    frozen visit_struct_type (st : STRUCT_TYPE) is

        do
            if not structs.has (st.name) then
                structs.put (st, st.name)
            end
        end
----------------------

    frozen visit_member (me : MEMBER) is

        local
            i, n : INTEGER

        do
            generate_member_attributes (me)
            generate_member_mutators_and_accessors (me)
        end
----------------------

    frozen visit_enum_type (et : ENUM_TYPE) is

        do
            if not enums.has (et.name) then
                enums.put (et, et.name)
            end
        end
----------------------

    frozen visit_native_type (nt : NATIVE_TYPE) is

        do
        end
----------------------


    frozen visit_typedef_type (tt : TYPEDEF_TYPE) is

        local
            i, n : INTEGER
            adcl : ARRAY_DECLARATOR

        do
            from
                i := 1
                n := tt.component_count
            until
                i > n
            loop
                adcl ?= tt.component_at (i)
                if adcl /= void then
                    adcl.set_type_spec (tt.type_spec)
                    tt.set_type_spec (adcl.name)
                    if not arrays.has (adcl.name) then
                        arrays.put (adcl, adcl.name)
                    end
                end
                i := i + 1
            end
        end
----------------------

    frozen visit_simple_declarator (dcl : SIMPLE_DECLARATOR) is

        do
            io.put_string (safe_name (dcl.identifier, is_param_type_spec))
        end
----------------------

    frozen visit_array_declarator (dcl : ARRAY_DECLARATOR) is

        do
        end
----------------------

    frozen visit_or_expr (exp : OR_EXPR) is

        do
            -- constant exps are unwound ...
        end
----------------------

    frozen visit_xor_expr (exp : XOR_EXPR) is

        do
            -- constant exps are unwound ...
        end
----------------------

    frozen visit_and_expr (exp : AND_EXPR) is

        do
            -- constant exps are unwound ...
        end
----------------------

    frozen visit_shift_expr (exp : SHIFT_EXPR) is

        do
            -- constant exps are unwound ...
        end
----------------------

    frozen visit_add_expr (exp : ADD_EXPR) is

        do
            -- constant exps are unwound ...
        end
----------------------

    frozen visit_mult_expr (exp: MULT_EXPR) is

        do
            -- constant exps are unwound ...
        end
----------------------

    frozen visit_unary_expr (exp : UNARY_EXPR) is

        do
            -- constant exps are unwound ...
        end
----------------------

    frozen visit_integer_literal (lit : INTEGER_LITERAL) is

        do
            if active_constant_text /= void then
                active_constant_text.putint (lit.value)
            else
                io.putint (lit.value)
            end
        end
----------------------

    frozen visit_string_literal (lit : STRING_LITERAL) is

        local
            outstr : STRING
            i      : INTEGER

        do
            outstr := clone (lit.value)
            from
                i := 2
            until
                i > outstr.count
            loop
                if outstr.item (i) = '"' then
                    outstr.insert ("%%", i)
                    i := i + 1
                end
                i := i + 1
            end
            if active_constant_text /= void then
                active_constant_text.putchar ('"')
                active_constant_text.put_string (outstr)
                active_constant_text.putchar ('"')
            else
                io.putchar ('"')
                io.put_string (outstr)
                io.putchar ('"')
            end
        end
----------------------

    frozen visit_wide_string_literal (lit : WIDE_STRING_LITERAL) is

        do
            -- Still to be implemented
        end
----------------------

    frozen visit_real_literal (lit : REAL_LITERAL) is

        do
            if active_constant_text /= void then
                active_constant_text.putreal (lit.value)
            else
                io.putreal (lit.value)
            end
        end
----------------------

    frozen visit_character_literal (lit : CHARACTER_LITERAL) is

        local
            outstr : STRING

        do
            outstr := "'"

            inspect lit.value

            when '%B' then
                outstr.extend ('%%')
                outstr.extend ('B')

            when '%N' then
                outstr.extend ('%%')
                outstr.extend ('N')

            when '%R' then
                outstr.extend ('%%')
                outstr.extend ('R')

            when '%T' then
                outstr.extend ('%%')
                outstr.extend ('T')

            when '%'' then
                outstr.append ("%%'")

            when '%%' then
                outstr.append ("%%%%")

            else
                outstr.extend (lit.value)
            end

            outstr.extend ('%'')

            if active_constant_text /= void then
                active_constant_text.put_string (outstr)
            else
                io.put_string (outstr)
            end
        end
----------------------

    frozen visit_wide_character_literal (lit : WIDE_CHARACTER_LITERAL) is

        do
            -- Still to be implemented.
        end
----------------------

    frozen visit_boolean_literal (lit : BOOLEAN_LITERAL) is

        do
            if active_constant_text /= void then
                if lit.value then
                    active_constant_text.put_string ("true")
                else
                    active_constant_text.put_string ("false")
                end
            else
                if lit.value then
                    io.put_string ("true")
                else
                    io.put_string ("false")
                end
            end
        end
----------------------

    frozen visit_any_type (type : ANY_TYPE) is

        do
            io.put_string ("CORBA_ANY")
        end
----------------------

    frozen visit_boolean_type (type : BOOLEAN_TYPE) is

        do
            io.put_string ("BOOLEAN")
        end
----------------------

    frozen visit_char_type (type : CHAR_TYPE) is

        do
            io.put_string ("CHARACTER")
        end
----------------------

    frozen visit_integer_type (type : INTEGER_TYPE) is

        do
            io.put_string ("INTEGER")
        end
----------------------

    frozen visit_floating_pt_type (type : FLOATING_PT_TYPE) is

        do
            if type.is_double then
                io.put_string ("DOUBLE")
            else
                io.put_string ("REAL")
            end
        end
----------------------

    frozen visit_fixed_pt_type (type : FIXED_PT_TYPE) is

        do
            io.put_string ("DOUBLE")
        end
----------------------

    frozen visit_string_type (type : STRING_TYPE) is

        do
            io.put_string ("STRING")
        end
----------------------

    frozen visit_wide_string_type (type : WIDE_STRING_TYPE) is

        do
            io.put_string ("ARRAY [INTEGER]")
        end
----------------------

    frozen visit_octet_type (type : OCTET_TYPE) is

        do
            io.put_string ("OCTET")
        end
----------------------

    frozen visit_wide_char_type (type : WIDE_CHAR_TYPE) is

        do
            io.put_string ("INTEGER")
        end
----------------------

    frozen visit_void_type (type : VOID_TYPE) is

        do
            io.put_string ("VOID")
        end
----------------------

    frozen visit_sequence_type (type : SEQUENCE_TYPE) is

        do
             io.put_string (scoped_name_to_class_name (type.name))
        end
----------------------
feature { NONE }

    project              : STRING
    tab                  : STRING is "    "
    id_prefix            : STRING is "IDL:"
    no_backups           : BOOLEAN
    tf                   : PLAIN_TEXT_FILE
    constant_prefix      : STRING
    active_constant_text : IO_TEXT
    top_constant_text    : IO_TEXT
    constant_queue       : QUEUE [CONST_DCL]
    attr_queue           : QUEUE [ATTR_DCL]
        -- NOTE: the following dictionaries must have keys of
        -- type SCOPED_NAME, because the particular enum (e.g.)
        -- might depend on the scope it is defined in and not
        -- just on the simple name.
    enums                : DICTIONARY [ENUM_TYPE, SCOPED_NAME]
    structs              : DICTIONARY [STRUCT_TYPE, SCOPED_NAME]
    unions               : DICTIONARY [UNION_TYPE, SCOPED_NAME]
    sequences            : DICTIONARY [SEQUENCE_TYPE, SCOPED_NAME]
    exceptions           : DICTIONARY [EXCEPT_DCL, SCOPED_NAME]
    arrays               : DICTIONARY [ARRAY_DECLARATOR, SCOPED_NAME]
    typedefs             : DICTIONARY [TYPEDEF_TYPE, SCOPED_NAME]
    interfaces           : DICTIONARY [INTERFACE, SCOPED_NAME]
    interface_graph      : GRAPH [SCOPED_NAME]
        -- Inheritance graph of all interfaces
        -- defined here.
    dummy_interface      : SCOPED_NAME
        -- A pseudo interface from which all interfaces
        -- inherit that don't have an explicit parent.
    is_param_type_spec : BOOLEAN
        -- Sometimes param_type_specs have to be treated
        -- differently from op_type_specs.
    is_out_param : BOOLEAN
        -- Is the parameter out or inout?
        -- Valid only if is_param_type_spec = true.
    is_parent : BOOLEAN
        -- Does a scoped_name represent a parent?
    inside_interface   : BOOLEAN
        -- Inside interfaces const dcls are treated diferently.
    current_interface : STRING
        -- Needed for generating operation names
    current_classname : STRING
        -- Needed for generating requests.
    types : DICTIONARY [CHARACTER, SCOPED_NAME]
        -- Used to record the types of scoped names.
    esizes : DICTIONARY [ INTEGER, SCOPED_NAME]
        -- Used to record the sizes of scoped names.
    integer_values : DICTIONARY [INTEGER, SCOPED_NAME]
        -- Used to record the integer values of scoped names.
    real_values : DICTIONARY [DOUBLE, SCOPED_NAME]
        -- Used to record the real values of scoped names.
    pending_routines : INDEXED_LIST [OP_DCL]
        -- Needed for generating `valid_message_type' and `consume'.
    flat_version : DICTIONARY [INDEXED_LIST [OP_DCL], SCOPED_NAME]
         -- All routines in the interface given by key together
         -- with all those inherited.
    types_defined_here : DICTIONARY [SCOPED_NAME, STRING]
        -- These are the classes (interfaces) defined in this project.
        -- They get a different treatment if they are used as types.
    path_prefix : STRING
        -- Paths for generated classes begin with this prefix.
    user_repoids : DICTIONARY [STRING, SCOPED_NAME]
        -- The user specified these repoids via #pragma ID ...
    local_versions : DICTIONARY [STRING, SCOPED_NAME]
        -- The user specified these version numbers via #pragma version ...
    global_version : STRING
        -- The version number to be used in all cases not taken care of
        -- by `local_versions'.
    repoid_prefix : STRING
        -- Prefix all repoids not user defined with this string.
    finished : SORTED_LIST [SCOPED_NAME]
        -- Used to prevent generating a class more than once.
    features : SORTED_LIST [STRING]
        -- Used to prevent arguments from having the same name as
        -- a feature.
    feature_names : DICTIONARY [SORTED_LIST [STRING], SCOPED_NAME]
        -- Used to avoid computing `features' more than once.
----------------------

    frozen constant_path : STRING is

        local
            sn  : SCOPED_NAME
            lnc : STRING

        do
            sn := symbol_table.current_scope.duplicate
            if sn.name_component_count = 0 then
                lnc := clone (project)
                lnc.append ("_globalconstants")
            else
                lnc := "constants"
            end
            sn.add_name_component (lnc)
            result := scoped_name_to_path (sn)
        end
----------------------

    frozen constant_classname : STRING is

        local
            sn  : SCOPED_NAME
            lnc : STRING
            pre : STRING

        do
            pre := clone (project)
            pre.extend ('_')
            pre.to_upper
            sn := symbol_table.current_scope.duplicate
            if sn.name_component_count = 0 then
                lnc := "globalconstants"
            else
                lnc := "constants"
            end
            sn.add_name_component (lnc)
            result := scoped_name_to_class_name (sn)
            result.prepend (pre)
        end
----------------------

    frozen is_basic_type (type : STRING) : BOOLEAN is

        do
            result := equal (type, "integer")   or else
                      equal (type, "real")      or else
                      equal (type, "double")    or else
                      equal (type, "character") or else
                      equal (type, "boolean")
        end
----------------------

    frozen special_is_basic_type (type : STRING) : BOOLEAN is
        -- This function differs from `is_basic_type' in that
        -- it checks for "short", "ushort", etc.

        do
            result := equal (type, "short")      or else
                      equal (type, "ushort")     or else
                      equal (type, "ulong")      or else
                      equal (type, "long")       or else
                      equal (type, "ulonglong")  or else
                      equal (type, "longlong")   or else
                      equal (type, "longdouble") or else
                      equal (type, "double")     or else
                      equal (type, "float")
        end
----------------------

    frozen basic_type (bts : BASE_TYPE_SPEC) : STRING is

        require
            nonvoid_arg : bts /= void

        local
            type : STRING
            fpt  : FLOATING_PT_TYPE

        do
            type := bts.generator

            if equal (type, "FLOATING_PT_TYPE") then
                fpt ?= bts
                if fpt.is_double then
                    result := "double"
                else
                    result := "real"
                end
            elseif equal (type, "INTEGER_TYPE") then
                result := "integer"
            elseif equal (type, "CHAR_TYPE") then
                result := "character"
            elseif equal (type, "WIDE_CHAR_TYPE") then
                result := "integer"
            elseif equal (type, "OCTET_TYPE") then
                result := "character"
            elseif equal (type, "BOOLEAN_TYPE") then
                result := "boolean"
            end
        end
----------------------

    frozen op_type_spec_to_string (ots : OP_TYPE_SPEC) : STRING is

        local
            sn   : SCOPED_NAME
            type : STRING
            lnc  : STRING
            fpt  : FLOATING_PT_TYPE

        do
            type := clone (ots.generator)
            type.to_lower
            if equal (type, "integer_type")   or
               equal (type, "wide_char_type") then
                result := "integer"
            elseif equal (type, "floating_pt_type") then
                fpt ?= ots
                if fpt.is_double then
                    result := "double"
                else
                    result := "real"
                end
            elseif equal (type, "fixed_pt_type") then
                result := "double"
            elseif equal (type, "char_type")  or
                   equal (type, "octet_type") then
                result := "character"
            elseif equal (type, "boolean_type") then
                result := "boolean"
            elseif equal (type, "string_type") then
                result := "string"
            elseif equal (type, "wide_string_type") then
                result := "wstring"
            elseif equal (type, "any_type") then
                result := "any"
            elseif equal (type, "scoped_name") then
                sn  ?= ots
                lnc := sn.last_name_component
                if types_defined_here.has (lnc) then
                    sn := types_defined_here.at (lnc)
                    result := type_mapping_policy (sn,
                                                   is_param_type_spec,
                                                   is_out_param)

                elseif equal (lnc, "Object") then
                        result := "CORBA_OBJECT"
                elseif equal (lnc, "TypeCode") then
                        result := "typecode"
                elseif equal (lnc, "any") then
                        result := "any"
                else
                    result := scoped_name_to_class_name (sn)
                end

            else
                result := "void"
            end
            if result = void and sn /= void then
                result := scoped_name_to_complex_name (sn)
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    frozen op_type_spec_to_string_orig (ots : OP_TYPE_SPEC) : STRING is
        -- same as op_type_spec_to_string except if `ots' is a scoped
        -- name just return last name component in original case.

        local
            sn   : SCOPED_NAME
            type : STRING
            lnc  : STRING
            fpt  : FLOATING_PT_TYPE

        do
            type := clone (ots.generator)
            type.to_lower
            if equal (type, "integer_type")   or
               equal (type, "wide_char_type") then
                result := "integer"
            elseif equal (type, "floating_pt_type") then
                fpt ?= ots
                if fpt.is_double then
                    result := "double"
                else
                    result := "real"
                end
            elseif equal (type, "fixed_pt_type") then
                result := "double"
            elseif equal (type, "char_type")  or
                   equal (type, "octet_type") then
                result := "character"
            elseif equal (type, "boolean_type") then
                result := "boolean"
            elseif equal (type, "string_type") then
                result := "string"
            elseif equal (type, "wide_string_type") then
                result := "wstring"
            elseif equal (type, "any_type") then
                result := "any"
            elseif equal (type, "scoped_name") then
                sn  ?= ots
                lnc := sn.last_name_component
                if types_defined_here.has (lnc) then
                    sn := types_defined_here.at (lnc)
                    result := type_mapping_policy (sn,
                                                   is_param_type_spec,
                                                   is_out_param)

                else
                    result := lnc
                end

            else
                result := "void"
            end
            if result = void and sn /= void then
                result := scoped_name_to_complex_name (sn)
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    scoped_name_to_narrow_name (sn : SCOPED_NAME) : STRING is

        local
            i, n : INTEGER

        do
            from
                i      := 1
                n      := sn.name_component_count
                result := ""
            until
                i > n
            loop
                result.append (sn.name_component_at (i))
                result.extend ('_')
                i := i + 1
            end
            result.append ("narrow")
        end
----------------------

    scoped_name_to_complex_name (sn : SCOPED_NAME) : STRING is
        -- Full name of Eiffel helper class belonging to `sn'.

        require
            nonvoid_arg : sn /= void

        local
            sn1  : SCOPED_NAME
            st   : SEQUENCE_TYPE
            str  : STRUCT_TYPE
            et   : EXCEPT_DCL
            ut   : UNION_TYPE
            adcl : ARRAY_DECLARATOR
            enum : ENUM_TYPE
            tt   : TYPEDEF_TYPE

        do
            create sn1.make
            sn1.add_name_component (sn.last_name_component)
            if enums.has (sn) then
                enum   := enums.at (sn)
                result := scoped_name_to_class_name (enum.name)
            elseif structs.has (sn) then
                str    := structs.at (sn)
                result := scoped_name_to_class_name (str.name)
            elseif unions.has (sn) then
                ut     := unions.at (sn)
                result := scoped_name_to_class_name (ut.name)
            elseif sequences.has (sn) then
                st     := sequences.at (sn)
                result := scoped_name_to_class_name (st.name)
            elseif exceptions.has (sn) then
                et     := exceptions.at (sn)
                result := scoped_name_to_class_name (et.name)
            elseif arrays.has (sn) then
                adcl   := arrays.at (sn)
                result := scoped_name_to_class_name (adcl.name)
            elseif typedefs.has (sn1) then
                tt     := typedefs.at (sn1)
                result := scoped_name_to_class_name (tt.aliased)
            elseif types_defined_here.has (sn.last_name_component) then
                result := scoped_name_to_class_name (sn)
            else -- it might be "TypeCode" or "Object"
                result := scoped_name_to_class_name (sn)
            end
        end
----------------------

    frozen param_type_spec_to_string (pts : PARAM_TYPE_SPEC) : STRING is

        do
            is_param_type_spec := true
            result := op_type_spec_to_string (pts)
            is_param_type_spec := false
            check
                not_void : not equal (result, "void")
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    frozen param_type_spec_to_string_orig (pts : PARAM_TYPE_SPEC) : STRING is
        -- same as param_type_spec_to_string except if `pts' is a
        -- scoped name just return last name component in original case.

        do
            result := op_type_spec_to_string_orig (pts)
            check
                not_void : not equal (result, "void")
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    frozen type_spec_to_string (ts : TYPE_SPEC) : STRING is

        local
            sn   : SCOPED_NAME
            type : STRING
            lnc  : STRING
            fpt  : FLOATING_PT_TYPE

        do
            type := clone (ts.generator)
            type.to_lower
            if equal (type, "integer_type")   or
               equal (type, "wide_char_type") then
                result := "integer"
            elseif equal (type, "floating_pt_type") then
                fpt ?= ts
                if fpt.is_double then
                    result := "double"
                else
                    result := "real"
                end
            elseif equal (type, "fixed_pt_type") then
                result := "double"
            elseif equal (type, "char_type")  or
                   equal (type, "octet_type") then
                result := "character"
            elseif equal (type, "boolean_type") then
                result := "boolean"
            elseif equal (type, "string_type") then
                result := "string"
            elseif equal (type, "wide_string_type") then
                result := "wstring"
            elseif equal (type, "any_type") then
                result := "any"
            elseif equal (type, "scoped_name") then
                sn  ?= ts
                lnc := sn.last_name_component
                if types_defined_here.has (lnc) then
                    result := lnc
                else
                    result := scoped_name_to_class_name (sn)
                end

            else
                result := "unknown"
            end
            if sn /= void then
                result := scoped_name_to_complex_name (sn)
            end
        end
----------------------

    build_struct_accessors_and_mutators (st : STRUCT_TYPE) is

        local
            i, n : INTEGER

        do
            if pending_routines = void then
                create pending_routines.make (false)
            end
            from
                i := 1
                n := st.component_count
            until
                i > n
            loop
                build_member_accessor_and_mutator (st.component_at (i))
                i := i + 1
            end
        end
----------------------

    build_member_accessor_and_mutator (m : MEMBER) is
        -- Hanicraft some op_dcls.

        local
            i, n  : INTEGER
            name  : STRING
            oname : STRING
            od    : OP_DCL
            pts   : PARAM_TYPE_SPEC

        do
            from
                i := 1
                n := m.component_count
            until
                i > n
            loop
                name  := m.component_at (i).name.last_name_component
                oname := "get_"
                oname.append (name)
                od := build_op_dcl (oname, "void",
                                    <<>>, <<>>)
                pts ?= m.type_spec
                od.set_op_type_spec (pts)
                pending_routines.append (od)
                oname := "set_"
                oname.append (name)
                od := build_op_dcl (oname, "void",
                                    <<"value">>,
                                    <<"integer">>)
                od.component_at(1).set_param_type_spec (pts)                
                pending_routines.append (od)
                i := i + 1
            end
        end
----------------------

    build_sequence_accessor_and_mutator (st : SEQUENCE_TYPE) is
        -- Handicraft some op_dcls.

        local
            i, n  : INTEGER
            od    : OP_DCL
            ts    : TYPE_SPEC
            pts   : PARAM_TYPE_SPEC

        do
            if pending_routines = void then
                create pending_routines.make (false)
            end
            od := build_op_dcl ("get_value", "void",
                                <<"index">>, <<"integer">>)
            ts  := st.simple_type_spec
            pts ?= ts
            check
                nonvoid_type : pts /= void
            end
            od.set_op_type_spec (pts)
            pending_routines.append (od)
            od := build_op_dcl ("set_value", "void",
                                <<"value", "index">>,
                                <<"integer", "integer">>)
            od.component_at(1).set_param_type_spec (pts)
            pending_routines.append (od)
        end
----------------------

    build_accessors_and_mutators (in : INTERFACE) is

        local
            i, n : INTEGER
            ad   : ATTR_DCL

        do
            from
                i := 1
                n := in.component_count
            until
                i > n
            loop
                ad ?= in.component_at (i)
                if ad /= void then
                    build_one_accessor_and_mutator (ad)
                end
                i := i + 1
            end
        end
----------------------

    build_one_accessor_and_mutator (ad : ATTR_DCL) is
        -- Handicraft some op_dcls.

        require
            nonvoid_arg : ad /= void

        local
            i, n  : INTEGER
            name  : STRING
            oname : STRING
            od    : OP_DCL
            pd    : PARAM_DCL

        do
            from
                if pending_routines = void then
                    create pending_routines.make (false)
                end
                i := 1
                n := ad.component_count
            until
                i > n
            loop
                name  := ad.component_at (i).identifier
                oname := "_get_"
                oname.append (name)
                if not is_already_pending (oname) then
                    od := build_op_dcl (oname, "void", <<>>, <<>>)
                    od.set_op_type_spec (ad.param_type_spec)
                    pending_routines.append (od)
                end
                if not ad.is_readonly then
                    oname := "_set_"
                    oname.append (name)
                    if not is_already_pending (oname) then
                        pd := build_param_dcl ("integer", "val")
                        pd.set_param_type_spec (ad.param_type_spec)
                        od := build_op_dcl (oname, "void", <<>>, <<>>)
                        od.add_component (pd)
                        pending_routines.append (od)
                    end
                end
                i := i + 1
            end
        end
----------------------

    is_already_pending (name : STRING) : BOOLEAN is

        local
            i, n : INTEGER

        do
            from
                i := pending_routines.low_index
                n := pending_routines.high_index
            until
                result or i > n
            loop
                result := equal (pending_routines.at (i).name, name)
                i      := i + 1
            end
        end
----------------------

    build_op_dcl (oname, otype : STRING;
                  pnames : ARRAY [STRING];
                  ptypes : ARRAY [STRING]) : OP_DCL is

        require
            nonvoid_args  : oname  /= void and
                            otype  /= void and
                            pnames /= void and
                            ptypes /= void
            matching_data : pnames.lower = ptypes.lower and
                            pnames.upper = ptypes.upper

        local
            i, n : INTEGER

        do
            create result.make
            result.set_op_type_spec (
                        build_op_type_spec (otype))
            result.set_name (oname)
            from
                i := pnames.lower
                n := pnames.upper
            until
                i > n
            loop
                result.add_component (
                        build_param_dcl (ptypes.item (i),
                                         pnames.item (i)))
                i := i + 1
            end
        end                  
----------------------

    build_param_dcl (type, name : STRING) : PARAM_DCL is

        do
            create result
            result.set_param_attribute ("in") -- in Eiffel we don't use others
            result.set_param_type_spec (
                    build_param_type_spec (type))
            result.set_declarator (name)
        end
----------------------

    build_op_type_spec (t : STRING) : OP_TYPE_SPEC is

        do
            if equal (t, "void") then
                create {VOID_TYPE} result
            else
                result := build_param_type_spec (t)
            end
        end
----------------------

    build_param_type_spec (t : STRING) : PARAM_TYPE_SPEC is

        local
            fpt : FLOATING_PT_TYPE

        do
            if equal (t, "string") then
                create {STRING_TYPE} result
            elseif equal (t, "char") then
                create {CHAR_TYPE} result
            elseif equal (t, "integer") then
                create {INTEGER_TYPE} result
            elseif equal (t, "boolean") then
                create {BOOLEAN_TYPE} result
            elseif equal (t, "double") then
                create fpt
                fpt.set_double
                result := fpt
            elseif equal (t, "float") then
                create {FLOATING_PT_TYPE} result
            elseif equal (t, "scoped_name") then
                create {SCOPED_NAME} result.make
            end
        end
----------------------

    frozen scoped_name_to_class_name (sn : SCOPED_NAME) : STRING is

        local
            i, n : INTEGER
            sn1  : SCOPED_NAME
            done : BOOLEAN

        do
            if typedefs.has (sn) then
                sn1    := typedefs.at (sn).aliased
                result := scoped_name_to_etype (sn1)
                done   := (result /= void)
            else
                sn1 := sn
            end

            if result = void then
                if sn1.name_component_count = 1 then
                    result := safe_name (sn1.last_name_component,
                                         is_param_type_spec)
                else
                    from
                        i := 1
                        n := sn1.name_component_count
                        result := clone (sn1.name_component_at (i))
                        i := i + 1
                    until
                        i > n
                    loop
                        result.extend ('_')
                        result.append (sn1.name_component_at (i))
                        i := i + 1
                    end -- loop
                end -- if sn1.name_component_count = 1 then ...
            end -- if result = void then ...
            current_classname := clone (result)
            result.to_upper
        end
----------------------

    frozen scoped_name_to_tcname (sn : SCOPED_NAME) : STRING is

        require
            nonvoid_arg : sn /= void

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := sn.name_component_count
                result := ""
            until
                i > n
            loop
                if i > 1 then
                    result.extend ('_')
                end
                result.append (sn.name_component_at (i))
                i := i + 1
            end
            result.append ("_tc")
            result.to_lower

        ensure
            nonvoid_result : result /= void
        end
----------------------

    frozen scoped_name_to_path (sn : SCOPED_NAME) : STRING is

        local
            i, n : INTEGER
            comp : STRING

        do
            from
                i := 1
                n := sn.name_component_count
                result := root
                if not fs.cluster_exists (result) then
                    fs.add_cluster (result, "lm.lm")
                end
            until
                i > n
            loop
                comp := clone (sn.name_component_at (i))
                comp.to_lower
                result := fs.concat_paths (result, comp)
                if i < n                      and then
                   not fs.cluster_exists (result) then
                    fs.add_cluster (result, "lm.lm")
                end
                i := i + 1
            end
            result.to_lower
            result.append (".e")
        end
----------------------

    frozen indent_to (depth : INTEGER) is

        local
            i : INTEGER

        do
            from
                i := 0
            until
                i >= depth
            loop
                io.put_string (tab)
                i := i + 1
            end
        end
----------------------

    frozen scoped_name_to__path (sn : SCOPED_NAME) : STRING is

        require
            nonvoid_arg : sn /= void

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := sn.name_component_count
                result := fs.concat_paths (".", root)
            until
                i > n
            loop
                result := fs.concat_paths (result, sn.name_component_at (i))
                i := i + 1
            end
            result.append (".e")
        end
----------------------

    frozen generate_all_const_dcls is

        local
            q : QUEUE [CONST_DCL]

        do
            from
                q := constant_queue
            until
                q.empty
            loop
                generate_one_const_dcl (q.item)
                q.remove
            end
        end
----------------------

    frozen generate_one_const_dcl (cd : CONST_DCL) is

        local
            iot       : IO_TEXT
            base_type : STRING
            sn        : SCOPED_NAME
            tt        : TYPEDEF_TYPE
            msg       : STRING
            etype     : STRING

        do
            iot := active_constant_text
            iot.indent_to (1)
            if constant_prefix /= void then
                iot.put_string (constant_prefix)
            end
            iot.put_string (cd.name.last_name_component)
            iot.put_string (" : ")
            base_type := cd.const_type.generator
            if equal (base_type, "SCOPED_NAME") then
                sn ?= cd.const_type
                if typedefs.has (sn) then
                    tt := typedefs.at (sn)
                    base_type := tt.aliased.generator
                end
            end

            if equal (base_type, "INTEGER_TYPE")
               or
               equal (base_type, "FLOATING_PT_TYPE") then

                if not types.has (cd.name) then
                    msg := "Constant "
                    msg.append (cd.name.last_name_component)
                    msg.append (" has an illegal type")
                    error_handler.warning (msg, false)
                else
                    inspect types.at (cd.name)

                    when 'b' then
                        iot.put_string ("BOOLEAN is ")
                        cd.const_exp.accept (current)
                        iot.new_line

                    when 'c' then
                        iot.put_string ("CHARACTER is ")
                        cd.const_exp.accept (current)
                        iot.new_line

                    when 'i' then
                        iot.put_string ("INTEGER is ")
                        iot.putint (integer_values.at (cd.name))
                        iot.new_line

                    when 'r' then
                        iot.put_string ("DOUBLE is ")
                        iot.putdouble (real_values.at (cd.name))
                        iot.new_line

                    when 's' then
                        iot.put_string ("STRING is ")
                        cd.const_exp.accept (current)
                        iot.new_line
                    else
                        -- it's some other type; forget it!
                    end -- inspect
                end -- if not types.has (cd.name) then ...

            elseif equal (base_type, "STRING_TYPE") then
                iot.put_string ("STRING is ")
                cd.const_exp.accept (current)
                io.new_line

            elseif equal (base_type, "BOOLEAN_TYPE") then
                iot.put_string ("BOOLEAN is ")
                cd.const_exp.accept (current)
                io.new_line

            elseif equal (base_type, "CHAR_TYPE") then
                iot.put_string ("CHARACTER is ")
                cd.const_exp.accept (current)
                io.new_line

            elseif equal (base_type, "SCOPED_NAME") then
                sn ?= cd.const_type
                if sn /= void                        and then
                   typedefs.has (sn) then
                    tt := typedefs.at (sn)
                    etype := scoped_name_to_etype (tt.aliased)
                    if etype /= void then
                        iot.put_string (etype)
                        iot.put_string (" is ")
                        cd.const_exp.accept (current)
                        iot.new_line
                    else
                        msg := "Eiffel can't handle constants of reference %
                               %type ("
                        msg.append (cd.name.to_string)
                        msg.extend (')')
                    end
                else
                    msg := "Eiffel can't handle constants of reference type ("
                    msg.append (cd.name.to_string)
                    msg.extend (')')
                end -- if sn /= void and then ...
                if msg /= void then
                    error_handler.error (msg, false)
                end
            end
        end
----------------------

    scoped_name_to_etype (sn : SCOPED_NAME) : STRING is

        local
            lnc : STRING

        do
            lnc := sn.last_name_component
            if equal (lnc, "short")     or
               equal (lnc, "ushort")    or
               equal (lnc, "long")      or
               equal (lnc, "ulong")     or
               equal (lnc, "longlong")  or
               equal (lnc, "ulonglong") then
                result := "INTEGER"
            elseif equal (lnc, "boolean") then
                result := "BOOLEAN"
            elseif equal (lnc, "char") then
                result := "CHARACTER"
            elseif equal (lnc, "float") then
                result := "REAL"
            elseif equal (lnc, "double")     or
                   equal (lnc, "longdouble") then
                result := "DOUBLE"
            elseif equal (lnc, "string") then
                result := "STRING"
            end
        end
----------------------

    frozen generate_all_enums is

        local
            it : ITERATOR
            cs : SCOPED_NAME
            sn : SCOPED_NAME

        do
            from
                it := enums.iterator
                cs := symbol_table.current_scope
            until
                it.finished
            loop
                sn := enums.key (it)
                if sn.has_prefix (cs) then
                    finished.search (sn)
                    if not finished.found then
                        generate_one_enum (enums.item (it))
                        finished.add (sn)
                    end
                end
                it.forth
            end
        end
----------------------

     frozen generate_one_enum (et : ENUM_TYPE) is

        local
            path   : STRING
            name   : STRING
            cname  : STRING
            hname  : STRING
            sn     : SCOPED_NAME

        do
            path  := scoped_name_to_path (et.name)
            name  := scoped_name_to_class_name (et.name)
            hname := clone (project)
            hname.append ("_helper")
            hname.to_upper
            cname := constant_classname
            create tf.make_open_write (path)
            io.set_file_default (tf)
            io.put_string ("class ")
            io.put_string (name)
            io.new_line
            generate_standard_warning
            io.put_string ("%Ninherit%N")
            indent_to (1)
            io.put_string (hname)
            io.put_string (";%N")
            indent_to (1)
            io.put_string (cname)
            io.put_string ("%N%N")
            io.put_string ("creation%N")
            indent_to (1)
            io.put_string ("make, make_default%N%N")
            io.put_string ("feature%N%N")

            generate_enum_make (et)
            generate_enum_set_value (et)
            generate_enum_get_value (et)
            generate_enum_attribute (et)
            generate_enum_to_any (et)
            generate_enum_from_any (et)
            generate_repoid (et.name, false)
            io.put_string ("%Nend -- class ")
            io.put_string (name)
            io.new_line        
            tf.close
            sn := et.name.duplicate
            sn.remove_last_name_component
            constant_prefix := sn.to_string
            constant_prefix.extend ('_')
            generate_enum_constants (et)
            generate_typecode (et.name, et, "ENUM_TYPECODE")
            constant_prefix := void
        end
----------------------

    frozen generate_enum_to_any (et : ENUM_TYPE) is

        do
            indent_to (1)
            io.put_string ("enum_to_any (ca : CORBA_ANY) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("vonvoid_arg: ca /= void%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("dum : BOOLEAN%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("dum := ca.enum_put (value)%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    frozen generate_enum_from_any (et : ENUM_TYPE) is

        do
            indent_to (1)
            io.put_string ("enum_from_any (ca : CORBA_ANY) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("vonvoid_arg: ca /= void%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("value := ca.enum_get%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    frozen generate_all_unions is

        local
            it : ITERATOR
            cs : SCOPED_NAME
            sn : SCOPED_NAME

        do
            from
                it := unions.iterator
                cs := symbol_table.current_scope
            until
                it.finished
            loop
                sn := unions.key (it)
                if sn.has_prefix (cs) then
                    finished.search (sn)
                    if not finished.found then
                        generate_one_union (unions.item (it))
                        finished.add (sn)
                    end
                end
                it.forth
            end
        end
----------------------

    frozen generate_one_union (ut : UNION_TYPE) is

        local
            i, n    : INTEGER
            j, m    : INTEGER
            path    : STRING
            name    : STRING
            hname   : STRING
            defcase : INTEGER
            sn      : SCOPED_NAME
            et      : ENUM_TYPE

        do
            sn ?= ut.switch_type_spec
            if sn /= void and then enums.has (sn) then
                et := enums.at (sn)
            end

            path := scoped_name_to_path (ut.name)
            name := scoped_name_to_class_name (ut.name)
            hname := clone (project)
            hname.append ("_helper")
            hname.to_upper
            create tf.make_open_write (path)
            io.set_file_default (tf)
            io.put_string ("class ")
            io.put_string (name)
            io.new_line
            generate_standard_warning
            io.put_string ("%Ninherit%N")
            indent_to (1)
            io.put_string (hname)
            io.put_string (";%N")
            indent_to (1)
            io.put_string (constant_classname)
            io.put_string ("%N")
            io.put_string ("%Ncreation%N")
            indent_to (1)
            io.put_string ("make%N")

            io.put_string ("%Nfeature%N%N")
            generate_union_make (ut)

            from
                i := 1
                n := ut.component_count
            until
                i > n
            loop
                if ut.component_at (i).is_default then
                    defcase := i
                end
                i := i + 1
            end

            generate_union_get_value (ut, defcase)
            generate_union_set_value (ut, defcase)

            generate_union_get_discriminator (ut)
            generate_union_set_default (ut)
            generate_union_to_any (ut)
            generate_union_from_any (ut)
            io.put_string ("feature { NONE }%N%N")
            generate_union_attribute (ut, defcase)

            io.put_string ("end -- class ")
            io.put_string (name)
            io.new_line
            tf.close
            generate_typecode (ut.name, ut, "UNION_TYPECODE")

        rescue
            if tf /= void and then not tf.is_closed then
                tf.close
                tf := void
            end
        end

----------------------

    generate_union_to_any (ut : UNION_TYPE) is

        do
            indent_to (1)
            io.put_string ("union_to_any (ca : CORBA_ANY) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("ca.copy (thunk)%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_union_from_any (ut : UNION_TYPE) is

        do
            indent_to (1)
            io.put_string ("union_from_any (ca : CORBA_ANY) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("thunk := clone (ca)%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    frozen special_treatment (es : ELEMENT_SPEC) is

        local
            bts : BASE_TYPE_SPEC

        do
            es.declarator.accept (current)
            io.put_string (" : ")

            bts ?= es.type_spec

            if bts /= void then
                io.put_string (base_type_to_ref_type (bts))
            else
                es.type_spec.accept (current)
            end
        end
----------------------

    frozen base_type_to_ref_type (bts : BASE_TYPE_SPEC) : STRING is

        local
            fpt  : FLOATING_PT_TYPE
            type : STRING

        do
            fpt  ?= bts
            type := bts.generator

            if fpt /= void then
                if fpt.is_double then
                    result := "DOUBLE_REF"
                else
                    result := "REAL_REF"
                end
            elseif equal (type, "INTEGER_TYPE") then
                result := "INTEGER_REF"
            elseif equal (type, "CHAR_TYPE") then
                result := "CHARACTER_REF"
            elseif equal (type, "WIDE_CHAR_TYPE") then
                result := "CHARACTER_REF"
            elseif equal (type, "OCTET_TYPE") then
                result := "CHARACTER_REF"
            elseif equal (type, "BOOLEAN_TYPE") then
                result := "BOOLEAN_REF"
            end
        end
----------------------

    frozen generate_all_interfaces is

        local
            it : ITERATOR
            in : INTERFACE

        do
            if not interface_graph.acyclic then
                error (<<"The inheritance graph of interfaces has cycles">>)
            end
            inside_interface := true
            from
                it := interface_graph.breadth_first_iterator (dummy_interface)
            until
                it.finished
            loop
                if interface_graph.item (it).item /= dummy_interface then
                    in := interfaces.at (interface_graph.item (it).item)
                    if in.finished /= visitor_type then
                        if not is_a_stub then
                            flatten (in)
                        end
                        if (not is_a_skeleton
                            and then
                            not is_a_servant) or else
                           not in.abstract       then
                            generate_one_interface (in)
                            in.finish (visitor_type)
                            -- Don't generate interface twice ...
                        end
                    end
                end
                it.forth
            end
            inside_interface := false
        end
----------------------

    flatten (in : INTERFACE) is
        -- Fill `pending_routines' with all those
        -- routines belonging to parents and then
        -- all those belonging to `in' itself.

        local
            i, n    : INTEGER
            j, m    : INTEGER
            pr      : INDEXED_LIST [OP_DCL]
            pending : INDEXED_LIST [OP_DCL]
            od      : OP_DCL
            ad      : ATTR_DCL

        do
            create pending.make (false)
            -- First all those inherited from ancestors.
            from
                i := 1
                n := in.parent_count
            until
                i > n
            loop
                pr := flat_version.at (in.parent_at (i))
                from
                    j := pr.low_index
                    m := pr.high_index
                until
                    j > m
                loop
                    add_if_new (pr.at (j), pending)
                    j := j + 1
                end -- loop over j
                i := i + 1
            end -- loop over i
            -- Then  include all routines from `in' itself
            from
                i := 1
                n := in.component_count
            until
                i > n
            loop
                od ?= in.component_at (i)
                if od /= void then
                    add_if_new (od, pending)
                else
                    ad ?= in.component_at (i)
                    if ad /= void then
                        od := attr_accessor (ad)
                        add_if_new (od, pending)
                        if not ad.is_readonly then
                            od := attr_mutator (ad)
                            add_if_new (od, pending)
                        end
                    end
                end
                i := i + 1
            end
            flat_version.put (pending, in.name)
        end
----------------------

    attr_accessor (ad : ATTR_DCL) : OP_DCL is

        local
            nm : STRING

        do
            create result.make
            if is_a_skeleton then
                nm := "_get_"
            else
                nm := ""
            end
            nm.append (ad.component_at (1).identifier)
            result.set_name (nm)
            result.set_op_type_spec (ad.param_type_spec)
        end
----------------------

    attr_mutator (ad : ATTR_DCL) : OP_DCL is

        local
            nm : STRING
            vt : VOID_TYPE
            pd : PARAM_DCL

        do
            create result.make
            if is_a_skeleton then
                nm := "_set_"
            else
                nm := "set_"
            end
            nm.append (ad.component_at (1).identifier)
            result.set_name (nm)
            create vt
            result.set_op_type_spec (vt)
            create pd
            pd.set_param_attribute ("in")
            pd.set_declarator (ad.component_at (1).identifier)
            pd.set_param_type_spec (ad.param_type_spec)
            result.add_component (pd)
        end
----------------------

    add_if_new (od : OP_DCL; pending : INDEXED_LIST [OP_DCL]) is

        local
            i, n  : INTEGER
            found : BOOLEAN

        do
            from
                i := pending.low_index
                n := pending.high_index
            until
                i > n or else found
            loop
                found := equal (od.name, pending.at (i).name)
                i := i + 1
            end
            if not found then
                pending.append (od)
            end
        end
----------------------

    frozen generate_one_interface (in : INTERFACE) is

        local
            i, n   : INTEGER
            rpath  : STRING
            tpath  : STRING
            bpath  : STRING
            tf1    : PLAIN_TEXT_FILE
            name   : STRING
            cname  : STRING
            tname  : STRING
            sn     : SCOPED_NAME
            ad     : ATTR_DCL
            is_def : BOOLEAN
            pr     : INDEXED_LIST [OP_DCL]

        do
            rpath             := scoped_name_to_path (in.name)
            name              := scoped_name_to_class_name (in.name)
            current_interface := clone (name)
            current_interface.to_lower
            cname := constant_classname
            if is_a_servant       and then
               fs.file_exists (rpath) then
                n := rpath.substring_index (".e", 1)
                tpath := rpath.substring (1, n - 1)
                bpath := clone (tpath)
                tpath.append (".tmp")
                bpath.append (".bak")
                create tf.make_open_write (tpath)
            else
                create tf.make_open_write (rpath)
            end
            io.set_file_default (tf)
            is_def := (in.component_count > 0 or in.parent_count > 0)
            if is_def          and then
               interfaces_deferred then
                -- Don't make it deferred if it has no features and
                -- no parents ...
                io.put_string ("deferred ")
            end
            io.put_string ("class ")
            io.put_string (name)
            if class_name_suffix /= void then
                 io.put_string (class_name_suffix)
            end
            io.new_line
            generate_standard_warning
            generate_interface_inherit (in)
            generate_interface_creators
            if feature_names.has (in.name) then
                features := feature_names.at (in.name)
            else
                create features.make (false)
                collect_interface_feature_names (in)
                feature_names.put (features, in.name)
            end

            if is_a_servant          or else
               is_a_stub             or else
               (not is_a_skeleton and
                in.component_count > 0) then
                io.put_string ("feature%N%N")
            else
                io.new_line
            end
            generate_interface_make (in)
--            if is_a_servant then
--                from
--                    pr := flat_version.at (in.name)
--                    i := pr.low_index
--                    n := pr.high_index
--                until
--                    i > n
--                loop
--                    pr.at (i).accept (current)
--                    i := i + 1
--                end
--            else
                from
                    i := 1
                    n := in.component_count
                until
                    i > n
                loop
                    in.component_at (i).accept(current)
                    i := i + 1
                end -- loop
--            end -- if is_a_servant then ...

            if not attr_queue.empty  and
               not is_a_stub         then
                from
                    -- Nothing
                until
                    attr_queue.empty
                loop
                    ad := attr_queue.item
                    attr_queue.remove
                    build_one_accessor_and_mutator (ad)
                end -- loop             
                io.new_line
            end -- if not attr_queue.empty then ...

            if is_a_skeleton then
                io.put_string ("feature { NONE }%N%N")
                pending_routines := flat_version.at (in.name)
                generate_dispatcher
            end

            if is_an_implementation then
                build_accessors_and_mutators (in)
                    -- They were deleted after generating the skeleton.
                if in.abstract then
                    generate_dummy_consume
                    generate_dummy_valid_message_type
                    if in.parent_count = 0 then
                        generate_dummy_template
                    end
                else
                    pending_routines := flat_version.at (in.name)
                    generate_consume
                    generate_valid_message_type
                    if in.parent_count = 0 then
                        generate_template
                    end
                end -- if in.abstract then ...
            end

            create pending_routines.make (false)
                -- necessary so the next interface will be correct.

            if is_an_implementation then
                generate_repoid (in.name, true)
                generate_type_name (in.name.last_name_component)

            end
            io.put_string ("end -- class ")
            io.put_string (name)
            if class_name_suffix /= void then
                 io.put_string (class_name_suffix)
            end
            io.new_line
            if tpath /= void then
                -- There was already a prototype;
                -- decide what to do with it.
                if files_differ (tpath, rpath) and
                   not no_backups              then
                    -- Make `rpath' the backup-file.
                    create tf1.make (rpath)
                    tf1.change_name (bpath)
                        -- I can hardly express how I hate using this
                        -- ISE interface!!
                end 
                    -- tf is the tmp-file; rename it `rpath'.
                    tf.change_name (rpath)
            end

            tf.close
            tf := void

            -- What kind of typecode could we possibly generate here ???
--            generate_typecode (in.name, in)

        rescue
            if tf /= void and then not tf.is_closed then
                tf.close
                tf := void
            end
        end
----------------------

    collect_interface_feature_names (in : INTERFACE) is

        local
            pin  : INTERFACE
            i, n : INTEGER
            j, m : INTEGER
            ex   : INTERFACE_EXPORT
            ad   : ATTR_DCL
            od   : OP_DCL
            cd   : CONST_DCL

        do
            from
                i := 1
                n := in.parent_count
            until
                i > n
            loop
                pin := interfaces.at (in.parent_at (i))
                if feature_names.has (pin.name) then
                    include_features_of (pin.name)
                else
                    collect_interface_feature_names (pin)
                end
                i := i + 1
            end
            from
                i := 1
                n := in.component_count
            until
                i > n
            loop
                ex := in.component_at (i)
                i  := i + 1
                cd ?= ex
                ad ?= ex
                od ?= ex
                if cd /= void then
                    features.add (cd.name.last_name_component)
                elseif od /= void then
                    features.add (od.name)
                elseif ad /= void then
                    from
                        j := 1
                        m := ad.component_count
                    until
                        j > m
                    loop
                        features.add (ad.component_at (j).identifier)
                        j := j + 1
                    end
                end
            end
        end
----------------------

    include_features_of (name : SCOPED_NAME) is

        require
            known_name : feature_names.has (name)

        local
            li : SORTED_LIST [STRING]
            it : ITERATOR

        do
            from
                li := feature_names.at (name)
                it := li.iterator
            until
                it.finished
            loop
                features.add (li.item (it))
                it.forth
            end
        end
----------------------

    files_differ (path1, path2 : STRING) : BOOLEAN is

        require
            files_exist : fs.file_exists (path1) and
                          fs.file_exists (path2)

        local
            t1, t2 : INDEXED_LIST [STRING]
            i, n   : INTEGER

        do
            t1 := load_file (path1)
            t2 := load_file (path2)
            from
                result := (t1.count /= t2.count)
                i      := 1
                n      := t1.count
            until
                result or i > n
            loop
                result := not equal (t1.at (i), t2.at (i))
                i      := i + 1
            end
        end
----------------------

    load_file (path : STRING) : INDEXED_LIST [STRING] is

        require
            file_exists : fs.file_exists (path)

        local
            file : PLAIN_TEXT_FILE

        do
            from
                create file.make_open_read (path)
                create result.make (false)
            until
                file.end_of_file or else not file.file_readable
            loop
                file.read_line
                result.append (clone (file.last_string))
            end
        end
----------------------

    frozen generate_all_arrays is

        local
            it : ITERATOR
            cs : SCOPED_NAME

        do
            from
                it := arrays.iterator
                cs := symbol_table.current_scope
            until
                it.finished
            loop
                if arrays.key (it).has_prefix (cs) then
                    generate_one_array (arrays.item (it))
                end
                it.forth
            end
        end
----------------------

    frozen generate_one_array (dcl : ARRAY_DECLARATOR) is

        local
            i, n   : INTEGER
            path   : STRING
            name   : STRING
            total  : INTEGER
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

            path   := scoped_name_to_path (dcl.name)
            name   := scoped_name_to_class_name (dcl.name)
            create tf.make_open_write (path)
            io.set_file_default (tf)
            io.put_string ("class ")
            io.put_string (name)
            io.new_line
            generate_standard_warning
            io.put_string ("%Ninherit%N")
            indent_to (1)
            io.put_string (standard_parent)
            io.new_line
            if is_an_implementation then
                indent_to (2)
                io.put_string ("redefine%N")
                indent_to (3)
                io.put_string ("consume, valid_message_type%N")
                indent_to (2)
                io.put_string ("end")
            else
                indent_to (2)
                io.put_string ("redefine%N")
                indent_to (3)
                io.put_string ("repoid%N")
                indent_to (2)
                io.put_string ("end")
            end
            io.new_line

            io.put_string ("%Ncreation%N")
            indent_to (1)
            io.put_string ("make%N")


            io.put_string ("%Nfeature%N%N")
            generate_array_make (name, dcl)
            generate_array_get_value (dcl)
            generate_array_set_value (dcl)
            generate_array_attribute (dcl)
            generate_array_to_any (dcl)
            generate_array_from_any (dcl)
            generate_repoid (dcl.name, false)
            io.put_string ("end -- class ")
            io.put_string (name)
            io.new_line
            tf.close

            generate_typecode (dcl.name, dcl, "ARRAY_TYPECODE")

        rescue
            if tf /= void and then not tf.is_closed then
                tf.close
                tf := void
            end
        end
----------------------

    generate_array_to_any (dcl : ARRAY_DECLARATOR) is

        local
            ts  : TYPE_SPEC
            sn  : SCOPED_NAME

        do
            ts := dcl.type_spec
            indent_to (1)
            io.put_string ("array_to_any (ca : CORBA_ANY) is %N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("i, n : INTEGER%N")
            indent_to (3)
            io.put_string ("x    : ")
            ts.accept (current)
            io.new_line
            io.new_line
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("n := store.count%N")
            indent_to (3)
            io.put_string ("ca.arr_put_begin (n)%N")
            indent_to (3)
            io.put_string ("from%N")
            indent_to (4)
            io.put_string ("i := 0%N")
            indent_to (3)
            io.put_string ("until%N")
            indent_to (4)
            io.put_string ("i >= n%N")
            indent_to (3)
            io.put_string ("loop%N")
            indent_to (4)
            io.put_string ("x := store.item (i)%N")
            indent_to (4)
            io.put_string ("i := i + 1%N")
            sn ?= ts
            if is_object_type (ts) or 
               (sn /= void and then is_complex_type (sn)) then
                indent_to (4)
                io.put_string ("if x /= void then%N")
                indent_to (5)
                if sn /= void then
                    if is_complex_type (sn) then
                        io.put_string ("x.")
                        io.put_string (complex_type_from_scoped_name (sn))
                        io.put_string ("_to_any (ca)%N")
                    elseif is_aliased_type (sn) then
                        io.put_string ("ca.put_")
                        io.put_string (aliased_type_from_scoped_name (sn))
                        io.put_string (" (x)%N")
                    end
                elseif is_object_type (ts) then
                    io.put_string ("ca.put_object (%"")
                    io.put_string (sn.last_name_component)
                    io.put_string ("%", x)%N")
                end
                indent_to (4)
                io.put_string ("end%N")
            else -- must be a basic type
                indent_to (4)
                io.put_string ("ca.put_")
                io.put_string (type_spec_to_corbastring (ts))
                io.put_string (" (x)%N")
            end -- if is_object_tpe (sts) ...

            indent_to (3)
            io.put_string ("end%N")
            indent_to (3)
            io.put_string ("ca.arr_put_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_array_from_any (dcl : ARRAY_DECLARATOR) is

        local
            ts  : TYPE_SPEC
            sn  : SCOPED_NAME
            lnc : STRING

        do
            ts := dcl.type_spec
            indent_to (1)
            io.put_string ("array_from_any (ca : CORBA_ANY) is %N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("i, n : INTEGER%N")
            indent_to (3)
            io.put_string ("len  : INTEGER_REF%N")
            indent_to (3)
            io.put_string ("dum  : BOOLEAN%N")
            indent_to (3)
            io.put_string ("x    : ")
            ts.accept (current)
            io.new_line
            io.new_line
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("create len%N")
            indent_to (3)
            io.put_string ("ca.arr_get_begin (len)%N")
            indent_to (3)
            io.put_string ("n := len.item%N")
            indent_to (3)
            io.put_string ("create store.make (0, n - 1)%N")
            indent_to (3)
            io.put_string ("from%N")
            indent_to (4)
            io.put_string ("i := 0%N")
            indent_to (3)
            io.put_string ("until%N")
            indent_to (4)
            io.put_string ("i >= n%N")
            indent_to (3)
            io.put_string ("loop%N")
            indent_to (4)
            sn ?= ts
            if is_object_type (ts) then
                lnc := sn.last_name_component
                io.put_string ("x := ca.get_object(%"")
                io.put_string (lnc)
                io.put_string ("%")%N")
            elseif sn /= void then
                if is_complex_type (sn) then
                    io.put_string ("create x.make%N")
                    indent_to (4)
                    io.put_string ("x.")
                    io.put_string (complex_type_from_scoped_name (sn))
                    io.put_string ("_from_any (ca)%N")
                elseif is_aliased_type (sn) then
                    io.put_string ("x := ca.get_")
                    io.put_string (aliased_type_from_scoped_name (sn))
                    io.new_line    
                end
            else -- it must be a basic type
                io.put_string ("x := ca.get_")
                io.put_string (type_spec_to_corbastring (ts))
                io.new_line
            end
            indent_to (4)
            io.put_string ("store.put (x, i)%N")
            indent_to (4)
            io.put_string ("i := i + 1%N")
            indent_to (3)
            io.put_string ("end%N")
            indent_to (3)
            io.put_string ("ca.arr_get_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    frozen generate_all_sequences is

        local
            it : ITERATOR
            cs : SCOPED_NAME
            sn : SCOPED_NAME
            st : SEQUENCE_TYPE

        do
            from
                it := typedefs.iterator
            until
                it.finished
            loop
                st ?= typedefs.item (it).type_spec
                if st /= void then
                    sn := typedefs.item (it).aliased
                    if st.name = void then
                        -- This is better than nothing ...
                        st.set_name (sn)
                    end
                    if not sequences.has (st.name) then
                        sequences.put (st, st.name)
                    end
                end
                it.forth
            end

            from
                it := sequences.iterator
                cs := symbol_table.current_scope
            until
                it.finished
            loop
                sn := sequences.key (it)
                if sn.has_prefix (cs) then
                    finished.search (sn)
                    if not finished.found then
                        generate_one_sequence (sequences.item (it))
                        finished.add (sn)
                    end
                end
                it.forth
            end
        end
----------------------

    frozen generate_one_sequence (type : SEQUENCE_TYPE) is

        local
            i, n   : INTEGER
            path   : STRING
            name   : STRING
            hname  : STRING

        do
            path   := scoped_name_to_path (type.name)
            name   := scoped_name_to_class_name (type.name)

            create tf.make_open_write (path)
            io.set_file_default (tf)
            io.put_string ("class ")
            io.put_string (name)
            io.new_line
            generate_standard_warning

            hname := clone (project)
            hname.append ("_helper")
            hname.to_upper
            io.put_string ("%Ninherit%N")
            indent_to (1)
            io.put_string (hname)
 
            io.put_string ("%N%Ncreation%N")
            indent_to (1)
            io.put_string ("make_default%N")

            io.put_string ("%Nfeature%N%N")
            generate_sequence_make (name, type)
            generate_sequence_get_value (type)
            generate_sequence_set_value (type)
            generate_sequence_length
            generate_sequence_attribute (type)
            io.put_string ("feature { ANY }%N%N")
            generate_sequence_to_any (type)
            generate_sequence_from_any (type)
            generate_type_name (type.name.last_name_component)
            io.put_string ("end -- class ")
            io.put_string (name)
            io.new_line
            tf.close

            generate_typecode (type.name, type, "SEQUENCE_TYPECODE")

        rescue
            if tf /= void and then not tf.is_closed then
                tf.close
                tf := void
            end
        end
----------------------

    generate_sequence_to_any (st : SEQUENCE_TYPE) is

        local
            sts : SIMPLE_TYPE_SPEC
            sn  : SCOPED_NAME
            t   : STRING

        do
            sts := st.simple_type_spec
            indent_to (1)
            io.put_string ("sequence_to_any (ca : CORBA_ANY) is %N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("i, n : INTEGER%N")
            indent_to (3)
            io.put_string ("x    : ")
            sts.accept (current)
            io.new_line
            io.new_line
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("n := length%N")
            indent_to (3)
            io.put_string ("ca.seq_put_begin (n)%N")
            indent_to (3)
            io.put_string ("from%N")
            indent_to (4)
            io.put_string ("i := 1%N")
            indent_to (3)
            io.put_string ("until%N")
            indent_to (4)
            io.put_string ("i > n%N")
            indent_to (3)
            io.put_string ("loop%N")
            indent_to (4)
            io.put_string ("x := store.item (i)%N")
            indent_to (4)
            io.put_string ("i := i + 1%N")
            sn  ?= sts
            indent_to (4)
            io.put_string ("if x /= void then%N")
            indent_to (5)
            if sn /= void then
                if is_complex_type (sn) then
                    io.put_string ("x.")
                    io.put_string (complex_type_from_scoped_name (sn))
                    io.put_string ("_to_any (ca)%N")
                elseif is_aliased_type (sn) then
                    t := aliased_type_from_scoped_name (sn)
                    io.put_string ("ca.put_")
                    io.put_string (t)
                    if equal (t, "string") then
                        io.put_string (" (x, 0)%N")
                    else
                        io.put_string (" (x)%N")                        
                    end
                elseif types_defined_here.has
                             (sn.last_name_component)        or else
                       equal (sn.last_name_component, "Object") then
                    io.put_string ("ca.put_object (%"")
                    io.put_string (sn.last_name_component)
                    io.put_string ("%", x)%N")
                else
                    indent_to (4)
                    io.put_string ("ca.put_")
                    io.put_string (type_spec_to_corbastring (sts))
                    io.put_string (" (x)%N")
                end -- if is_complex_type (sn) then ...
            end -- if sn /= void then ...
            indent_to (4)
            io.put_string ("end%N")
            indent_to (3)
            io.put_string ("end%N")
            indent_to (3)
            io.put_string ("ca.seq_put_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    is_object_type (ts : TYPE_SPEC) : BOOLEAN is

        local
            sn : SCOPED_NAME

        do
            sn ?= ts
            if sn /= void then
                result := types_defined_here.has (sn.last_name_component)
            end
        end
----------------------

     is_complex_type (sn : SCOPED_NAME) : BOOLEAN is

        require
            nonvoid_arg : sn /= void

        do
            result := (structs.has (sn)    or
                       sequences.has (sn)  or
                       unions.has (sn)     or
                       exceptions.has (sn) or
                       arrays.has (sn)     or
                       enums.has (sn))
        end
----------------------

    local_is_complex_type (t : STRING) : BOOLEAN is

        do
            result := equal (t, "struct")   or else
                      equal (t, "union")    or else
                      equal (t, "sequence") or else
                      equal (t, "array")    or else
                      equal (t, "enum")
        end
----------------------

    is_aliased_type (sn : SCOPED_NAME) : BOOLEAN is

        require
            nonvoid_arg : sn /= void

        local
            lnc : STRING
            sn1 : SCOPED_NAME

        do
            lnc    := sn.last_name_component
            create sn1.make
            sn1.add_name_component (lnc)
            result := typedefs.has (sn) or typedefs.has (sn1)
        end
----------------------

    unaliased_type (sn : SCOPED_NAME) : STRING is

        require
            nonvoid_arg : sn /= void
            is_aliased_type : is_aliased_type (sn)

        local
            lnc : STRING
            sn1 : SCOPED_NAME
            tdt : TYPEDEF_TYPE 
            
        do
            if typedefs.has (sn) then
                tdt := typedefs.at (sn)
            else
                lnc    := sn.last_name_component
                create sn1.make
                sn1.add_name_component (lnc)
                tdt := typedefs.at (sn1)
            end
            result := tdt.aliased.to_string
        end
----------------------

    generate_sequence_from_any (st : SEQUENCE_TYPE) is

        local
            sts : SIMPLE_TYPE_SPEC
            sn  : SCOPED_NAME
            lnc : STRING
            ct  : STRING

        do
            sts := st.simple_type_spec
            indent_to (1)
            io.put_string ("sequence_from_any (ca : CORBA_ANY) is %N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("i, n : INTEGER%N")
            indent_to (3)
            io.put_string ("len  : INTEGER_REF%N")
            indent_to (3)
            io.put_string ("dum  : BOOLEAN%N")
            indent_to (3)
            io.put_string ("o    : CORBA_OBJECT%N")
            indent_to (3)
            io.put_string ("x    : ")
            sts.accept (current)
            io.new_line
            io.new_line
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("create len%N")
            indent_to (3)
            io.put_string ("dum := ca.seq_get_begin (len)%N")
            indent_to (3)
            io.put_string ("n := len.item%N")
            indent_to (3)
            io.put_string ("create store.make (1, n)%N")
            indent_to (3)
            io.put_string ("from%N")
            indent_to (4)
            io.put_string ("i := 1%N")
            indent_to (3)
            io.put_string ("until%N")
            indent_to (4)
            io.put_string ("i > n%N")
            indent_to (3)
            io.put_string ("loop%N")
            indent_to (4)
            sn ?= sts
            if sn /= void then
                if is_complex_type (sn) then
                    ct := complex_type_from_scoped_name (sn)
                    if equal (ct, "struct") or equal (ct, "exception") then
                        io.put_string ("create x.make_default%N")
                    else
                        io.put_string ("create x.make%N")
                    end
                    indent_to (4)
                    io.put_string ("x.")
                    io.put_string (ct)
                    io.put_string ("_from_any (ca)%N")
                elseif is_aliased_type (sn) then
                    ct := aliased_type_from_scoped_name (sn)
                    io.put_string ("x := ca.get_")
                    io.put_string (ct)
                    if equal (ct, "string") then
                        io.put_string (" (0)%N")
                    else
                        io.new_line
                    end
                elseif types_defined_here.has
                                (sn.last_name_component)     or else
                       equal (sn.last_name_component, "Object") then
                    io.put_string ("o := ca.get_object (%"")
                    io.put_string (sn.last_name_component)
                    io.put_string ("%")%N")
                    indent_to (4)
                    io.put_string ("x := ")
                    io.put_string (scoped_name_to_narrow_name (sn))
                    io.put_string (" (o)%N")
                else
                    ct := type_spec_to_corbastring (sts)
                    io.put_string ("x := ca.get_")
                    io.put_string (ct)
                    if equal (ct, "string") then
                        io.put_string (" (0)%N")
                    else
                        io.new_line
                    end
                end -- if is_complex_type (sn) then ...
            end -- if sn /= void then
            indent_to (4)
            io.put_string ("store.put (x, i)%N")
            indent_to (4)
            io.put_string ("i := i + 1%N")
            indent_to (3)
            io.put_string ("end%N")
            indent_to (3)
            io.put_string ("ca.seq_get_end%N")
            indent_to (3)
            io.put_string ("length := n%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    type_spec_to_corbastring (ts : TYPE_SPEC) : STRING is

        local
            it  : INTEGER_TYPE
            ct  : CHAR_TYPE
            wct : WIDE_CHAR_TYPE
            ft  : FLOATING_PT_TYPE
            bt  : BOOLEAN_TYPE
            ot  : OCTET_TYPE
            sn  : SCOPED_NAME
            lnc : STRING
            st  : STRING_TYPE
            at  : ANY_TYPE

        do
            it ?= ts
            if it /= void then
                if it.short then
                    if it.unsigned then
                        result := "ushort"
                    else
                        result := "short"
                    end
                elseif it.longlong then
                    if it.unsigned then
                        result := "ulonglong"
                    else
                        result := "longlong"
                    end
                else -- it must be some kind of long
                    if it.unsigned then
                        result := "ulong"
                    else
                        result := "long"
                    end
                end
            end -- it it /= void then ...
            if result = void then
                ft ?= ts
                if ft /= void then
                    if ft.is_double then
                        if ft.long then
                            result := "longdouble"
                        else
                            result := "double"
                        end
                    else
                        result := "float"
                    end -- if ft.is_double then ...
                end -- if ft /= void then ...
            end -- if result = void then ...
            if result = void then
                ct  ?= ts
                wct ?= ts
                if ct /= void then
                    result := "char"
                elseif wct /= void then
                    result := "wchar"
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
            if result = void then
                ot ?= ts
                if ot /= void then
                    result := "octet"
                end
            end
            if result = void then
                at ?= ts
                if at /= void then
                    result := "any"
                end
            end
            if result = void then
                sn ?= ts
                if sn /= void then
                    if is_complex_type (sn) then
                        result := complex_type_from_scoped_name (sn)
                    else -- last attempt
                        lnc := sn.last_name_component
                        result := "object (%""
                        result.append (lnc)
                        result.extend ('"')
                    end -- if is_complex_type (sn) then ...
                else -- sn = void
                    result := "unknown" -- give up
                end -- if sn /= void then ...
            end -- if result = void then ...

        ensure
            nonvoid_result : result /= void
        end
----------------------

    frozen generate_all_structs is

        local
            it : ITERATOR
            cs : SCOPED_NAME
            sn : SCOPED_NAME
            st : STRUCT_TYPE

        do
            from
                it := typedefs.iterator
            until
                it.finished
            loop
                st ?= typedefs.item (it).type_spec
                if st /= void then
                    sn := typedefs.key (it)
                    st.set_name (sn)
                    structs.put (st, sn)
                    finished.search (sn)
                    if not finished.found then
                        generate_one_struct (st)
                        finished.add (sn)
                    end
                end
                it.forth
            end

            from
                it := structs.iterator
                cs := symbol_table.current_scope
            until
                it.finished
            loop
                sn := structs.key (it)
                if sn.has_prefix (cs) then
                    finished.search (sn)
                    if not finished.found then
                        generate_one_struct (structs.item (it))
                        finished.add (sn)
                    end
                end
                it.forth
            end
        end
----------------------

    frozen generate_one_struct (type : STRUCT_TYPE) is

        local
            i, n   : INTEGER
            path   : STRING
            name   : STRING
            hname  : STRING

        do
            path   := scoped_name_to_path (type.name)
            name   := scoped_name_to_class_name (type.name)

            create tf.make_open_write (path)
            io.set_file_default (tf)
            io.put_string ("class ")
            io.put_string (name)
            io.new_line
            generate_standard_warning
            if feature_names.has (type.name) then
                features := feature_names.at (type.name)
            else
                create features.make (false)
                collect_struct_feature_names (type)
                feature_names.put (features, type.name)
            end

            hname := clone (project)
            hname.append ("_helper")
            hname.to_upper
            io.put_string ("%Ninherit%N")
            indent_to (1)
            io.put_string (hname)

            io.put_string ("%N%Ncreation%N")
            indent_to (1)
            io.put_string ("make, make_default%N")

            io.put_string ("%Nfeature%N%N")
            generate_struct_make (type)
            from
                i := 1
                n := type.component_count
            until
                i > n
            loop
                type.component_at (i).accept (current)
                i := i + 1
            end

            generate_struct_to_any (type)
            generate_struct_from_any (type)
            generate_type_name (type.name.last_name_component)
            io.put_string ("end -- class ")
            io.put_string (name)
            io.new_line
            tf.close
            generate_typecode (type.name, type, "STRUCT_TYPECODE")

        rescue
            if tf /= void and then not tf.is_closed then
                tf.close
                tf := void
            end
        end
----------------------

    collect_struct_feature_names (st : STRUCT_TYPE) is

        local
            i, n : INTEGER
            j, m : INTEGER
            me   : MEMBER
            lnc  : STRING

        do
            from
                i := 1
                n := st.component_count
            until
                i > n
            loop
                me := st.component_at (i)
                i  := i + 1
                from
                    j := 1
                    m := me.component_count
                until
                    j > m
                loop
                    lnc := me.component_at (j).name.last_name_component
                    features.add (lnc)
                    j := j + 1
                end
            end
        end
----------------------

    generate_struct_to_any (st : STRUCT_TYPE) is

        local
            i, n : INTEGER
            j, m : INTEGER
            me   : MEMBER
            de   : IDL_DECLARATOR
            ts   : TYPE_SPEC
            sn   : SCOPED_NAME
            t    : STRING

        do
            indent_to (1)
            io.put_string ("struct_to_any (ca : CORBA_ANY) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("dum : BOOLEAN%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("dum := ca.struct_put_begin%N")
            from
                i := 1
                n := st.component_count
            until
                i > n
            loop
                me := st.component_at (i)
                ts := me.type_spec
                sn ?= ts
                from
                    j := 1
                    m := me.component_count
                until
                    j > m
                loop
                    de := me.component_at (j)
                    indent_to (3)
                    if sn /= void then
                        if is_complex_type (sn) then
                            io.put_string (de.name.last_name_component)
                            io.putchar ('.')
                            io.put_string (complex_type_from_scoped_name (sn))
                            io.put_string ("_to_any (ca)%N")
                        elseif is_aliased_type (sn) then
                            t := aliased_type_from_scoped_name (sn)
                            io.put_string ("ca.put_")
                            io.put_string (t)
                            io.put_string (" (")
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            if equal (t, "string") then
                                io.put_string (", 0)%N")
                            else
                                io.put_string (")%N")
                            end
                        elseif equal (sn.last_name_component, "TypeCode") then
                            io.put_string ("ca.put_typecode (")
                            io.put_string (safe_name(
                                        de.name.last_name_component, false))
                            io.put_string (")%N")
                        elseif types_defined_here.has
                                (sn.last_name_component) then
                            io.put_string ("ca.put_object (%"")
                            io.put_string (sn.last_name_component)
                            io.put_string ("%", ")
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            io.put_string (")%N")
                        end
                    else
                        t := type_spec_to_corbastring (ts)
                        io.put_string ("ca.put_")
                        io.put_string (t)
                        io.put_string (" (")
                        io.put_string (safe_name (
                            de.name.last_name_component, false))
                        if equal (t, "string") then
                            io.put_string (", 0)%N")
                        else
                            io.put_string (")%N")
                        end
                    end
                    j := j + 1
                end

                i := i + 1
            end
            indent_to (3)
            io.put_string ("ca.struct_put_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    complex_type_from_scoped_name (sn : SCOPED_NAME) : STRING is
        -- "struct", "union", etc. depending on `sn'.

        require
            is_complex_type : is_complex_type (sn)

        do
            if structs.has (sn) then
                result := "struct"
            elseif sequences.has (sn) then
                result := "sequence"
            elseif unions.has (sn) then
                result := "union"
            elseif exceptions.has (sn) then
                result := "exception"
            elseif arrays.has (sn) then
                result := "array"
            elseif enums.has (sn) then
                result := "enum"
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    aliased_type_from_scoped_name (sn : SCOPED_NAME) : STRING is

        require
            nonvoid_arg     : sn /= void
            is_aliased_type : is_aliased_type (sn)

        local
            tt  : TYPEDEF_TYPE
            sn1 : SCOPED_NAME
            lnc : STRING

        do
            if typedefs.has (sn) then
                tt     := typedefs.at (sn)
                result := tt.aliased.last_name_component
            else
                lnc := sn.last_name_component
                create sn1.make
                sn1.add_name_component (lnc)
                tt     := typedefs.at (sn1)
                result := tt.aliased.last_name_component
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------

    generate_struct_from_any (st : STRUCT_TYPE) is

        local
            i, n : INTEGER
            j, m : INTEGER
            me   : MEMBER
            de   : IDL_DECLARATOR
            ts   : TYPE_SPEC
            sn   : SCOPED_NAME
            t    : STRING

        do
            indent_to (1)
            io.put_string ("struct_from_any (ca : CORBA_ANY) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("dum : BOOLEAN%N")
            indent_to (3)
            io.put_string ("o   : CORBA_OBJECT%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("dum := ca.struct_get_begin%N")
            from
                i := 1
                n := st.component_count
            until
                i > n
            loop
                me := st.component_at (i)
                ts := me.type_spec
                sn ?= ts
                from
                    j := 1
                    m := me.component_count
                until
                    j > m
                loop
                    de := me.component_at (j)
                    indent_to (3)

                    if sn /= void then
                        if is_complex_type (sn) then
                            io.put_string ("create ")
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            io.put_string (".make_default%N")
                            indent_to (3)
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            io.putchar ('.')
                            io.put_string (complex_type_from_scoped_name (sn))
                            io.put_string ("_from_any (ca)%N")
                        elseif is_aliased_type (sn) then
                            t := aliased_type_from_scoped_name (sn)
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            io.put_string (" := ca.get_")
                            io.put_string (t)
                            if equal (t, "string") then
                                io.put_string (" (0)%N")
                            else
                                io.new_line
                            end
                        elseif equal (sn.last_name_component, "TypeCode") then
                            io.put_string (safe_name (
                                    de.name.last_name_component, false))
                            io.put_string (" := ca.get_typecode%N")
                        elseif types_defined_here.has
                                (sn.last_name_component) then
                            io.put_string ("o := ca.get_object (%"")
                            io.put_string (sn.last_name_component)
                            io.put_string ("%")%N")
                            indent_to (3)
                            io.put_string (safe_name (
                                    de.name.last_name_component, false))
                            io.put_string (" := ")
                            io.put_string (scoped_name_to_narrow_name (sn))
                            io.put_string (" (o)%N")
                        end
                    else
                        t := type_spec_to_corbastring (ts)
                        io.put_string (safe_name (
                            de.name.last_name_component, false))
                        io.put_string (" := ca.get_")
                        io.put_string (t)
                        if equal (t, "string") then
                            io.put_string (" (0)%N")
                        else
                            io.new_line
                        end
                    end
                    j := j + 1
                end

                i := i + 1
            end
            indent_to (3)
            io.put_string ("dum := ca.struct_get_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_all_exceptions is

        local
            it : ITERATOR
            cs : SCOPED_NAME
            sn : SCOPED_NAME

        do
            from
                it := exceptions.iterator
                cs := symbol_table.current_scope
            until
                it.finished
            loop
                sn := exceptions.key (it)
                if sn.has_prefix (cs) then
                    finished.search (sn)
                    if not finished.found then
                        generate_one_exception (exceptions.item (it))
                        finished.add (sn)
                    end
                end
                it.forth
            end
        end
----------------------

    generate_one_exception (ed : EXCEPT_DCL) is

        local
            i, n   : INTEGER
            path   : STRING
            name   : STRING
            hname  : STRING

        do
            path   := scoped_name_to_path (ed.name)
            name   := scoped_name_to_class_name (ed.name)

            hname := clone (project)
            hname.append ("_helper")
            hname.to_upper
            create tf.make_open_write (path)
            io.set_file_default (tf)
            io.put_string ("class ")
            io.put_string (name)
            io.new_line
            generate_standard_warning
            io.put_string ("%Ninherit%N")
            indent_to (1)
            io.put_string (hname)
            io.put_string (";%N")
            if constant_classname /= void then
                indent_to (1)
                io.put_string (constant_classname)
                io.put_string (";%N")
            end
            indent_to (1)
            io.put_string ("CORBA_USER_EXCEPTION%N")
            indent_to (2)
            io.put_string ("rename%N")
            indent_to (3)
            io.put_string ("make as make_default%N")
            indent_to (2)
            io.put_string ("end %N%N")

            if feature_names.has (ed.name) then
                features := feature_names.at (ed.name)
            else
                create features.make (false)
                collect_exception_feature_names (ed)
                feature_names.put (features, ed.name)
            end

            io.put_string ("creation%N")
            indent_to (1)
            io.put_string ("make, make_default%N")

            io.put_string ("%Nfeature%N%N")
            generate_except_make (ed)
            from
                i := 1
                n := ed.component_count
            until
                i > n
            loop
                ed.component_at (i).accept (current)
                i := i + 1
            end

            generate_exception_to_any (ed)
            generate_exception_from_any (ed)
            generate_repoid (ed.name, false)
            generate_exception_encode (ed.name)


            io.put_string ("end -- class ")
            io.put_string (name)
            io.new_line
            tf.close
            generate_typecode (ed.name, ed, "EXCEPTION_TYPECODE")

        rescue
            if tf /= void and then not tf.is_closed then
                tf.close
                tf := void
            end
        end
----------------------

    collect_exception_feature_names (ed : EXCEPT_DCL) is

        local
            i, n : INTEGER
            j, m : INTEGER
            me   : MEMBER
            lnc  : STRING

        do
            from
                i := 1
                n := ed.component_count
            until
                i > n
            loop
                me := ed.component_at (i)
                i  := i + 1
                from
                    j := 1
                    m := me.component_count
                until
                    j > m
                loop
                    lnc := me.component_at (j).name.last_name_component
                    features.add (lnc)
                    j := j + 1
                end
            end
        end
----------------------

    generate_exception_to_any (ed : EXCEPT_DCL) is

        local
            i, n : INTEGER
            j, m : INTEGER
            me   : MEMBER
            de   : IDL_DECLARATOR
            ts   : TYPE_SPEC
            sn   : SCOPED_NAME
            t    : STRING

        do
            indent_to (1)
            io.put_string ("exception_to_any (ca : CORBA_ANY) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("ca.except_put_begin (repoid)%N")
            from
                i := 1
                n := ed.component_count
            until
                i > n
            loop
                me := ed.component_at (i)
                ts := me.type_spec
                sn ?= ts
                from
                    j := 1
                    m := me.component_count
                until
                    j > m
                loop
                    de := me.component_at (j)
                    indent_to (3)
                    if sn /= void then
                        if is_complex_type (sn) then
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            io.putchar ('.')
                            io.put_string (complex_type_from_scoped_name (sn))
                            io.put_string ("_to_any (ca)%N")
                        elseif is_aliased_type (sn) then
                            t := aliased_type_from_scoped_name (sn)
                            io.put_string ("ca.put_")
                            io.put_string (t)
                            io.put_string (" (")
                            io.put_string (safe_name (
                                    de.name.last_name_component, false))
                            if equal (t, "string") then
                                io.put_string (", 0)%N")
                            else
                                io.put_string (")%N")
                            end
                        elseif types_defined_here.has
                                (sn.last_name_component) then
                            io.put_string ("ca.put_object (%"")
                            io.put_string (sn.last_name_component)
                            io.put_string ("%", ")
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            io.put_string (")%N")
                        end
                    else
                        t := type_spec_to_corbastring (ts)
                        io.put_string ("ca.put_")
                        io.put_string (t)
                        io.put_string (" (")
                        io.put_string (safe_name (
                                de.name.last_name_component, false))
                        if equal (t, "string") then
                            io.put_string (", 0)%N")
                        else
                            io.put_string (")%N")
                        end
                    end
                    j := j + 1
                end

                i := i + 1
            end
            indent_to (3)
            io.put_string ("ca.except_put_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_exception_from_any (ed : EXCEPT_DCL) is

        local
            i, n : INTEGER
            j, m : INTEGER
            me   : MEMBER
            de   : IDL_DECLARATOR
            ts   : TYPE_SPEC
            sn   : SCOPED_NAME
            t    : STRING

        do
            indent_to (1)
            io.put_string ("exception_from_any (ca : CORBA_ANY) is%N%N")
            indent_to (2)
            io.put_string ("require%N")
            indent_to (3)
            io.put_string ("nonvoid_arg : ca /= void%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("dum : STRING%N")
            indent_to (3)
            io.put_string ("o   : CORBA_OBJECT%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("dum := ca.except_get_begin%N")
            from
                i := 1
                n := ed.component_count
            until
                i > n
            loop
                me := ed.component_at (i)
                ts := me.type_spec
                sn ?= ts
                from
                    j := 1
                    m := me.component_count
                until
                    j > m
                loop
                    de := me.component_at (j)
                    indent_to (3)
                    if sn /= void then
                        if is_complex_type (sn) then
                            io.put_string ("create ")
                            io.put_string (safe_name (
                                    de.name.last_name_component, false))
                            io.put_string (".make_default%N")
                            indent_to (3)
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            io.putchar ('.')
                            io.put_string (complex_type_from_scoped_name (sn))
                            io.put_string ("_from_any (ca)%N")
                        elseif is_aliased_type (sn) then
                            t := aliased_type_from_scoped_name (sn)
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            io.put_string (" := ca.get_")
                            io.put_string (t)
                            if equal (t, "string") then
                                io.put_string (" (0)%N")
                            else
                                io.new_line
                            end
                        elseif types_defined_here.has
                                (sn.last_name_component) then

                            io.put_string ("o := ca.get_object (%"")
                            io.put_string (sn.last_name_component)
                            io.put_string ("%")%N")
                            indent_to (3)
                            io.put_string (safe_name (
                                de.name.last_name_component, false))
                            io.put_string (" := ")
                            io.put_string (scoped_name_to_narrow_name (sn))
                            io.put_string (" (o)%N")
                        end
                    else
                        t := type_spec_to_corbastring (ts)
                        io.put_string (safe_name (
                            de.name.last_name_component, false))
                        io.put_string (" := ca.get_")
                        io.put_string (t)
                        if equal (t, "string") then
                            io.put_string (" (0)%N")
                        else
                            io.new_line
                        end
                    end
                    j := j + 1
                end

                i := i + 1
            end
            indent_to (3)
            io.put_string ("ca.except_get_end%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_exception_encode (name : SCOPED_NAME) is

        do
            indent_to (1)
            io.put_string ("encode (ec : DATA_ENCODER) is%N%N")
            indent_to (2)
            io.put_string ("local%N")
            indent_to (3)
            io.put_string ("ca : CORBA_ANY%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("create ca.make3 (")
            io.put_string (scoped_name_to_tcname (name))
            io.put_string (", ec.decoder, ec)%N")
            indent_to (3)
            io.put_string ("exception_to_any (ca)%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    bts_to_idl_type (bts : BASE_TYPE_SPEC)  : STRING is

        local
            it  : INTEGER_TYPE
            fpt : FLOATING_PT_TYPE
            bt  : BOOLEAN_TYPE
            ct  : CHAR_TYPE

        do
            it  ?= bts
            fpt ?= bts
            if it /= void then
                if it.short then
                    if it.unsigned then
                        result := "ushort"
                    else
                        result := "short"
                    end
                elseif it.longlong then
                    if it.unsigned then
                        result := "ulonglong"
                    else
                        result := "longlong"
                    end
                else
                    if it.unsigned then
                        result := "ulong"
                    else
                        result := "long"
                    end
                end
            elseif fpt /= void then
                if fpt.is_double then
                    if fpt.long then
                        result := "longdouble"
                    else
                        result := "double"
                    end
                else
                    result := "float"
                end
            elseif bt /= void then
                result := "boolean"
            elseif ct /= void then
                result := "char"
            end
        end
----------------------

    frozen generate_repoid (name : SCOPED_NAME; has_ior : BOOLEAN) is

        do
            indent_to (1)
            io.put_string ("repoid : STRING is %N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("result := %"")
            io.put_string (scoped_name_to_repoid(name))
            io.put_string ("%"%N")
            if has_ior then
                indent_to (3)
                io.put_string ("ior.set_repoid (result)%N")
            end
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    scoped_name_to_repoid (name : SCOPED_NAME) : STRING is

        local
            i, n : INTEGER

        do
            if user_repoids /= void and then
               user_repoids.has (name)  then
                result := user_repoids.at (name)
            else -- use standard rule
                result := clone (id_prefix)
                if repoid_prefix /= void then
                    result.append (repoid_prefix)
                    result.extend ('/')
                end
                from
                    i := 1
                    n := name.name_component_count
                until
                    i > n
                loop
                    result.append (name.name_component_at (i))
                    if i < n then
                        result.extend ('/')
                    end
                    i := i + 1
                end
                result.extend (':')
                if local_versions /= void and then
                   local_versions.has (name)  then
                    result.append (local_versions.at (name))
                else
                    result.append (global_version)
                end
            end -- if user_repoids.has (name) then ...
        end
----------------------

    generate_constants_header is

        local
            psn  : SCOPED_NAME
            path : STRING
            lnc  : STRING
            inh  : BOOLEAN
            iot  : IO_TEXT

        do
            psn := symbol_table.current_scope.duplicate
            if psn.name_component_count > 0 then
                psn.remove_last_name_component
                if psn.name_component_count = 0 then
                    lnc := clone (project)
                    lnc.append ("_globalconstants")
                else
                    lnc := "constants"
                end
                psn.add_name_component (lnc)
                inh := true
            end

            iot := active_constant_text
            iot.put_string ("class ")
            iot.put_string (constant_classname)
            iot.new_line
            generate_standard_warning_for_constants
            iot.new_line
            iot.new_line
            iot.put_string ("inherit")
            iot.new_line
            iot.indent_to (1)
            if inh then
                iot.put_string (scoped_name_to_class_name (psn))
                iot.new_line
            else
                iot.put_string ("TYPECODE_STATICS")
                iot.new_line                
                top_constant_text := iot
            end
            iot.new_line
            iot.put_string ("feature")
            iot.new_line
            iot.new_line
        end
----------------------

    generate_constants_trailer is

        local
            path : STRING
            iot  : IO_TEXT

        do
            iot := active_constant_text
            iot.put_string ("%Nend -- class ")
            iot.put_string (constant_classname)
            iot.new_line
            path := constant_path
            create tf.make_open_write (path)
            iot.write_to_file (tf)
            tf.close
        end
----------------------

    generate_typecode (name : SCOPED_NAME;
                       ise : IDL_SYNTAX_ELEMENT;
                       rtype : STRING) is

        local
            slist : INDEXED_LIST [STRING]
            tcstr : STRING
            sname : STRING
            i, n  : INTEGER
            last  : INTEGER 
            iot   : IO_TEXT

        do
            sname := safe_name ("s", true)
            iot   := top_constant_text
            tcstr := ise.typecode.stringify
            from
                i := 1
                n := tcstr.count
                create slist.make (false)
            until
                i > n
            loop
                if i + 31 <= n then
                    last := i + 31
                else
                    last := n
                end
                slist.append (tcstr.substring (i, last))
                i := last + 1
            end
            iot.indent_to (1)
            iot.put_string (scoped_name_to_tcname (name))
            iot.put_string (" : CORBA_TYPECODE is")
            iot.new_line
            iot.new_line
            iot.indent_to (2)
            iot.put_string ("local%N")
            iot.indent_to (3)
            iot.put_string (sname)
            iot.put_string (" : STRING%N%N")
            iot.indent_to (2)
            iot.put_string ("once")
            iot.new_line
            iot.indent_to (3)
            i := slist.low_index
            iot.put_string (sname)
            iot.put_string (" := %"")
            iot.put_string (slist.at (i))
            iot.put_string ("%"%N")
            from
                i := i + 1
                n := slist.high_index
            until
                i > n
            loop
                iot.indent_to (3)
                iot.put_string (sname)
                iot.put_string (".append  (%"")
                iot.put_string (slist.at (i))
                iot.put_string ("%")%N")
                i := i + 1
            end
            iot.indent_to (3)
            iot.put_string ("result := typecode_from_string (")
            iot.put_string (sname)
            iot.put_string (")%N")
            iot.indent_to (2)
            iot.put_string ("end")
            iot.new_line
            iot.new_line
        end
----------------------

    generate_type_name (nm : STRING) is

        do
            io.put_string ("feature { ANY }%N%N")
            indent_to (1)
            io.put_string ("type_name : STRING is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (3)
            io.put_string ("result := %"")
            io.put_string (nm)
            io.put_string ("%"%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_standard_warning is

        do
            indent_to (1)
            if is_a_servant then
                io.put_string ("-- This is a protype class. THE PROGRAMMER %
                               %IS EXPECTED TO IMPLEMENT%N")
                indent_to (1)
                io.put_string ("-- the body of each routine and add any %
                               %(private) attributes needed.%N")
            else
                io.put_string ("-- This text was automatically generated. %
                               %DO NOT EDIT!%N")
            end
        end
----------------------

    generate_standard_warning_for_constants is

        local
            iot : IO_TEXT

        do
            iot := active_constant_text
            iot.indent_to (1)
            iot.put_string ("-- This text was automatically generated. %
                            %DO NOT EDIT!%N")
        end
----------------------

    safe_name (name : STRING; is_param : BOOLEAN) : STRING is
        -- Prepend "idl_" if `name' is an Eiffel keyword or
        -- if `is_param' is true the name of a feature of the
        -- surrounding class.

        local
            nm : STRING

        do
            nm := clone (name)
            nm.to_lower
            dangerous_names.search (nm)
            if dangerous_names.found then
                result := "idl_"
            else
                result := ""
            end
            result.append (name)
            if is_param and features /= void then
                if is_a_featurename (name) then
                    result.prepend ("idl_")
                end -- if features.found then ...
            end -- if is_param and features /= void then ...
        end
----------------------

    is_a_featurename (name : STRING) : BOOLEAN is
        -- Is `name' the name of some feature if we ignore case?

        local
            it    : ITERATOR
            fname : STRING

        do
            from
                it := features.iterator
            until
                it.finished
            loop
                fname := clone (features.item (it))
                fname.to_lower
                if equal (name, fname) then
                    it.stop
                    result := true
                else
                    it.forth
                end
            end
        end
----------------------

    dangerous_names : SORTED_LIST [STRING] is

        once
            -- We begin with words that are keywords in Eiffel
            -- but not in IDL.
            create result.make (true)
            result.add ("alias")
            result.add ("all")
            result.add ("and")
            result.add ("as")
            result.add ("bit")
            result.add ("character")
            result.add ("check")
            result.add ("class")
            result.add ("create")
            result.add ("creation")
            result.add ("current")
            result.add ("debug")
            result.add ("deferred")
            result.add ("do")
            result.add ("else")
            result.add ("elseif")
            result.add ("end")
            result.add ("ensure")
            result.add ("expanded")
            result.add ("export")
            result.add ("external")
            result.add ("feature")
            result.add ("from")
            result.add ("frozen")
            result.add ("if")
            result.add ("implies")
            result.add ("indexing")
            result.add ("infix")
            result.add ("inherit")
            result.add ("inspect")
            result.add ("integer")
            result.add ("invariant")
            result.add ("is")
            result.add ("like")
            result.add ("local")
            result.add ("loop")
            result.add ("none")
            result.add ("not")
            result.add ("obsolete")
            result.add ("old")
            result.add ("once")
            result.add ("or")
            result.add ("pointer")
            result.add ("prefix")
            result.add ("real")
            result.add ("redefine")
            result.add ("rename")
            result.add ("require")
            result.add ("rescue")
            result.add ("result")
            result.add ("retry")
            result.add ("select")
            result.add ("separate")
            result.add ("strip")
            result.add ("then")
            result.add ("undefine")
            result.add ("unique")
            result.add ("until")
            result.add ("variant")
            result.add ("when")
            result.add ("xor")
            -- Now we add some words that are not eiffel keywords
            -- but rather features of CORBA_OBJECT resp. STANDARD_SKELETON
            result.add ("copy")
            result.add ("is_equal")
            result.add ("is_a")
            result.add ("omake")
            result.add ("make_with_ior")
            result.add ("class_name")
            result.add ("get_ident")
            result.add ("get_ior")
            result.add ("is_a_remote")
            result.add ("simplified_is_a_remote")
            result.add ("is_hashable")
            result.add ("am_a_stub")
            result.add ("corba_name")
            result.add ("message")
            result.add ("oorb")
            result.add ("nvl")
            result.add ("serv_boa")
            result.add ("serv_orb")
            result.add ("the_message")
            result.add ("ident")
            result.add ("ior")
            result.add ("repoid")
            result.add ("produce")
            result.add ("consume")
            result.add ("type_name")
            result.add ("message_available")
            result.add ("implementation")
            result.add ("find_impl")
            result.add ("find_iface")
        end
----------------------

    generate_dummy_consume is

        local
            mname  : STRING
            tname  : STRING

        do
            mname := safe_name ("msg", true)
            tname := safe_name ("type", true)

            io.put_string ("feature { COURIER, CONSUMER }%N%N")
            indent_to (1)
            io.put_string ("consume (")
            io.put_string (mname)
            io.put_string (" : ANY; ")
            io.put_string (tname)
            io.put_string (" : INTEGER) is %N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_dummy_valid_message_type is

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
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------

    generate_dummy_template is

        do
            indent_to (1)
            io.put_string ("template : CORBA_SERVER_REQUEST is%N%N")
            indent_to (2)
            io.put_string ("do%N")
            indent_to (2)
            io.put_string ("end%N%N")
        end
----------------------
feature -- Primitive methods

    root : STRING is
        -- Subdirctory where all classes generated by this
        -- visitor will be deposited.

        deferred
        ensure
            root_exists : fs.cluster_exists (result)
        end
----------------------

    is_a_stub : BOOLEAN is

        deferred
        end
----------------------

    is_a_skeleton : BOOLEAN is

        deferred
        end
----------------------

    is_an_implementation : BOOLEAN is

        deferred
        end
----------------------

    is_a_servant : BOOLEAN is

        deferred
        end
----------------------

    visitor_type : INTEGER is

        deferred
        end
----------------------

    standard_parent : STRING is
        -- Universal class from which all classes generated by this
        -- visitor will inherit.

        deferred
        end
----------------------

    generate_interface_inherit (in : INTERFACE) is

        deferred
        end
----------------------

    generate_interface_creators is

        deferred
        end
----------------------

    generate_interface_make (in : INTERFACE) is

        deferred
        end
----------------------


    interfaces_deferred : BOOLEAN is

        deferred
        end
----------------------

    class_name_suffix : STRING is

        deferred
        end
----------------------

    generate_attributes (ad : ATTR_DCL) is

        deferred
        end
----------------------

    generate_attribute_mutators (ad : ATTR_DCL) is

        deferred
        end
----------------------

    generate_attribute_accessors (ad : ATTR_DCL) is

        deferred
        end
----------------------

    generate_routine_body (od : OP_DCL) is

        deferred
        end
----------------------
feature -- Hooks

    generate_project_helper is

        do
        end
----------------------

    generate_consume is

        do
        end
----------------------

    generate_valid_message_type is

        do
        end
----------------------

    generate_template is

        do
        end
----------------------

    generate_dispatcher is

        do
        end
----------------------

    generate_undefines (extra : STRING) is

        deferred
        end
----------------------

    generate_array_make (name : STRING; dcl : ARRAY_DECLARATOR) is

        do
        end
----------------------

    generate_array_get_value (dcl : ARRAY_DECLARATOR) is

        do
        end
----------------------

    generate_array_set_value (dcl : ARRAY_DECLARATOR) is

        do
        end
----------------------

    generate_array_attribute (dcl : ARRAY_DECLARATOR) is

        do
        end
----------------------

    generate_sequence_make (name : STRING; type : SEQUENCE_TYPE) is

        do
        end
----------------------

    generate_sequence_get_value (type : SEQUENCE_TYPE) is

        do
        end
----------------------

    generate_sequence_set_value (type : SEQUENCE_TYPE) is

        do
        end
----------------------

    generate_sequence_attribute (type : SEQUENCE_TYPE) is

        do
        end
----------------------

    generate_sequence_length is

        do
        end
----------------------

    generate_enum_constants (et : ENUM_TYPE) is

        do
        end
----------------------

    generate_enum_make (et : ENUM_TYPE) is

        do
        end
----------------------

    generate_enum_set_value (et : ENUM_TYPE) is

        do
        end
----------------------

    generate_enum_get_value (et : ENUM_TYPE) is

        do
        end
----------------------

    generate_enum_attribute (et : ENUM_TYPE) is

        do
        end
----------------------

    generate_struct_make (st : STRUCT_TYPE) is

        do
        end
----------------------

    generate_except_make (ed : EXCEPT_DCL) is

        do
        end
----------------------

    generate_member_attributes (me : MEMBER) is

        do
        end
----------------------

    generate_member_mutators_and_accessors (me : MEMBER) is

        do
        end
----------------------

    generate_union_make (ut : UNION_TYPE) is

        do
        end
----------------------

    generate_union_set_value (ut : UNION_TYPE; defcase : INTEGER) is

        do
        end
----------------------

    generate_union_get_value (ut : UNION_TYPE; defcas : INTEGER) is

        do
        end
----------------------

    generate_union_set_default (ut : UNION_TYPE) is

        do
        end
----------------------

    generate_union_get_discriminator (ut : UNION_TYPE) is

        do
        end
----------------------

    generate_union_attribute (ut : UNION_TYPE; defcase : INTEGER) is

        do
        end
----------------------
feature -- Utilities

    frozen fmt : FORMAT is

        once
            create result
        end
----------------------

    frozen fs : FILE_SYSTEM is

        once
            create result.make
        end

end -- class EIFFEL_CODE_VISITOR

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
