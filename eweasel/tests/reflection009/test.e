class
	TEST

inherit
	INTERNAL

create
	make

feature {NONE} -- Initialization

	make
		local
			l_reflector: REFLECTOR
		do
			create l_reflector

			check_assert ("is_special_any type on detachable SPECIAL [ANY]", l_reflector.is_special_any_type (({detachable SPECIAL [ANY]}).type_id))
			check_assert ("is_special_type on detachable SPECIAL [ANY]", l_reflector.is_special_type (({detachable SPECIAL [ANY]}).type_id))
			check_assert ("is_tuple_type on detachable TUPLE", l_reflector.is_tuple_type (({detachable TUPLE}).type_id))


			check_assert ("is_special_any type on SPECIAL [ANY]", l_reflector.is_special_any_type (({SPECIAL [ANY]}).type_id))
			check_assert ("is_special_type on SPECIAL [ANY]", l_reflector.is_special_type (({SPECIAL [ANY]}).type_id))
			check_assert ("is_tuple_type on TUPLE", l_reflector.is_tuple_type (({TUPLE}).type_id))

		
			check_assert ("Valid instance of TEST", l_reflector.new_instance_of (({TEST}).type_id).generating_type.type_id = generating_type.type_id)	
		end

	check_assert (message: STRING; expr: BOOLEAN)
		do
			if not expr then
				io.put_string (message)
				io.put_new_line
			end
		end

end
