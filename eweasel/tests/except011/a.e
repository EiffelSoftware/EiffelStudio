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
				print ("True%N")
				print_exception (l_exception, True)
			else
				print ("False%N")
			end
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
				print ("True%N")
				print_exception (l_exception, False)
			else
				print ("False%N")
			end
		end

	x: INTEGER

	s: STRING

	print_exception (a_ex: EXCEPTION; rf: BOOLEAN) is
			--
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
			if not rf then
				print (a_ex.message + "%N")
			end
		end

invariant
	invari: x >= 0

end
