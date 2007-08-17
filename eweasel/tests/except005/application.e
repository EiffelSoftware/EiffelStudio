class
	APPLICATION

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			a: A
			retried: BOOLEAN
			l_exception: PRECONDITION_VIOLATION
		do
			if not retried then
				create a
				a.f		-- An PRECONDITION_VIOLATION is raised here
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
		end

end -- class APPLICATION
