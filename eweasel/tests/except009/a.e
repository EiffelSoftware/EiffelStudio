class
	A

feature

	f is
		local
			retried: BOOLEAN
			l_exception: VOID_TARGET
		do
		ensure
			s_not_empty: not s.is_empty
				-- A VOID_TARGET exception is raised here.
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
