
indexing

description: "Special visitor for storing parse trees in the IR";
keywords: "IR", "Visitor Pattern";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class IR_VISITOR

inherit
    IR_CORBA_CONSTANTS;
    TYPECODE_CONSTANTS;
    SEMANTIC_VISITOR

creation
    make

feature -- Initialization

    make (repository : CORBA_REPOSITORY; rpref, gvers : STRING;
          repoids, versions : DICTIONARY [STRING, SCOPED_NAME]) is

        do
            current_repository := repository
            current_container  := repository
            create scope_stack.make
            create interfaces.make
            create ctypes.make
            create csizes.make
            create integer_values.make
            create real_values.make
            init_types
            repoid_prefix  := rpref
            global_version := gvers
            user_repoids   := repoids
            local_versions := versions
        end
----------------------
feature { NONE }

    unalias (sp : SPECIFICATION) is

        local
            tuv : TYPEDEF_UNWINDING_VISITOR
            tcv : TYPECODE_VISITOR

        do
            create tuv.make
            create tcv.make (global_version, repoid_prefix,
                             user_repoids, local_versions)
            sp.accept (tuv)
            sp.accept (tcv)
            tuv.finish
--            enums      := tuv.enums
--            structs    := tuv.structs
--            unions     := tuv.unions
--            sequences  := tuv.sequences
--            arrays     := tuv.arrays
--            exceptions := tuv.exceptions
--            typedefs   := tuv.typedefs

--        ensure
--            complex_types_known : complex_types_known
        end
----------------------
feature

    visit_specification (sp : SPECIFICATION) is

        local
            i, n : INTEGER

        do
            unalias (sp)

            from
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
feature { ABSTRACT_SYNTAX_ELEMENT }

    visit_module (mo : MODULE) is

        local
            i, n    : INTEGER
            repoid  : STRING
            name    : STRING
            version : STRING

        do
            scope_stack.add (current_container)
            repoid  := scoped_name_to_repoid (mo.name)
            name    := mo.name.last_name_component
            version := scoped_name_to_version (mo.name)
            current_container := current_container.create_module (repoid,
                                                                  name,
                                                                  version)
            from
                i     := 1
                n     := mo.component_count
            until
                i > n
            loop
                mo.component_at(i).accept (current)
                i := i + 1
            end

            check
                not_top_level : not scope_stack.empty
            end
            current_container := scope_stack.item
            scope_stack.remove
        end
----------------------

    visit_interface (in : INTERFACE) is

        local
            i, n            : INTEGER
            repoid          : STRING
            name            : STRING
            pid             : STRING
            version         : STRING
            id              : CORBA_INTERFACEDEF
            base_interfaces : CORBA_INTERFACEDEFSEQ

        do
            scope_stack.add (current_container)
            repoid  := scoped_name_to_repoid (in.name)
            name    := in.name.last_name_component
            version := scoped_name_to_version (in.name)

            if in.parent_count > 0 then
                from
                    create base_interfaces.make_default
                    i := 1
                    n := in.parent_count
                until
                    i > n
                loop
                    pid := scoped_name_to_repoid (in.parent_at (i))
                        -- XXX What do we do about forward
                        -- references here?
                    if interfaces.has (pid) then
                        base_interfaces.set_value (interfaces.at (pid), i)
                    end
                    i := i + 1
                end
            end

            id := current_container.create_interface (repoid,
                                                      name,
                                                      version,
                                                      base_interfaces,
                                                      false)

            interfaces.put (id, repoid)
            types.put (id, repoid)
            current_container := id
            current_interface := id

            from
                i := 1
                n := in.component_count
            until
                i > n
            loop
                in.component_at (i).accept(current)
                i := i + 1
            end

            check
                not_top_level : not scope_stack.empty
            end
            current_container := scope_stack.item
            current_interface := void
            scope_stack.remove 
        end
----------------------

    visit_value (va : VALUE) is

        do
        end
----------------------

    visit_init_dcl (id : INIT_DCL) is

        do
        end
