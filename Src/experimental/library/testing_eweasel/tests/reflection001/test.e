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
			l_int_created_type: INTEGER_32
		do
			l_int_value_type := dynamic_type (0)
			l_int_created_type := dynamic_type (create {INTEGER_32})

			check
				same_type1: l_int_value_type = l_int_created_type
				same_type2: l_int_value_type = dynamic_type_from_string ("INTEGER")
				same_type3: l_int_value_type = dynamic_type_from_string ("INTEGER_32")
			end
		end

end
