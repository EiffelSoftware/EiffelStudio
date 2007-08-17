class
    A

feature

    f is
        local
            retried: BOOLEAN
            l_exception: ROUTINE_FAILURE
        do
            if not retried then
                g        -- 2. Exception of ROUTINE_FAILURE
            else
                x := 0
            end
        rescue
            retried := True
            l_exception ?= last_exception
            if l_exception /= Void then
                print ("True" + "%N")
            else
                print ("False" + "%N")
            end
            s.do_nothing        -- 3. Exception of ATTACHED_TARGET_VIOLATION
            retry
        end

    g is
        local
            l_exception: INVARIANT_EXIT_VIOLATION
        do
            x := -1
                -- 1. Exception of INVARIANT_EXIT_VIOLATION
        rescue
            l_exception ?= last_exception
            if l_exception /= Void then
                print ("True" + "%N")
            else
                print ("False" + "%N")
            end
        end

    x: INTEGER

    s: STRING

invariant
    invari: x >= 0

end