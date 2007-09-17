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
			l_exception ?= (create {EXCEPTION_MANAGER}).last_exception
			if l_exception /= Void and then not l_exception.is_entry then
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
