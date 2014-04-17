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
		note
			testing: "execution/isolated"
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
		note
			testing: "execution/isolated"
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

	test_unicode_selection_ev_text
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT_COMPONENT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent unicode_selection (create {EV_TEXT}))
		end

	test_unicode_selection_ev_text_field
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT_COMPONENT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent unicode_selection (create {EV_TEXT_FIELD}))
		end

	test_unicode_selection_ev_password
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT_COMPONENT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent unicode_selection (create {EV_PASSWORD_FIELD}))
		end

	test_unicode_selection_ev_combo
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent unicode_selection (create {EV_COMBO_BOX}))
		end

	test_unicode_selection_ev_rich_text
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT_COMPONENT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent unicode_selection (create {EV_RICH_TEXT}))
		end

feature {NONE} -- Implementation

	unicode_selection (txt: EV_TEXT_COMPONENT)
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT_COMPONENT} instance is problematic for characters
			-- with unicode points >65532!
		local
			str: STRING_32
			i: INTEGER_32
			window: EV_TITLED_WINDOW
		do
			create window
			window.extend (txt)
			window.set_size (600, 600)
			window.show

			str := ""

			from
				i := 66_300
			until
				i > 66_303
			loop
				str.append_character (i.to_character_32)
				i := i + 1
			end

			str.append ("%N")

			from
				i := 65_530
			until
				i > 65_533
			loop
					-- On Windows, character 65_532 is handled as an object
					-- placeholder (see U+FFFC character description) and is
					-- replaced by the space character upon retrieval.
				if i /= 65_532 then
					str.append_character (i.to_character_32)
				end
				i := i + 1
			end

			str.append ("%NS")

			txt.append_text (str)

				-- Ensure that selection is correct.
			from
				i := 1
			until
				i > txt.text_length
			loop
				txt.set_selection (i, i + 1)
				assert ("has selection", txt.has_selection)
				assert ("selection is made of one character", txt.selected_text.count = 1)
				assert ("proper content selection", txt.selected_text.item (1) ~ str.item (i))
				assert ("proper start selection", txt.start_selection = i)
				assert ("proper end selection", txt.end_selection = i + 1)

				txt.set_selection (i, i)
				assert ("no selection", not txt.has_selection)
				assert ("selected_text_empty", txt.selected_text.is_empty)
				assert ("caret position set", txt.caret_position = i)
				assert ("proper start selection", txt.start_selection = i)
				assert ("proper end selection", txt.end_selection = i)
				i := i + 1
			end
			txt.set_selection (i, i)
			assert ("no selection", not txt.has_selection)
			assert ("selected_text_empty", txt.selected_text.is_empty)
			assert ("caret position set", txt.caret_position = i)
			assert ("proper start selection", txt.start_selection = i)
			assert ("proper end selection", txt.end_selection = i)

				-- To use to simplify debuging.
			txt.pointer_leave_actions.extend (agent on_pointer_leave (txt))
		end

	on_pointer_leave (txt: EV_TEXT_COMPONENT)
			-- Print some information about selected text in `txt'!
		local
			i: INTEGER
			sel: STRING_32 -- selected substring
			str: STRING_8 -- for output
		do
			if txt.has_selection then
				str := "Selection <"
				str.append (txt.selection_start.out + ", ")
				str.append (txt.selection_end.out + "> unicode point/s: ")
				from
					sel := txt.selected_text
					i := 1
				until
					i > sel.count
				loop
					str.append (sel.item (i).natural_32_code.out + " ")
					i := i + 1
				end
				str.append ("%N")
				print (str)
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
