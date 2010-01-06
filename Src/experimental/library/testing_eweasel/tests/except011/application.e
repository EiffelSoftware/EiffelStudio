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
			l_exception ?= (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception
			if l_exception /= Void then
				print ("True%N")
				print_exception (l_exception)
			else
				print ("False%N")
			end
			retry
		end

	print_exception (a_ex: EXCEPTION) is
			--
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
		end

end -- class APPLICATION
