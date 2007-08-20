class
    APPLICATION

create
    make

feature -- Initialization

    make is
            -- Run application.
        local
            a: A
            l_exception: ROUTINE_FAILURE
            retried: BOOLEAN
        do
            create a
            a.f        -- 4. Exception of ROUTINE_FAILURE
        rescue
            retried := True
            l_exception ?= last_exception
            if l_exception /= Void then
                print ("True" + "%N")
            else
                print ("False" + "%N")
            end
            retry
        end

end -- class APPLICATION