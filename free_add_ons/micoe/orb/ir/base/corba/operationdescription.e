class CORBA_OPERATIONDESCRIPTION
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
          idl_result_val : CORBA_TYPECODE;
          mode_val : CORBA_OPERATIONMODE;
          contexts_val : CORBA_CONTEXTIDSEQ;
          parameters_val : CORBA_PARDESCRIPTIONSEQ;
          exceptions_val : CORBA_EXCDESCRIPTIONSEQ) is

        do
            name := name_val
            id := id_val
            defined_in := defined_in_val
            version := version_val
            idl_result := idl_result_val
            mode := mode_val
            contexts := contexts_val
            parameters := parameters_val
            exceptions := exceptions_val
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

    idl_result : CORBA_TYPECODE

    set_idl_result (value : CORBA_TYPECODE) is

        do
            idl_result := value
        end

    mode : CORBA_OPERATIONMODE

    set_mode (value : CORBA_OPERATIONMODE) is

        do
            mode := value
        end

    contexts : CORBA_CONTEXTIDSEQ

    set_contexts (value : CORBA_CONTEXTIDSEQ) is

        do
            contexts := value
        end

    parameters : CORBA_PARDESCRIPTIONSEQ

    set_parameters (value : CORBA_PARDESCRIPTIONSEQ) is

        do
            parameters := value
        end

    exceptions : CORBA_EXCDESCRIPTIONSEQ

    set_exceptions (value : CORBA_EXCDESCRIPTIONSEQ) is

        do
            exceptions := value
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
            ca.put_typecode (idl_result)
            mode.enum_to_any (ca)
            contexts.sequence_to_any (ca)
            parameters.sequence_to_any (ca)
            exceptions.sequence_to_any (ca)
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
            idl_result := ca.get_typecode
            create mode.make_default
            mode.enum_from_any (ca)
            create contexts.make_default
            contexts.sequence_from_any (ca)
            create parameters.make_default
            parameters.sequence_from_any (ca)
            create exceptions.make_default
            exceptions.sequence_from_any (ca)
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "OperationDescription"
        end

end -- class CORBA_OPERATIONDESCRIPTION