----------------------

    visit_init_param_dcl (ipd : INIT_PARAM_DCL) is

        do
        end
----------------------

    visit_state_member (sm : STATE_MEMBER) is

        do
        end
----------------------

    visit_const_dcl (cd : CONST_DCL) is

        local
            repoid  : STRING
            name    : STRING
            version : STRING
            tid     : STRING
            type    : CORBA_IDLTYPE
            value   : CORBA_ANY
            dummy   : CORBA_CONSTANTDEF


        do
            tid     := typecode_to_id (cd.const_type.typecode)
            if types.has (tid) then
                type := types.at (tid)
            end

            repoid  := scoped_name_to_repoid (cd.name)
            name    := cd.name.last_name_component
            version := scoped_name_to_version (cd.name)
            value   := evaluate_const_exp (tid, cd.name, cd.const_exp)
            dummy := current_container.create_constant (repoid,
                                                        name,
                                                        version,
                                                        type,
                                                        value)
        end
----------------------

    visit_except_dcl (ed : EXCEPT_DCL) is

        local
            i, n    : INTEGER
            repoid  : STRING
            name    : STRING
            version : STRING
            dummy   : CORBA_EXCEPTIONDEF

        do
            create smembers.make_default
            repoid  := scoped_name_to_repoid (ed.name)
            name    := ed.name.last_name_component
            version := scoped_name_to_version (ed.name)
            sindex  := 1

            from
                i := 1
                n := ed.component_count
            until
                i > n
            loop
                ed.component_at (i).accept (current)
                i := i + 1
            end
            dummy := current_container.create_exception (repoid,
                                                         name,
                                                         version,
                                                         smembers)
        end
----------------------

    visit_attr_dcl (ad : ATTR_DCL) is

        local
            i, n    : INTEGER
            tid     : STRING
            repoid  : STRING
            name    : STRING
            version : STRING
            type    : CORBA_IDLTYPE
            mode    : CORBA_ATTRIBUTEMODE
            dummy   : CORBA_ATTRIBUTEDEF

        do
            if ad.is_readonly then

            end
            tid := typecode_to_id (ad.param_type_spec.typecode)
            if types.has (tid) then
                type := types.at (tid)
            end
            if ad.is_readonly then
                create mode.make (CORBA_attr_readonly)
            else
                create mode.make (CORBA_attr_normal)
            end

            from
                i := 1
                n := ad.component_count
            until
                i > n
            loop
                name := ad.component_at (i).identifier
                dummy := current_interface.create_attribute (repoid,
                                                             name,
                                                             version,
                                                             type,
                                                             mode)
                i := i + 1
            end
        end
----------------------

    visit_op_dcl (od : OP_DCL) is

        local
            i, n : INTEGER

        do
            from
                if od.oneway then

                 end
                 od.op_type_spec.accept (current)
                 i := 1
                 n := od.component_count
            until
                i > n
            loop
                od.component_at (i).accept (current)
                i := i + 1
            end
            if od.raises_expr /= void then
                od.raises_expr.accept (current)
            end

            if od.context_expr /= void then
                od.context_expr.accept (current)
            end
        end
----------------------

    visit_param_dcl (pd : PARAM_DCL) is

        do
            pd.param_type_spec.accept (current)
        end
----------------------

    visit_raises_expr (exp : RAISES_EXPR) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept (current)
                i := i + 1
            end
        end
----------------------

    visit_context_expr (exp : CONTEXT_EXPR) is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := exp.component_count
            until
                i > n
            loop
                exp.component_at (i).accept (current)
                i := i + 1
            end
        end
----------------------

    visit_scoped_name (sn : SCOPED_NAME) is

        local
            i, n : INTEGER

        do
            from
                if sn.initial_doublecolon then
                end
                i := 1
                n := sn.name_component_count
                if i <= n then
                    i := i + 1
                end
            until
                i > n
            loop
                i := i + 1
            end
        end
