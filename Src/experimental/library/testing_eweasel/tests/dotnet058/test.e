class
	TEST

create
	make

feature -- Initialization

	make is
			-- Prints location of ANY
		local
			l_type: SYSTEM_TYPE
		do
			l_type := {ANY}
			print (l_type.full_name)
			print ("%N")
		end

end