class
	B

feature -- Access

	b is
		local
			retried: BOOLEAN
			l_exception: VOID_TARGET
		do
			if not retried then
				s.do_nothing 	-- Raise an VOID_TARGET
			end
		rescue
			retried := True
			l_exception ?= (create {EXCEPTION_MANAGER}).last_exception
			if l_exception /= Void then
				print ("True%N")
			else
				print ("False%N")
			end
			retry
		end

	s: STRING

end
