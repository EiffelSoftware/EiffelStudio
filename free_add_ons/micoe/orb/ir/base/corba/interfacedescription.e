class CORBA_INTERFACEDESCRIPTION
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
          base_interfaces_val : CORBA_REPOSITORYIDSEQ;
          is_abstract_val : BOOLEAN) is

        do
            name := name_val
            id := id_val
            defined_in := defined_in_val
            version := version_val
            base_interfaces := base_interfaces_val
            is_abstract := is_abstract_val
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

    base_interfaces : CORBA_REPOSITORYIDSEQ

    set_base_interfaces (value : CORBA_REPOSITORYIDSEQ) is

        do
            base_interfaces := value
        end

    is_abstract : BOOLEAN

    set_is_abstract (value : BOOLEAN) is

        do
            is_abstract := value
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
            base_interfaces.sequence_to_any (ca)
            ca.put_boolean (is_abstract)
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
            create base_interfaces.make_default
            base_interfaces.sequence_from_any (ca)
            is_abstract := ca.get_boolean
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "InterfaceDescription"
        end

end -- class CORBA_INTERFACEDESCRIPTION
