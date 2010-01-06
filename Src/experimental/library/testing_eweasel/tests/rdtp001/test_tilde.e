class
	TEST_TILDE

feature

	make is
		do
			if a ~ b then
			end
			if a /~ b then
			end
			if io.last_string ~ io.last_character then
			end
			if equal (True, False) ~ equal (False, True) then
			end
		end

end
