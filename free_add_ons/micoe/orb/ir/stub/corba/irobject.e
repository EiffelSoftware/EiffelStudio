class CORBA_IROBJECT_STUB
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER
        undefine
            copy, is_equal
        end;
    STANDARD_STUB
        redefine
            make_with_peer
        end;
    CORBA_IROBJECT
        undefine
            implementation, copy, is_equal
        redefine
            make
        end


creation
    make, make_with_peer

feature

    make is

        do
            precursor
            am_a_stub := true
        end

    make_with_peer (o : CORBA_OBJECT) is

        do
            precursor (o)
            am_a_stub := true
            ior := o.ior
        end

    def_kind : CORBA_DEFINITIONKIND is

        do
            begin_request ("_get_def_kind")
            result_is_of_type (corba_definitionkind_tc)
            invoke
            create result.make_default
            result.enum_from_any (get_result_as_any)
            end_request
        end

    destroy is

        do
            begin_request ("destroy")
            invoke
            end_request
        end

end -- class CORBA_IROBJECT_STUB
