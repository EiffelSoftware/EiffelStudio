class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests
		local
			l_a: A
			l_so: SYSTEM_OBJECT
			retried: BOOLEAN
		do
			if not retried then
				create l_a.make
				l_so ?= l_a
				print (l_so.get_type.get_constructors.count)
				print ("%N")
			end
		rescue
			retried := True
			retry
		end

end
