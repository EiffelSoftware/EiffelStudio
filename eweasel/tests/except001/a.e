Class A

feature

	f is
		local
			retried: BOOLEAN
			old_exception: OLD_VIOLATION
		do		-- Record an exception when `old g' is evaluated.
			if not retried then
				h := h + 1
			else
				s := ""
			end
		ensure
			h = old g - s.count + 1		-- 2. Raise an OLD_VIOLATION.
		rescue
			old_exception ?= last_exception
			if old_exception /= Void then
				print ("True")
			else
				print ("False")
			end
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

end