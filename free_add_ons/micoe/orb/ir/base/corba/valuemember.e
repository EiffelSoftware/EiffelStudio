class CORBA_VALUEMEMBER
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
          type_def_val : CORBA_IDLTYPE;
          access_val : INTEGER) is

        do
            name := name_val
            id := id_val
            defined_in := defined_in_val
            version := version_val
            type := type_val
            type_def := type_def_val
            access := access_val
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

    type_def : CORBA_IDLTYPE

    set_type_def (value : CORBA_IDLTYPE) is

        do
            type_def := value
        end

    access : INTEGER

    set_access (value : INTEGER) is

        do
            access := value
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
            ca.put_object ("IDLType", type_def)
            ca.put_short (access)
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
            o := ca.get_object ("IDLType")
            type_def := CORBA_IDLType_narrow (o)
            access := ca.get_short
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "ValueMember"
        end

end -- class CORBA_VALUEMEMBER
