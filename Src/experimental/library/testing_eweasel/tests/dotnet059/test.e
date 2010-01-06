class
	TEST

create
	make

feature -- Initialization

	make is
			-- Prints location of ANY
		local
			l_types: ARRAY [TYPE [ANY]]
			l_count, i: INTEGER
			l_type: SYSTEM_TYPE
		do
			l_types := <<
				{INTEGER_8},
				{INTEGER_16},
				{INTEGER_32},
				{INTEGER_64},
				{NATURAL_8},
				{NATURAL_16},
				{NATURAL_32},
				{NATURAL_64},
				{REAL_32},
				{REAL_64},
				{POINTER},
				
				-- Configured mappings
				
				{INTEGER},
				{NATURAL},
				{REAL},
				{DOUBLE}>>
				
			l_count := l_types.count
			from i := 1 until i > l_count loop
				l_type := l_types [i]
				print (l_type.full_name)
				print ("%N")
				i := i + 1
			end
		end

end