class
	A

feature

	f is
		local
			retried: BOOLEAN
			l_exception: ROUTINE_FAILURE
			l_b: B
		do
			if not retried then
				g        -- 2. Exception of ROUTINE_FAILURE
			else
				x := 0
			end
		rescue
			retried := True
			
			create l_b
			l_b.b			-- An exception was raised and handled.
			
			l_exception ?= (create {EXCEPTION_MANAGER}).last_exception
			if l_exception /= Void then
				print ("True" + "%N")
			else
				print ("False" + "%N")
			end
		retry
		end
	
	g is
		local
			l_exception: INVARIANT_VIOLATION
		do
			x := -1
				-- 1. Exception of INVARIANT_VIOLATION
		rescue
			x := 1
			l_exception ?= (create {EXCEPTION_MANAGER}).last_exception
			if l_exception /= Void and then not l_exception.is_entry then
				print ("True" + "%N")
			else
				print ("False" + "%N")
			end
		end
	
	x: INTEGER
	
	s: STRING
	
invariant
	invari: x >= 0

end
