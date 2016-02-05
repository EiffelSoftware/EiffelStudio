note
	ca_only: "CA050"
class
	CAT_LOCAL_USED_FOR_RESULT

feature {NONE} -- Test

	test_01: STRING
		local
			l_string: STRING
		do
			create l_string.make_empty

			l_string.append ("Hallo")

			l_string.append("Welt")

			Result := l_string
		end

	test_02: INTEGER
		local
			l_int: INTEGER
		do
			l_int := 5

			create Result.default_create

			Result := l_int
		end

	test_03 (a_bool: BOOLEAN): STRING
		local
			l_string: STRING
		do
			create l_string.make_from_string ("Hello World")

			if a_bool then
				Result := l_string
			end
		end

end
