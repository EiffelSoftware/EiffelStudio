class TEST

create
	make

feature {NONE} -- Creation

	make is
		local
			l_int: INTERNAL
			i: INTEGER
			t: TEST1 [STRING]
		do
			create l_int
			check_dtype (l_int.dynamic_type_from_string ("TEST"))

			check_dtype (l_int.dynamic_type_from_string ("!TEST"))
			check_dtype (l_int.dynamic_type_from_string ("?TEST"))
			check_dtype (l_int.dynamic_type_from_string ("  ?TEST"))
			check_dtype (l_int.dynamic_type_from_string ("  ?  TEST"))
			check_dtype (l_int.dynamic_type_from_string ("  !TEST"))
			check_dtype (l_int.dynamic_type_from_string ("  !  TEST"))

			check_dtype (l_int.dynamic_type_from_string ("TEST1 [STRING]"))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [!STRING]"))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [?STRING]"))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  !  STRING]"))
			check_dtype (l_int.dynamic_type_from_string ("TEST1 [  ?   STRING]"))
		end

	check_dtype (i: INTEGER) is
		do
			if i = -1 then
				io.put_string ("Not OK")
				io.put_new_line
			end
		end

end
