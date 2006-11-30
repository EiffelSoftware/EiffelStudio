class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			w: WIDE_CHARACTER
		do
			w := (1234).to_character_32
			print (w.natural_32_code)
			print ("%N")
		end

end
