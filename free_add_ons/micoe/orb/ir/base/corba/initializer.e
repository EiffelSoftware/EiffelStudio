class CORBA_INITIALIZER
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER

creation
    make, make_default

feature

    make_default is

        do
        end

    make (members_val : CORBA_STRUCTMEMBERSEQ;
          name_val : STRING) is

        do
            members := members_val
            name := name_val
        end

    members : CORBA_STRUCTMEMBERSEQ

    set_members (value : CORBA_STRUCTMEMBERSEQ) is

        do
            members := value
        end

    name : STRING

    set_name (value : STRING) is

        do
            name := value
        end

    struct_to_any (ca : CORBA_ANY) is

        require
            nonvoid_arg : ca /= void

        local
            dum : BOOLEAN

        do
            dum := ca.struct_put_begin
            members.sequence_to_any (ca)
            ca.put_string (name, 0)
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
            create members.make_default
            members.sequence_from_any (ca)
            name := ca.get_string (0)
            dum := ca.struct_get_end
        end

feature { ANY }

    type_name : STRING is

        do
            result := "Initializer"
        end

end -- class CORBA_INITIALIZER
