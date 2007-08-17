class
	APPLICATION

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			a: STRING
			retried: BOOLEAN
			l_exception: ATTACHED_TARGET_VIOLATION
		do
			if not retried then
				a.f		-- An ATTACHED_TARGET_VIOLATION is raised here
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
