class CORBA_CONTEXTIDSEQ
    -- This text was automatically generated. DO NOT EDIT!

inherit
    IR_HELPER

creation
    make_default

feature

    make_default is

        do
            create store.make(1, 20)
            bound := 0
            length := 0
        end

    get_value (index : INTEGER) : STRING is

        require
            valid_index : 1 <= index

        do
            if index <= store.upper then
                result := store.item (index)
            end
        end

    set_value (value : STRING; index : INTEGER) is

        require
            valid_index : 1 <= index

        do
            store.force (value, index)
            if index > length then
                length := index
            end
        end

    length : INTEGER

    declared_length : INTEGER is

        do
            result := bound
        end

feature { NONE }

    bound : INTEGER
    store : ARRAY [STRING]

feature { ANY }

    sequence_to_any (ca : CORBA_ANY) is 

        require
            nonvoid_arg : ca /= void

        local
            i, n : INTEGER
            x    : STRING

        do
            n := length
            ca.seq_put_begin (n)
            from
                i := 1
            until
                i > n
            loop
                x := store.item (i)
                i := i + 1
                if x /= void then
                    ca.put_string (x, 0)
                end
            end
            ca.seq_put_end
        end

    sequence_from_any (ca : CORBA_ANY) is 

        require
            nonvoid_arg : ca /= void

        local
            i, n : INTEGER
            len  : INTEGER_REF
            dum  : BOOLEAN
            o    : CORBA_OBJECT
            x    : STRING

        do
            create len
            dum := ca.seq_get_begin (len)
            n := len.item
            create store.make (1, n)
            from
                i := 1
            until
                i > n
            loop
                x := ca.get_string (0)
                store.put (x, i)
                i := i + 1
            end
            ca.seq_get_end
            length := n
        end

feature { ANY }

    type_name : STRING is

        do
            result := "ContextIdSeq"
        end

end -- class CORBA_CONTEXTIDSEQ
