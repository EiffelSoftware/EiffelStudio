class CORBA_CONTAINER_DESCRIPTION
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER

creation
    make, make_default

feature

    make_default is

        do
        end

    make (contained_object_val : CORBA_CONTAINED;
          kind_val : CORBA_DEFINITIONKIND;
          value_val : CORBA_ANY) is

        do
            contained_object := contained_object_val
            kind := kind_val
            value := value_val
        end

    contained_object : CORBA_CONTAINED

    set_contained_object (idl_value : CORBA_CONTAINED) is

        do
            contained_object := idl_value
        end

    kind : CORBA_DEFINITIONKIND

    set_kind (idl_value : CORBA_DEFINITIONKIND) is

        do
            kind := idl_value
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
            ca.put_object ("Contained", contained_object)
            kind.enum_to_any (ca)
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
            o := ca.get_object ("Contained")
            contained_object := CORBA_Contained_narrow (o)
            create kind.make_default
            kind.enum_from_any (ca)
            value := ca.get_any
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "Description"
        end

end -- class CORBA_CONTAINER_DESCRIPTION
