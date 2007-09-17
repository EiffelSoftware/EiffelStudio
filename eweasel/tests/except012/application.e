class
	APPLICATION

inherit
	A

create
	make

feature -- Initialization

	make is
			-- Run application.
		local
			a: A
			l_exception: ROUTINE_FAILURE
			retried: BOOLEAN
		do
			if not retried then
				create a
				a.f
			end
		rescue
			retried := True
			l_exception ?= (create {EXCEPTION_MANAGER}).last_exception
			if l_exception /= Void then
				print ("True" + "%N")
			else
				print ("False" + "%N")
			end
			if l_exception /= Void and then l_exception.original = my_exception then
				print ("True" + "%N")
			else
				print ("False" + "%N")
			end
			retry
		end

end -- class APPLICATION
