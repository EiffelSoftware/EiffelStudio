class
	TEST

inherit
	INTERNAL

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_int_value_type: INTEGER_32
		do
			l_int_value_type := dynamic_type_from_string ("INTEGER")
		end

end
