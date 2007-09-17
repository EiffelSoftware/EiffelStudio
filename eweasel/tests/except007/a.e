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
			l_exception: VOID_TARGET
		do
			if not retried then
				s := Void
			else
				s := "a"
			end
		rescue
			l_exception ?= (create {EXCEPTION_MANAGER}).last_exception
			if l_exception /= Void then
				print ("True")
			else
				print ("False")
			end
			retried := True
			retry
		end	-- A VOID_TARGET exception is raised here.

	s: STRING

invariant
	invari: not s.is_empty

end
