class
	A

create
	make

feature

	make is
		do
			s := "a"
		end

	f is
		local
			retried: BOOLEAN
			l_exception: ATTACHED_TARGET_VIOLATION
		do
			if not retried then
				s := Void
			end
		rescue
			l_exception ?= last_exception
			if l_exception /= Void then
				print ("True")
			else
				print ("False")
			end
			retried := True
			retry
		end	-- A ATTACHED_TARGET_VIOLATION exception is raised here.

	s: STRING

invariant
	invari: not s.is_empty

end
