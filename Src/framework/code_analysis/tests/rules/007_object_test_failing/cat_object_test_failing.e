note
	ca_only: "CA007"

class
	CAT_OBJECT_TEST_FAILING

feature {NONE} -- Test

	object_test
		local
			l_string: STRING
			l_int: INTEGER
			l_char: CHARACTER
		do

			if attached {CAT_EMPTY_LOOP} l_string then
					-- Should fail.
			else
				if attached {CAT_OBJECT_TEST_FAILING} l_int then
					-- Should fail.
				end
			end

			if
				attached {STRING} l_char
			 	and attached {STRING} l_int
			then
					-- Should fail.
			end

			if attached {STRING} l_string then
					-- Should not fail.
			end

			if attached {ANY} l_string then
					-- Should not fail.
			end
		end

end
