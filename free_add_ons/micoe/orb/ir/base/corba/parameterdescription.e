class CORBA_PARAMETERDESCRIPTION
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER

creation
    make, make_default

feature

    make_default is

        do
        end

    make (name_val : STRING;
          type_val : CORBA_TYPECODE;
          type_def_val : CORBA_IDLTYPE;
          mode_val : CORBA_PARAMETERMODE) is

        do
            name := name_val
            type := type_val
            type_def := type_def_val
            mode := mode_val
        end

    name : STRING

    set_name (value : STRING) is

        do
            name := value
        end

    type : CORBA_TYPECODE

    set_type (value : CORBA_TYPECODE) is

        do
            type := value
        end

    type_def : CORBA_IDLTYPE

    set_type_def (value : CORBA_IDLTYPE) is

        do
            type_def := value
        end

    mode : CORBA_PARAMETERMODE

    set_mode (value : CORBA_PARAMETERMODE) is

        do
            mode := value
        end

    struct_to_any (ca : CORBA_ANY) is

        require
            nonvoid_arg : ca /= void

        local
            dum : BOOLEAN

        do
            dum := ca.struct_put_begin
            ca.put_string (name, 0)
            ca.put_typecode (type)
            ca.put_object ("IDLType", type_def)
            mode.enum_to_any (ca)
            ca.struct_put_end
        end

    struct_from_any (ca : CORBA_ANY) is

        require
            nonvoid_arg : ca /= void

        local
            dum : BOOLEAN
            o   : CORBA_OBJECT

        do
            dum := ca.struct_get_begin
            name := ca.get_string (0)
            type := ca.get_typecode
            o := ca.get_object ("IDLType")
            type_def := CORBA_IDLType_narrow (o)
            create mode.make_default
            mode.enum_from_any (ca)
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "ParameterDescription"
        end

end -- class CORBA_PARAMETERDESCRIPTION
