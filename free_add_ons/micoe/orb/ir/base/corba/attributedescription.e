class CORBA_ATTRIBUTEDESCRIPTION
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
          mode_val : CORBA_ATTRIBUTEMODE) is

        do
            name := name_val
            id := id_val
            defined_in := defined_in_val
            version := version_val
            type := type_val
            mode := mode_val
        end

    name : STRING

    set_name (value : STRING) is

        do
            name := value
        end

    id : STRING

    set_id (value : STRING) is

        do
            id := value
        end

    defined_in : STRING

    set_defined_in (value : STRING) is

        do
            defined_in := value
        end

    version : STRING

    set_version (value : STRING) is

        do
            version := value
        end

    type : CORBA_TYPECODE

    set_type (value : CORBA_TYPECODE) is

        do
            type := value
        end

    mode : CORBA_ATTRIBUTEMODE

    set_mode (value : CORBA_ATTRIBUTEMODE) is

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
            ca.put_string (id, 0)
            ca.put_string (defined_in, 0)
            ca.put_string (version, 0)
            ca.put_typecode (type)
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
            id := ca.get_string (0)
            defined_in := ca.get_string (0)
            version := ca.get_string (0)
            type := ca.get_typecode
            create mode.make_default
            mode.enum_from_any (ca)
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "AttributeDescription"
        end

end -- class CORBA_ATTRIBUTEDESCRIPTION
