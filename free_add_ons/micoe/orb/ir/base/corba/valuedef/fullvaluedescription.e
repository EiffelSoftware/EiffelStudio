class CORBA_VALUEDEF_FULLVALUEDESCRIPTION
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
          is_abstract_val : BOOLEAN;
          is_custom_val : BOOLEAN;
          defined_in_val : STRING;
          version_val : STRING;
          operationsl_val : CORBA_OPDESCRIPTIONSEQ;
          attributes_val : CORBA_ATTRDESCRIPTIONSEQ;
          members_val : CORBA_VALUEMEMBERSEQ;
          initializers_val : CORBA_INITIALIZERSEQ;
          supported_interfaces_val : CORBA_REPOSITORYIDSEQ;
          abstract_base_values_val : CORBA_REPOSITORYIDSEQ;
          is_truncatable_val : BOOLEAN;
          base_value_val : STRING;
          type_val : CORBA_TYPECODE) is

        do
            name := name_val
            id := id_val
            is_abstract := is_abstract_val
            is_custom := is_custom_val
            defined_in := defined_in_val
            version := version_val
            operationsl := operationsl_val
            attributes := attributes_val
            members := members_val
            initializers := initializers_val
            supported_interfaces := supported_interfaces_val
            abstract_base_values := abstract_base_values_val
            is_truncatable := is_truncatable_val
            base_value := base_value_val
            type := type_val
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

    is_abstract : BOOLEAN

    set_is_abstract (value : BOOLEAN) is

        do
            is_abstract := value
        end

    is_custom : BOOLEAN

    set_is_custom (value : BOOLEAN) is

        do
            is_custom := value
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

    operationsl : CORBA_OPDESCRIPTIONSEQ

    set_operationsl (value : CORBA_OPDESCRIPTIONSEQ) is

        do
            operationsl := value
        end

    attributes : CORBA_ATTRDESCRIPTIONSEQ

    set_attributes (value : CORBA_ATTRDESCRIPTIONSEQ) is

        do
            attributes := value
        end

    members : CORBA_VALUEMEMBERSEQ

    set_members (value : CORBA_VALUEMEMBERSEQ) is

        do
            members := value
        end

    initializers : CORBA_INITIALIZERSEQ

    set_initializers (value : CORBA_INITIALIZERSEQ) is

        do
            initializers := value
        end

    supported_interfaces : CORBA_REPOSITORYIDSEQ

    set_supported_interfaces (value : CORBA_REPOSITORYIDSEQ) is

        do
            supported_interfaces := value
        end

    abstract_base_values : CORBA_REPOSITORYIDSEQ

    set_abstract_base_values (value : CORBA_REPOSITORYIDSEQ) is

        do
            abstract_base_values := value
        end

    is_truncatable : BOOLEAN

    set_is_truncatable (value : BOOLEAN) is

        do
            is_truncatable := value
        end

    base_value : STRING

    set_base_value (value : STRING) is

        do
            base_value := value
        end

    type : CORBA_TYPECODE

    set_type (value : CORBA_TYPECODE) is

        do
            type := value
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
            ca.put_boolean (is_abstract)
            ca.put_boolean (is_custom)
            ca.put_string (defined_in, 0)
            ca.put_string (version, 0)
            operationsl.sequence_to_any (ca)
            attributes.sequence_to_any (ca)
            members.sequence_to_any (ca)
            initializers.sequence_to_any (ca)
            supported_interfaces.sequence_to_any (ca)
            abstract_base_values.sequence_to_any (ca)
            ca.put_boolean (is_truncatable)
            ca.put_string (base_value, 0)
            ca.put_typecode (type)
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
            is_abstract := ca.get_boolean
            is_custom := ca.get_boolean
            defined_in := ca.get_string (0)
            version := ca.get_string (0)
            create operationsl.make_default
            operationsl.sequence_from_any (ca)
            create attributes.make_default
            attributes.sequence_from_any (ca)
            create members.make_default
            members.sequence_from_any (ca)
            create initializers.make_default
            initializers.sequence_from_any (ca)
            create supported_interfaces.make_default
            supported_interfaces.sequence_from_any (ca)
            create abstract_base_values.make_default
            abstract_base_values.sequence_from_any (ca)
            is_truncatable := ca.get_boolean
            base_value := ca.get_string (0)
            type := ca.get_typecode
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "FullValueDescription"
        end

end -- class CORBA_VALUEDEF_FULLVALUEDESCRIPTION
