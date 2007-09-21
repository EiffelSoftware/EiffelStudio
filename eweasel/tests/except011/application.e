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
			if not retried then
			    create a
			    a.f        -- 4. Exception of ROUTINE_FAILURE
			end
		rescue
			retried := True
			l_exception ?= (create {EXCEPTION_MANAGER}).last_exception
			if l_exception /= Void then
				print ("True" + "%N")
			else
				print ("False" + "%N")
			end
			retry
		end

end -- class APPLICATION
