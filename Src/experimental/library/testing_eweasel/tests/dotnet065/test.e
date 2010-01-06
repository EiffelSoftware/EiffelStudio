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
				{TEST},
				{A},
				{B},
				{C}>>
				
			l_count := l_types.count
			from i := 1 until i > l_count loop
				l_type := l_types [i]
				print (l_type.full_name)
				print ("%N")
				i := i + 1
			end
		end

end