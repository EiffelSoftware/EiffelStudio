class CORBA_INTERFACEDEF_FULLINTERFACEDESCRIPTION
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
          operations_val : CORBA_OPDESCRIPTIONSEQ;
          attributes_val : CORBA_ATTRDESCRIPTIONSEQ;
          base_interfaces_val : CORBA_REPOSITORYIDSEQ;
          type_val : CORBA_TYPECODE;
          is_abstract_val : BOOLEAN) is

        do
            name := name_val
            id := id_val
            defined_in := defined_in_val
            version := version_val
            operations := operations_val
            attributes := attributes_val
            base_interfaces := base_interfaces_val
            type := type_val
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

    operations : CORBA_OPDESCRIPTIONSEQ

    set_operations (value : CORBA_OPDESCRIPTIONSEQ) is

        do
            operations := value
        end

    attributes : CORBA_ATTRDESCRIPTIONSEQ

    set_attributes (value : CORBA_ATTRDESCRIPTIONSEQ) is

        do
            attributes := value
        end

    base_interfaces : CORBA_REPOSITORYIDSEQ

    set_base_interfaces (value : CORBA_REPOSITORYIDSEQ) is

        do
            base_interfaces := value
        end

    type : CORBA_TYPECODE

    set_type (value : CORBA_TYPECODE) is

        do
            type := value
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
            operations.sequence_to_any (ca)
            attributes.sequence_to_any (ca)
            base_interfaces.sequence_to_any (ca)
            ca.put_typecode (type)
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
            create operations.make_default
            operations.sequence_from_any (ca)
            create attributes.make_default
            attributes.sequence_from_any (ca)
            create base_interfaces.make_default
            base_interfaces.sequence_from_any (ca)
            type := ca.get_typecode
            is_abstract := ca.get_boolean
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "FullInterfaceDescription"
        end

end -- class CORBA_INTERFACEDEF_FULLINTERFACEDESCRIPTION
