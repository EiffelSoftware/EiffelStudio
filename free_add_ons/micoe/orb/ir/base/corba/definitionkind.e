class CORBA_DEFINITIONKIND
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER;
    IR_CORBA_CONSTANTS

creation
    make, make_default

feature

    make_default is

        do
        end

    make (val : INTEGER) is

        require
            valid_value : 0 <= val and then val <= CORBA_DefinitionKind_maxvalue

        do
            value := val
        end

    set_value (val : INTEGER) is

        require
            valid_value : 0 <= val and then val <= CORBA_DefinitionKind_maxvalue

        do
            value := val
        end

    value : INTEGER

    enum_to_any (ca : CORBA_ANY) is

        require
            vonvoid_arg: ca /= void

        local
            dum : BOOLEAN

        do
            dum := ca.enum_put (value)
        end

    enum_from_any (ca : CORBA_ANY) is

        require
            vonvoid_arg: ca /= void

        do
            value := ca.enum_get
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/DefinitionKind:1.0"
        end


end -- class CORBA_DEFINITIONKIND
