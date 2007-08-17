class
	A

feature

	f is
		local
			retried: BOOLEAN
			l_exception: ATTACHED_TARGET_VIOLATION
		do
		ensure
			s_not_empty: not s.is_empty
				-- A ATTACHED_TARGET_VIOLATION exception is raised here.
		rescue
			l_exception ?= last_exception
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
