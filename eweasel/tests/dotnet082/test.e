class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests
		local
			l_a: A
			l_name: SYSTEM_STRING
			retried: BOOLEAN
			l_type: SYSTEM_TYPE
			l_array: NATIVE_ARRAY [SYSTEM_STRING]
		do
			if not retried then
				l_name := "Eiffel"
				l_type := {A}
				l_array := <<l_name>>
				l_a ?= {ACTIVATOR}.create_instance (l_type)
				l_a ?= {ACTIVATOR}.create_instance (l_type, l_array)
			end
		rescue
			retried := True
			retry
		end

end
