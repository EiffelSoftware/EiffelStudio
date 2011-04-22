Class A

create
	f

feature

	f 
		local
			retried: BOOLEAN
			old_exception: OLD_VIOLATION
		do		-- Record an exception when `old g' is evaluated.
			if not retried then
				h := h + 1
			end
		ensure
				-- 2. Raise an OLD_VIOLATION on first execution.
			old_g: s /= Void or else h = old g - s.count
		rescue
			old_exception ?= (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception
			if old_exception /= Void then
				print ("True%N")
				print (old_exception.recipient_name + "%N")
				print (old_exception.type_name + "%N")
			else
				print ("False%N")
			end
			s := ""
			retried := True
			retry
		end

	g: INTEGER
		do
				-- 1. Raise an exception when `s' is void.
			Result := s.count + h
		end

	h: INTEGER

	s: STRING

end
