class CORBA_CONSTANTDESCRIPTION
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
          id_val : STRING;
          defined_in_val : STRING;
          version_val : STRING;
          type_val : CORBA_TYPECODE;
          value_val : CORBA_ANY) is

        do
            name := name_val
            id := id_val
            defined_in := defined_in_val
            version := version_val
            type := type_val
            value := value_val
        end

    name : STRING

    set_name (idl_value : STRING) is

        do
            name := idl_value
        end

    id : STRING

    set_id (idl_value : STRING) is

        do
            id := idl_value
        end

    defined_in : STRING

    set_defined_in (idl_value : STRING) is

        do
            defined_in := idl_value
        end

    version : STRING

    set_version (idl_value : STRING) is

        do
            version := idl_value
        end

    type : CORBA_TYPECODE

    set_type (idl_value : CORBA_TYPECODE) is

        do
            type := idl_value
        end

    value : CORBA_ANY

    set_value (idl_value : CORBA_ANY) is

        do
            value := idl_value
        end

    struct_to_any (ca : CORBA_ANY) is

        require
            nonvoid_arg : ca /= void

        local
            dum : BOOLEAN

        do
            dum := ca.struct_put_begin
            ca.put_string (name, 0)
            ca.put_string (id, 0)
            ca.put_string (defined_in, 0)
            ca.put_string (version, 0)
            ca.put_typecode (type)
            ca.put_any (value)
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
            id := ca.get_string (0)
            defined_in := ca.get_string (0)
            version := ca.get_string (0)
            type := ca.get_typecode
            value := ca.get_any
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "ConstantDescription"
        end

end -- class CORBA_CONSTANTDESCRIPTION
