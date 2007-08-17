class
	A

feature

	f is
		local
			retried: BOOLEAN
			l_exception: INVARIANT_EXIT_VIOLATION
		do
			i := -1
				-- A INVARIANT_EXIT_VIOLATION exception is raised here.
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

	i: INTEGER

invariant
	invari: i >= 0

end
