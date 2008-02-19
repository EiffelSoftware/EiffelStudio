class
	A

feature

	f is
		local
			retried: BOOLEAN
			l_exception: VOID_TARGET
		do
			if retried then
				s := "a"
			end
		ensure
			s_not_empty: not s.is_empty
				-- A VOID_TARGET exception is raised here.
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

	s: STRING

	print_exception (a_ex: EXCEPTION) is
			--
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
			print (a_ex.message + "%N")
		end

end
