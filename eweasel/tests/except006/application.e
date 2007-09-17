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
			l_exception: VOID_TARGET
		do
			if not retried then
				a.do_nothing		-- An VOID_TARGET is raised here
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
		end

end -- class APPLICATION
