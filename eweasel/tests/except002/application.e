class
	APPLICATION

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			a: A
			retried: BOOLEAN
			l_exception: INVARIANT_VIOLATION
		do
			if not retried then
				create a.make
				a.list.wipe_out
					-- An entry INVARIANT_VIOLATION is raised here.
				a.f
			end
		rescue
			l_exception ?= (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception
			if l_exception /= Void and then l_exception.is_entry then
				print ("True%N")
				print_exception (l_exception)
			else
				print ("False%N")
			end
			retried := True
			retry
		end

	print_exception (a_ex: EXCEPTION) is
			-- Print exception
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
			print (a_ex.message + "%N")
		end

end -- class APPLICATION