----------------------

    visit_union_type (ut : UNION_TYPE) is

        local
            i, n    : INTEGER
            repoid  : STRING
            name    : STRING
            version : STRING
            disc    : STRING
            type    : CORBA_IDLTYPE
            dummy   : CORBA_UNIONDEF

        do
            create umembers.make_default
            repoid  := scoped_name_to_repoid (ut.name)
            name    := ut.name.last_name_component
            version := scoped_name_to_version (ut.name)
            uindex  := 1

            from
                i := 1
                n := ut.component_count
            until
                i > n
            loop
                ut.component_at (i).accept (current)
                i := i + 1
            end
            disc := typecode_to_id (ut.switch_type_spec.typecode)
            if types.has (disc) then
                type := types.at (disc)
            end
            dummy := current_container.create_union (repoid,
                                                     name,
                                                     version,
                                                     type,
                                                     umembers)
            types.put (dummy, ut.typecode.id)
        end
----------------------

    visit_case (ca : CASE) is

        local
            i, n     : INTEGER
            name     : STRING
            tid      : STRING
            type     : CORBA_TYPECODE
            type_def : CORBA_IDLTYPE
            um       : CORBA_UNIONMEMBER
            label    : CORBA_ANY
            cl       : CASE_LABEL

        do
            type := ca.element_spec.type_spec.typecode
            name := ca.element_spec.declarator.name.last_name_component
            tid  := typecode_to_id (type)
            if types.has (tid) then
                type_def := types.at (tid)
            end
            from
                i := 1
                n := ca.component_count
            until
                i > n
            loop
                cl := ca.component_at (i)
                if not cl.is_default then
                    label := evaluate_const_exp (tid, void, cl.const_exp)
                end
                create um.make (name, label, type, type_def)
                umembers.set_value (um, uindex)
                uindex := uindex + 1
                i      := i + 1
            end
            ca.element_spec.accept (current)
        end
----------------------

    visit_case_label (cl : CASE_LABEL) is

        do
        end
----------------------

    visit_element_spec (es : ELEMENT_SPEC) is

        do
            es.type_spec.accept (current)
            es.declarator.accept (current)
        end
----------------------

    visit_struct_type (st : STRUCT_TYPE) is

        local
            i, n    : INTEGER
            repoid  : STRING
            name    : STRING
            version : STRING
            dummy   : CORBA_STRUCTDEF

        do
            create smembers.make_default
            repoid  := scoped_name_to_repoid (st.name)
            name    := st.name.last_name_component
            version := scoped_name_to_version (st.name)
            sindex  := 1

            from
                i := 1
                n := st.component_count
            until
                i > n
            loop
                st.component_at (i).accept (current)
                i := i + 1
            end
            dummy := current_container.create_struct (repoid,
                                                      name,
                                                      version,
                                                      smembers)
            types.put (dummy, st.typecode.id)
        end
----------------------

    visit_member (me : MEMBER) is

        local
            i, n     : INTEGER
            sm       : CORBA_STRUCTMEMBER
            name     : STRING
            tid      : STRING
            type     : CORBA_TYPECODE
            type_def : CORBA_IDLTYPE

        do
            from
                type := me.type_spec.typecode
                tid  := typecode_to_id (type)
                if types.has (tid) then
                    type_def := types.at (tid)
                end
                i := 1
                n := me.component_count
            until
                i > n
            loop
                name := me.component_at (i).name.last_name_component
                create sm.make (name, type, type_def)
                smembers.set_value (sm, sindex)
                sindex := sindex + 1
                i      := i + 1
            end
        end
----------------------

    visit_enum_type (et : ENUM_TYPE) is

        local
            i, n : INTEGER
            repoid  : STRING
            name    : STRING
            version : STRING
            members : CORBA_ENUMMEMBERSEQ
            dummy   : CORBA_ENUMDEF

        do
            repoid  := scoped_name_to_repoid (et.name)
            name    := et.name.last_name_component
            version := scoped_name_to_version (et.name)
            create members.make_default

            from
                i := 1
                n := et.enumerator_count
            until
                i > n
            loop
                members.set_value (et.enumerator_at (i), i)
                i := i + 1
            end
            dummy := current_container.create_enum (repoid,
                                                    name,
                                                    version,
                                                    members)
        end
