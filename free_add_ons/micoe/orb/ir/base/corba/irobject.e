deferred class CORBA_IROBJECT
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IMPLEMENTATION_BASE
        redefine
            repoid, consume, valid_message_type
        end;
    IR_CORBA_CONSTANTS
        undefine
            copy, is_equal
        end;
    IR_HELPER
        undefine
            copy, is_equal
        end

feature

    def_kind : CORBA_DEFINITIONKIND is

        deferred
        end

    destroy is

        deferred
        end


feature { COURIER, CONSUMER }

    consume (msg : ANY; type : INTEGER) is 

        local
            req : CORBA_SERVER_REQUEST
            ca  : CORBA_ANY
            o   : CORBA_OBJECT
            dum : BOOLEAN
            x1  : CORBA_DEFINITIONKIND

        do
            req ?= msg
            create ca.make
            req.mico_set_result (ca)
            begin_invoke

            inspect type

            when 1 then
                destroy
            when 2 then
                x1 := def_kind
                ca.make1 (corba_definitionkind_tc)
                x1.enum_to_any (ca)
            end
            finish_invoke
        end

    valid_message_type (msg : ANY; type : INTEGER) : BOOLEAN is

        do
            result := (1 <= type and then type <= 2)
            result := result and then msg.conforms_to (template)
        end

feature { NONE }

    template : CORBA_SERVER_REQUEST is

        once
            create result.make
        end

    repoid : STRING is 

        do
            result := "IDL:omg.org/CORBA/IRObject:1.0"
            ior.set_repoid (result)
        end

feature { ANY }

    type_name : STRING is

        do
            result := "IRObject"
        end

end -- class CORBA_IROBJECT
