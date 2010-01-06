class
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			l_interval: INTERVAL_B
		do
			create l_integer
			l_integer.set_lower (create {INT_VAL_B})
			create l_character
			l_character.set_lower (create {CHAR_VAL_B})

			l_interval := l_integer
			l_interval.generate

			l_interval := l_character
			l_interval.generate
		end

	l_integer: TYPED_INTERVAL_B [INT_VAL_B]
	l_character: TYPED_INTERVAL_B [CHAR_VAL_B]

end
