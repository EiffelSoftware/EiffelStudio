Class A

create
	f

feature

	f is
		local
			retried: BOOLEAN
			old_exception: OLD_VIOLATION
		do		-- Record an exception when `old g' is evaluated.
			if not retried then
				h := h + 1
			end
		ensure
			old_g: h = old g - s.count		-- 2. Raise an OLD_VIOLATION.
		rescue
			old_exception ?= (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception
			if old_exception /= Void then
				print ("True%N")
				print_exception (old_exception)
			else
				print ("False%N")
			end
			s := ""
			retried := True
			retry
		end

	g: INTEGER is
		do
				-- 1. An exception is raised, since `s' is not initialized.
			Result := s.count + h
		end

	h: INTEGER

	s: STRING

	print_exception (a_ex: EXCEPTION) is
			-- Print exception
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
		end

end
