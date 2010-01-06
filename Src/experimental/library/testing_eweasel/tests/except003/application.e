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
			l_exception: VOID_TARGET
		do
			if not retried then
				create a	   -- An VOID_TARGET is raised here
				a.f
			end
		rescue
			l_exception ?= (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception
			if l_exception /= Void then
				print ("True%N")
				print_exception (l_exception)
			else
				print ("False%N")
			end
			retried := True
			retry
		end

	print_exception (a_ex: EXCEPTION) is
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
			print (a_ex.message + "%N")
		end

end -- class APPLICATION
