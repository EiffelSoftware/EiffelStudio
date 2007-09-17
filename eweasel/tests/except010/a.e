class
	A

feature

	f is
		local
			retried: BOOLEAN
			l_exception: POSTCONDITION_VIOLATION
		do
			if retried then
				s := "a"
			end
		ensure
			s_not_void: s /= Void
				-- A POSTCONDITION_VIOLATION exception is raised here.
		rescue
			l_exception ?= (create {EXCEPTION_MANAGER}).last_exception
			if l_exception /= Void then
				print ("True")
			else
				print ("False")
			end
			retried := True
			retry
		end

	s: STRING

end
