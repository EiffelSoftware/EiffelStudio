class
	A

create
	make

feature

	make is
		do
			s := "a"
		end

	f is
		local
			retried: BOOLEAN
			l_exception: VOID_TARGET
		do
			if not retried then
				s := Void
			else
				s := "a"
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
		end	-- A VOID_TARGET exception is raised here.

	s: STRING

	print_exception (a_ex: EXCEPTION) is
			--
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
			print (a_ex.message + "%N")
		end

invariant
	invari: not s.is_empty

end
