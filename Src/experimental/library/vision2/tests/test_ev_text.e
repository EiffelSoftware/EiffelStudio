note
	description: "Tests for EV_TEXT"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_TEXT

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_text_caret_positioning
			-- Demonstrate that programmatical caret positioning
			-- at the beginning of a non-first line fails!
		local
			txt: EV_TEXT
			i: INTEGER
		do
			create txt
			txt.set_text ("123%N567%N")
			from i := 1 until i > 9 loop
				txt.set_caret_position (i)
				assert ("Caret position properly set", txt.caret_position = i)
				i := i + 1
			end
		end

	test_rich_text_caret_positioning
			-- Demonstrate that programmatical caret positioning
			-- at the beginning of a non-first line fails!
		local
			txt: EV_RICH_TEXT
			i: INTEGER
		do
			create txt
			txt.set_text ("123%N567%N")
			from i := 1 until i > 9 loop
				txt.set_caret_position (i)
				assert ("Caret position properly set", txt.caret_position = i)
				i := i + 1
			end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