----------------------

    visit_native_type (nt : NATIVE_TYPE) is

        do
            nt.simple_declarator.accept (current)
        end
----------------------

    visit_typedef_type (tt : TYPEDEF_TYPE) is

        local
            i, n    : INTEGER
            decl    : IDL_DECLARATOR
            repoid  : STRING
            name    : STRING
            version : STRING
            tid     : STRING
            st      : SEQUENCE_TYPE
            str     : STRING_TYPE
            adcl    : ARRAY_DECLARATOR
            otype   : CORBA_IDLTYPE
            dummy   : CORBA_ALIASDEF

        do
            tid  := scoped_name_to_repoid (tt.aliased)
            st   ?= tt.type_spec
            str  ?= tt.type_spec
            adcl ?= tt.type_spec
            if types.has (tid) then
                otype := types.at (tid)
            elseif st /= void then
                otype := build_sequencedef (st)
            elseif str /= void then
                otype := build_stringdef (str)
            elseif adcl /= void then
                otype := build_arraydef (adcl)
            end
            from
                tt.type_spec.accept (current)
                i := 1
                n := tt.component_count
            until
                i > n
            loop
                decl    := tt.component_at (i)
                repoid  := scoped_name_to_repoid (decl.name)
                name    := decl.name.last_name_component
                version := scoped_name_to_version (decl.name)
                dummy   := current_container.create_alias (repoid,
                                                           name,
                                                           version,
                                                           otype)
                types.put (dummy, repoid)
                i := i + 1
            end
        end
----------------------

    visit_simple_declarator (dcl : SIMPLE_DECLARATOR) is

        do
        end
----------------------

    visit_array_declarator (dcl : ARRAY_DECLARATOR) is

        local
            i, n : INTEGER
        do
            from
                i := 1
                n := dcl.size_count
            until
                i > n
            loop
                i := i + 1
            end
        end
----------------------

    visit_or_expr (exp : OR_EXPR) is

        do
        end
----------------------

    visit_xor_expr (exp : XOR_EXPR) is

        do
        end
----------------------

    visit_and_expr (exp : AND_EXPR) is

        do
        end
----------------------

    visit_shift_expr (exp : SHIFT_EXPR) is

        do
        end
----------------------

    visit_add_expr (exp : ADD_EXPR) is

        do
        end
----------------------

    visit_mult_expr (exp: MULT_EXPR) is

        do
        end
----------------------

    visit_unary_expr (exp : UNARY_EXPR) is

        do
        end
----------------------

    visit_integer_literal (lit : INTEGER_LITERAL) is

        do
        end
----------------------

    visit_string_literal (lit : STRING_LITERAL) is

        do
        end
----------------------

    visit_wide_string_literal (lit : WIDE_STRING_LITERAL) is

        do
            -- Still to be implemented.
        end
----------------------

    visit_real_literal (lit : REAL_LITERAL) is

        do
        end
----------------------

    visit_character_literal (lit : CHARACTER_LITERAL) is

        do
        end
----------------------

    visit_wide_character_literal (lit : WIDE_CHARACTER_LITERAL) is

        do
            -- Still to be implemented.
        end
----------------------

    visit_boolean_literal (lit : BOOLEAN_LITERAL) is

        do
        end
----------------------

    visit_any_type (type : ANY_TYPE) is

        do
        end
----------------------

    visit_boolean_type (type : BOOLEAN_TYPE) is

        do
        end
----------------------

    visit_char_type (type : CHAR_TYPE) is

        do
        end
----------------------

    visit_integer_type (type : INTEGER_TYPE) is

        do
            if type.unsigned then
            end
            if type.short then
            elseif type.longlong then
            else
            end
        end
