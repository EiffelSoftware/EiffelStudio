class
	A

feature

	f is
		local
			retried: BOOLEAN
			l_exception: INVARIANT_VIOLATION
		do
			if not retried then
				i := -1
			else
				i := 1
			end
				-- A exit INVARIANT_VIOLATION exception is raised here.
		rescue
			l_exception ?= (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception
			if l_exception /= Void and then not l_exception.is_entry then
				print ("True%N")
				print_exception (l_exception)
			else
				print ("False%N")
			end
			retried := True
			retry
		end

	i: INTEGER

	print_exception (a_ex: EXCEPTION) is
			--
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
			print (a_ex.message + "%N")
		end

invariant
	invari: i >= 0

end
