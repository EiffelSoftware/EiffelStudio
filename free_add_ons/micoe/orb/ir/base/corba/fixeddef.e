deferred class CORBA_FIXEDDEF
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

    digits : INTEGER is

        deferred
        end

    set_digits (value : INTEGER) is

        deferred
        end

    scale : INTEGER is

        deferred
        end

    set_scale (value : INTEGER) is

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
            x4  : INTEGER

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
                x3 := digits
                ca.put_long (x3)
            when 5 then
                add_in_arg_integer ("val")
                dum := req.set_params (nvl)
                x4 := nvl.get_integer_value_by_name ("val")
                set_digits (x4)
            when 6 then
                x3 := scale
                ca.put_long (x3)
            when 7 then
                add_in_arg_integer ("val")
                dum := req.set_params (nvl)
                x4 := nvl.get_integer_value_by_name ("val")
                set_scale (x4)
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; idl_type : INTEGER) : BOOLEAN is

        do
            result := (1 <= idl_type and then idl_type <= 7)
            result := result and then msg.conforms_to (template)
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/FixedDef:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "FixedDef"
        end

end -- class CORBA_FIXEDDEF
