deferred class CORBA_ARRAYDEF
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_CORBA_CONSTANTS
        undefine
            copy, is_equal
        end;
    IR_HELPER
        undefine
            copy, is_equal
        end;
    CORBA_IDLTYPE
        redefine
            repoid, type_name, consume, valid_message_type
        end
feature

    length : INTEGER is

        deferred
        end

    set_length (value : INTEGER) is

        deferred
        end

    element_type : CORBA_TYPECODE is

        deferred
        end

    element_type_def : CORBA_IDLTYPE is

        deferred
        end

    set_element_type_def (value : CORBA_IDLTYPE) is

        deferred
        end


feature { COURIER, CONSUMER }

    consume (msg : ANY; idl_type : INTEGER) is 

        local
            req : CORBA_SERVER_REQUEST
            ca  : CORBA_ANY
            o   : CORBA_OBJECT
            dum : BOOLEAN
            x1  : CORBA_DEFINITIONKIND
            x2  : CORBA_TYPECODE
            x3  : INTEGER
            x4  : CORBA_IDLTYPE
            x5  : INTEGER
            x6  : CORBA_IDLTYPE

        do
            req ?= msg
            create ca.make
            req.mico_set_result (ca)
            begin_invoke

            inspect idl_type

            when 1 then
                destroy
            when 2 then
                x1 := def_kind
                ca.make1 (corba_definitionkind_tc)
                x1.enum_to_any (ca)
            when 3 then
                x2 := type
                ca.put_typecode (x2)
            when 4 then
                x3 := length
                ca.put_long (x3)
            when 5 then
                add_in_arg_integer ("val")
                dum := req.set_params (nvl)
                x5 := nvl.get_integer_value_by_name ("val")
                set_length (x5)
            when 6 then
                x2 := element_type
                ca.put_typecode (x2)
            when 7 then
                x4 := element_type_def
                ca.put_object ("corba_idltype", x4)
            when 8 then
                add_in_arg_ref ("val")
                dum := req.set_params (nvl)
                o := nvl.get_ref_value_by_name ("IDLType", "val")
                x6 := CORBA_IDLType_narrow (o)
                set_element_type_def (x6)
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; idl_type : INTEGER) : BOOLEAN is

        do
            result := (1 <= idl_type and then idl_type <= 8)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/ArrayDef:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "ArrayDef"
        end

end -- class CORBA_ARRAYDEF
