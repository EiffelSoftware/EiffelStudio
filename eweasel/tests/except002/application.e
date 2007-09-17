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
			l_exception: INVARIANT_VIOLATION
		do
			if not retried then
				create a.make	   
				a.list.wipe_out
					-- An entry INVARIANT_VIOLATION is raised here.
				a.f
			end
		rescue
			l_exception ?= (create {EXCEPTION_MANAGER}).last_exception
			if l_exception /= Void and then l_exception.is_entry then
				print ("True")
			else
				print ("False")
			end
			retried := True
			retry
		end

end -- class APPLICATION
