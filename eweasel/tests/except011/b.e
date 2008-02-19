class
	B

feature -- Access

	b is
		local
			retried: BOOLEAN
			l_exception: VOID_TARGET
		do
			if not retried then
				s.do_nothing 	-- Raise an VOID_TARGET
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
			print (a_ex.message + "%N")
		end

	s: STRING

end