----------------------

    visit_floating_pt_type (type : FLOATING_PT_TYPE) is

        do
            if type.is_double then
                if type.long then
                end
            else
            end
        end
----------------------

    visit_fixed_pt_type (type : FIXED_PT_TYPE) is

        do
        end
----------------------

    visit_string_type (type : STRING_TYPE) is

        do
        end
----------------------

    visit_wide_string_type (type : WIDE_STRING_TYPE) is

        do
        end
----------------------

    visit_octet_type (type : OCTET_TYPE) is

        do
        end
----------------------

    visit_wide_char_type (type : WIDE_CHAR_TYPE) is

        do
        end
----------------------

    visit_void_type (type : VOID_TYPE) is

        do
        end
----------------------

    visit_sequence_type (type : SEQUENCE_TYPE) is

        local
            tid  : STRING
            name : STRING
            tdef : CORBA_IDLTYPE
            dum  : CORBA_SEQUENCEDEF

        do
            tid := typecode_to_id (type.simple_type_spec.typecode)
            if types.has (tid) then
                tdef := types.at (tid)
            end
            dum := current_repository.create_sequence (type.length, tdef)
            name := scoped_name_to_repoid (type.name)
            types.put (dum, name)
        end
----------------------
feature { NONE }

    id_prefix : STRING is "IDL:"

    scope_stack        : STACK [CORBA_CONTAINER]
    user_repoids       : DICTIONARY [STRING, SCOPED_NAME]
    local_versions     : DICTIONARY [STRING, SCOPED_NAME]
    repoid_prefix      : STRING
    global_version     : STRING
    interfaces         : DICTIONARY [CORBA_INTERFACEDEF, STRING]
    smembers           : CORBA_STRUCTMEMBERSEQ
    sindex             : INTEGER
        -- Index at which to put next STRUCTMEMBER
    umembers           : CORBA_UNIONMEMBERSEQ
    uindex             : INTEGER
        -- Index at which to put next UNIONMEMBER
    types              : DICTIONARY [CORBA_IDLTYPE, STRING]
    current_container  : CORBA_CONTAINER
    current_repository : CORBA_REPOSITORY
    current_interface  : CORBA_INTERFACEDEF
    ctypes             : DICTIONARY [CHARACTER, SCOPED_NAME]
        -- Used to record types of named constants (`r' or 'i')
    csizes             : DICTIONARY [INTEGER, SCOPED_NAME]
        --Used to record sizes in octets of named constants
    integer_values : DICTIONARY [INTEGER, SCOPED_NAME]
        -- Used to record the integer values of scoped names.
    real_values : DICTIONARY [DOUBLE, SCOPED_NAME]
        -- Used to record the real values of scoped names.
----------------------

    build_primitivedef (bts : BASE_TYPE_SPEC) : CORBA_PRIMITIVEDEF is

        local
            it  : INTEGER_TYPE
            fpt : FLOATING_PT_TYPE
            bt  : BOOLEAN_TYPE
            ct  : CHAR_TYPE
            at  : ANY_TYPE
            ot  : OCTET_TYPE
            wt  : WIDE_CHAR_TYPE
            pk  : CORBA_PRIMITIVEKIND

        do
            it ?= bts
            if it /= void then
                if it.short then
                    if it.unsigned then
                        create pk.make (CORBA_pk_ushort)
                    else
                        create pk.make (CORBA_pk_short)
                    end
                elseif it.longlong then
                    if it.unsigned then
                        create pk.make (CORBA_pk_ulonglong)
                    else
                        create pk.make (CORBA_pk_longlong)
                    end
                else -- it's long
                    if it.unsigned then
                        create pk.make (CORBA_pk_ulong)
                    else
                        create pk.make (CORBA_pk_long)
                    end
                end -- if it.short then ...
            end -- if it /= void then ...
            if pk = void then
                fpt ?= bts
                if fpt /= void then
                    if fpt.is_double then
                        create pk.make (CORBA_pk_double)
                    elseif fpt.long then
                        create pk.make (CORBA_pk_longdouble)
                    else -- it's float
                        create pk.make (CORBA_pk_float)
                    end
                end -- if fpt /= void then ...
            end -- if pk = void then ...
            if pk = void then
                bt ?= bts
                if bt /= void then
                    create pk.make (CORBA_pk_boolean)
                end -- if bt /= void then ...
            end -- if pk = void then ...
            if pk = void then
                ct ?= bts
                if ct /= void then
                    create pk.make (CORBA_pk_char)
                end -- if ct /= void then ...
            end -- if pk = void then ...
            if pk = void then
                ot ?= bts
                if ot /= void then
                    create pk.make (CORBA_pk_octet)
                end -- if ot /= void then ...
            end -- if pk = void then ...
            if pk = void then
                at ?= bts
                if at /= void then
                    create pk.make (CORBA_pk_any)
                end -- if at /= void then ...
            end -- if pk = void then ...
            if pk = void then
                wt ?= bts
                if wt /= void then
                    create pk.make (CORBA_pk_wchar)
                end -- if wt /= void then ...
            end -- if pk = void then ...
            result := current_repository.get_primitive (pk)
        end
----------------------

    build_sequencedef (st : SEQUENCE_TYPE) : CORBA_SEQUENCEDEF is

        local
            bound : INTEGER
            etype : CORBA_IDLTYPE
            sn    : SCOPED_NAME
            bts   : BASE_TYPE_SPEC
            tid   : STRING

        do
            sn     ?= st.simple_type_spec
            bts    ?= st.simple_type_spec
            if bts /= void then
               etype := build_primitivedef (bts)
            elseif sn /= void then
               tid := scoped_name_to_repoid (sn)
                if types.has (tid) then
                    etype := types.at (tid)
                end
            end
            bound  := st.length
            result := current_repository.create_sequence (bound, etype)
        end
----------------------

    build_stringdef (st : STRING_TYPE) : CORBA_STRINGDEF is

        do
            result := current_repository.create_string (st.length)
        end
----------------------

    build_arraydef (adcl : ARRAY_DECLARATOR) : CORBA_ARRAYDEF is

        local
            length : INTEGER
            etype  : CORBA_IDLTYPE

        do
            -- compute `length' and `etype' from `adcl'
            result := current_repository.create_array (length, etype)
        end
----------------------

    evaluate_const_exp (tid : STRING;
                        name : SCOPED_NAME;
                        exp : CONST_EXP) : CORBA_ANY is

        local
            tcov : TYPE_COMPUTING_VISITOR
            iev  : INTEGER_EVALUATION_VISITOR
            rev  : REAL_EVALUATION_VISITOR
            cl   : CHARACTER_LITERAL
            sl   : STRING_LITERAL
        do
            create tcov
            tcov.set_types (ctypes, csizes)
            exp.accept (tcov)

            if tcov.type /= 'x' and then name /= void then
                ctypes.put (tcov.type, name)
                csizes.put (tcov.size, name)
            end

            -- Now unwind constant expression

            inspect tcov.type

            when 'i' then
                create iev
                iev.set_values (integer_values)
                exp.accept (iev)
                if name /= void then
                    integer_values.put (iev.value, name)
                end
                create result.make
                result.put_long (iev.value)

            when 'r' then
                create rev
                rev.set_real_values (real_values)
                rev.set_integer_values (integer_values)
                exp.accept (rev)
                if name /= void then
                    real_values.put (rev.value, name)
                end
                create result.make
                result.put_double (rev.value)

            when 'c' then
                cl ?= exp
                check
                    matching_type : equal (tid, "char")
                    is_literal    : cl /= void                            
                end
                create result.make
                result.put_char (cl.value)

            when 's' then
                sl ?= exp
                check
                    matching_type : equal (tid, "string")
                    is_literal    : sl /= void
                end
                create result.make
                result.put_string (sl.value, 0)

            else
                -- some non-descript type; forget it!
            end
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
                result.append (scoped_name_to_version (name))
            end -- if user_repoids.has (name) then ...
        end
----------------------

    scoped_name_to_version (name : SCOPED_NAME) : STRING is

        do
            if local_versions /= void and then
               local_versions.has (name)  then
                result := local_versions.at (name)
            else
                result := global_version
            end
        end
----------------------

    typecode_to_id (tc : CORBA_TYPECODE) : STRING is

        do
            inspect tc.kind

            when Tk_struct, Tk_except, Tk_union,
                 Tk_enum, Tk_alias, Tk_objref then
                result := tc.id

            when Tk_void then
                result := "void"

            when Tk_short then
                result := "short"

            when Tk_long then
                result := "long"

            when Tk_ushort then
                result := "ushort"

            when Tk_ulong then
                result := "ulong"

            when Tk_longlong then
                result := "longlong"

            when Tk_ulonglong then
                result := "ulonglong"

            when Tk_float then
                result := "float"

            when Tk_double then
                result := "double"

            when Tk_longdouble then
                result := "longdouble"

            when Tk_boolean then
                result := "boolean"

            when Tk_char then
                result := "char"

            when Tk_octet then
                result := "octet"

            when Tk_any then
                result := "any"

            when Tk_typecode then
                result := "typecode"

            when Tk_principal then
                result := "principal"

            when Tk_string then
                result := "string"

            when Tk_wchar then
                result := "wchar"

            when Tk_wstring then
                result := "wstring"

            else -- Tk_value_base doesn't exist yet ...
                result := "value_base"

            end
        end
----------------------

    init_types is

        local
            repos : CORBA_REPOSITORY
            pk    : CORBA_PRIMITIVEKIND

        do
            repos ?= current_container
            check
                top_level : repos /= void
            end
            create types.make
            create pk.make (CORBA_pk_void)
            types.put (repos.get_primitive (pk), "void")
            pk.set_value (CORBA_pk_short)
            types.put (repos.get_primitive (pk), "short")
            pk.set_value (CORBA_pk_long)
            types.put (repos.get_primitive (pk), "long")
            pk.set_value (CORBA_pk_ushort)
            types.put (repos.get_primitive (pk), "ushort")
            pk.set_value (CORBA_pk_ulong)
            types.put (repos.get_primitive (pk), "ulong")
            pk.set_value (CORBA_pk_float)
            types.put (repos.get_primitive (pk), "float")
            pk.set_value (CORBA_pk_double)
            types.put (repos.get_primitive (pk), "double")
            pk.set_value (CORBA_pk_boolean)
            types.put (repos.get_primitive (pk), "boolean")
            pk.set_value (CORBA_pk_char)
            types.put (repos.get_primitive (pk), "char")
            pk.set_value (CORBA_pk_octet)
            types.put (repos.get_primitive (pk), "octet")
            pk.set_value (CORBA_pk_any)
            types.put (repos.get_primitive (pk), "any")
            pk.set_value (CORBA_pk_typecode)
            types.put (repos.get_primitive (pk), "typecode")
            pk.set_value (CORBA_pk_principal)
            types.put (repos.get_primitive (pk), "principal")
            pk.set_value (CORBA_pk_string)
            types.put (repos.get_primitive (pk), "string")
            pk.set_value (CORBA_pk_longlong)
            types.put (repos.get_primitive (pk), "longlong")
            pk.set_value (CORBA_pk_ulonglong)
            types.put (repos.get_primitive (pk), "ulonglong")
            pk.set_value (CORBA_pk_longdouble)
            types.put (repos.get_primitive (pk), "longdouble")
            pk.set_value (CORBA_pk_wchar)
            types.put (repos.get_primitive (pk), "wchar")
            pk.set_value (CORBA_pk_wstring)
            types.put (repos.get_primitive (pk), "wstring")
            pk.set_value (CORBA_pk_value_base)
            types.put (repos.get_primitive (pk), "value_base")
        end

end -- class IR_VISITOR

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
