class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests
		local
			l_a: A
			l_name: STRING
			retried: BOOLEAN
		do
			if not retried then
				l_name := "Eiffel"
				l_a ?= {ACTIVATOR}.create_instance ({A})
				l_a ?= {ACTIVATOR}.create_instance ({A}, ({ARRAY [SYSTEM_OBJECT]})[<<l_name>>])
			end
		rescue
			retried := True
			retry
		end

end
