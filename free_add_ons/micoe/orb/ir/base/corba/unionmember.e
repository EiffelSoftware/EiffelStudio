class CORBA_UNIONMEMBER
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
          label_val : CORBA_ANY;
          type_val : CORBA_TYPECODE;
          type_def_val : CORBA_IDLTYPE) is

        do
            name := name_val
            label := label_val
            type := type_val
            type_def := type_def_val
        end

    name : STRING

    set_name (value : STRING) is

        do
            name := value
        end

    label : CORBA_ANY

    set_label (value : CORBA_ANY) is

        do
            label := value
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

    struct_to_any (ca : CORBA_ANY) is

        require
            nonvoid_arg : ca /= void

        local
            dum : BOOLEAN

        do
            dum := ca.struct_put_begin
            ca.put_string (name, 0)
            ca.put_any (label)
            ca.put_typecode (type)
            ca.put_object ("IDLType", type_def)
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
            label := ca.get_any
            type := ca.get_typecode
            o := ca.get_object ("IDLType")
            type_def := CORBA_IDLType_narrow (o)
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "UnionMember"
        end

end -- class CORBA_UNIONMEMBER
