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

	test_text_caret_positioning_at_newlines
			-- Demonstrate that 'internal' caret positioning
			-- before '%N' causes problems!
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					txt: EV_TEXT
					l_clipboard: EV_CLIPBOARD
				do
					create txt
					txt.set_text ("123%N567")

					txt.set_caret_position (4)
					txt.insert_text ("X")
					assert ("Text updated before %N", txt.text.same_string_general ("123X%N567"))

					txt.set_caret_position (4)
					txt.insert_text ("%N")
					assert ("Text updated before %N", txt.text.same_string_general ("123%NX%N567"))

					txt.set_caret_position (7)
					txt.insert_text ("Y")
					assert ("Text updated after %N", txt.text.same_string_general ("123%NX%NY567"))

					txt.select_all
					txt.copy_selection

					if attached application as l_application then
						l_clipboard := l_application.clipboard
						assert ("Text in clipboard", l_clipboard.has_text)
						assert ("Text is valid", l_clipboard.text.same_string_general ("123%NX%NY567"))
					else
						assert ("An application should be running", False)
					end
				end)
		end

	test_text_select_region_at_newlines
			-- Demonstrate that 'internal' caret positioning
			-- before '%N' causes problems!
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					txt: EV_TEXT
					l_clipboard: EV_CLIPBOARD
				do
					create txt
					txt.set_text ("123%N567")
					txt.select_region (4, 4)
					txt.delete_selection
					assert ("Text updated", txt.text ~ "123567")

					txt.select_all
					txt.copy_selection

					if attached application as l_application then
						l_clipboard := l_application.clipboard
						assert ("Text in clipboard", l_clipboard.has_text)
						assert ("Text is valid", l_clipboard.text.same_string_general ("123567"))
					else
						assert ("An application should be running", False)
					end

				end)
		end

	test_rich_text_caret_positioning_at_newlines
			-- Demonstrate that 'internal' caret positioning
			-- before '%N' causes problems!
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					txt: EV_RICH_TEXT
					l_clipboard: EV_CLIPBOARD
				do
					create txt
					txt.set_text ("123%N567")

					txt.set_caret_position (4)
					txt.insert_text ("X")
					assert ("Text updated before %N", txt.text.same_string_general ("123X%N567"))

					txt.set_caret_position (4)
					txt.insert_text ("%N")
					assert ("Text updated before %N", txt.text.same_string_general ("123%NX%N567"))

					txt.set_caret_position (7)
					txt.insert_text ("Y")
					assert ("Text updated after %N", txt.text.same_string_general ("123%NX%NY567"))

					txt.select_all
					txt.copy_selection

					if attached application as l_application then
						l_clipboard := l_application.clipboard
						assert ("Text in clipboard", l_clipboard.has_text)
						assert ("Text is valid", l_clipboard.text.same_string_general ("123%NX%NY567"))
					else
						assert ("An application should be running", False)
					end
				end)
		end

	test_rich_text_select_region_at_newlines
			-- Demonstrate that 'internal' caret positioning
			-- before '%N' causes problems!
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					txt: EV_RICH_TEXT
					l_clipboard: EV_CLIPBOARD
				do
					create txt
					txt.set_text ("123%N567")
					txt.select_region (4, 4)
					txt.delete_selection
					assert ("Text updated", txt.text ~ "123567")

					txt.select_all
					txt.copy_selection

					if attached application as l_application then
						l_clipboard := l_application.clipboard
						assert ("Text in clipboard", l_clipboard.has_text)
						assert ("Text is valid", l_clipboard.text.same_string_general ("123567"))
					else
						assert ("An application should be running", False)
					end

				end)
		end

	test_text_invert_selection
			-- Test showing that performing a reverse selection works.
		note
			testing: "execution/isolated"
		local
			txt: EV_TEXT
			rtxt: EV_RICH_TEXT
		do
			create txt
			txt.set_text ("1234567890")
			txt.set_selection (4, 2)
			assert ("Good selection", txt.selected_text.same_string_general ("23"))
			txt.select_region (6, 2)
			assert ("Good selection", txt.selected_text.same_string_general ("345"))

			create rtxt
			rtxt.set_text ("1234567890")
			rtxt.set_selection (4, 2)
			assert ("Good selection", rtxt.selected_text.same_string_general ("23"))
			rtxt.select_region (6, 2)
			assert ("Good selection", rtxt.selected_text.same_string_general ("345"))
		end

feature -- Unicode selection

	test_unicode_selection_ev_text
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT_COMPONENT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_txt: EV_TEXT
				do
					create l_txt
					l_txt.enable_word_wrapping
					text_selection (l_txt, True)
					text_large_selection (l_txt, True)

					l_txt.disable_word_wrapping
					text_selection (l_txt, True)
					text_large_selection (l_txt, True)
				end)
		end

	test_unicode_selection_ev_text_field
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT_COMPONENT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent text_selection (create {EV_TEXT_FIELD}, True))
		end

	test_unicode_selection_ev_password
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT_COMPONENT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent text_selection (create {EV_PASSWORD_FIELD}, True))
		end

	test_unicode_selection_ev_combo
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent text_selection (create {EV_COMBO_BOX}, True))
		end

	test_unicode_selection_ev_rich_text
			-- Demonstrate that selection of unicode characters
			-- in an {EV_TEXT_COMPONENT} instance is problematic for characters
			-- with unicode points >65532!
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_txt: EV_RICH_TEXT
				do
					create l_txt
					l_txt.enable_word_wrapping
					text_selection (l_txt, True)
					text_large_selection (l_txt, True)

					l_txt.disable_word_wrapping
					text_selection (l_txt, True)
					text_large_selection (l_txt, True)
				end)
		end

feature -- ASCII

	test_ascii_selection_ev_text
			-- Demonstrate that selection of ascii characters
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_txt: EV_TEXT
				do
					create l_txt
					l_txt.enable_word_wrapping
					text_selection (l_txt, False)
					text_large_selection (l_txt, False)

					l_txt.disable_word_wrapping
					text_selection (l_txt, False)
					text_large_selection (l_txt, False)
				end)
		end

	test_ascii_selection_ev_text_field
			-- Demonstrate that selection of ascii characters
		note
			testing: "execution/isolated"
		do
			run_test (agent text_selection (create {EV_TEXT_FIELD}, False))
		end

	test_ascii_selection_ev_password
			-- Demonstrate that selection of ascii characters
		note
			testing: "execution/isolated"
		do
			run_test (agent text_selection (create {EV_PASSWORD_FIELD}, False))
		end

	test_ascii_selection_ev_combo
			-- Demonstrate that selection of ascii characters
		note
			testing: "execution/isolated"
		do
			run_test (agent text_selection (create {EV_COMBO_BOX}, False))
		end

	test_ascii_selection_ev_rich_text
			-- Demonstrate that selection of ascii characters
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_txt: EV_RICH_TEXT
				do
					create l_txt
					l_txt.enable_word_wrapping
					text_selection (l_txt, False)
					text_large_selection (l_txt, False)

					l_txt.disable_word_wrapping
					text_selection (l_txt, False)
					text_large_selection (l_txt, False)
				end)
		end

feature {NONE} -- Implementation

	text_selection (txt: EV_TEXT_COMPONENT; is_unicode: BOOLEAN)
			-- Demonstrate that selection of characters
			-- in an {EV_TEXT_COMPONENT} instance can problematic for
			-- certain characters.
		local
			str: STRING_32
			i, nb: INTEGER_32
			window: EV_TITLED_WINDOW
		do
			create window.make_with_title (txt.generating_type.name)
			window.extend (txt)
			window.set_size (200, 600)
			window.show

			str := ""

			if is_unicode then
					-- Greater than UTF-16 limits characters
				str.append_character ('a')
				str.append_code (66185)
				str.append_code (66186)
				str.append_code (66300)
				str.append_code (66301)
				str.append_code (66302)
				str.append_code (66303)
				str.append_code (66304)

				str.append ("%N")

					-- Special case of characters around the escape
					-- character 65_532
				from
					i := 65_530
				until
					i > 65_533
				loop
						-- On Windows EV_RICH_EDIT, the character 65_532 is
						-- handled as an object placeholder (see U+FFFC character
						-- description) and is replaced by the space character
						-- upon retrieval so we ignore it.
					if
						i /= 65_532 or else
						not {PLATFORM}.is_windows or else
						not attached {EV_RICH_TEXT} txt
					then
						str.append_character (i.to_character_32)
					end
					i := i + 1
				end

				str.append ("%NS")
			else
					-- We check ASCII and long strings in case of word wrapping
				str.append ("123456%N134mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm mmmmmmmmmmmmmmmmm21%N43")
			end

			txt.append_text (str)

				-- Ensure that selection is correct.
			from
				i := 1
				nb := txt.text_length
				assert ("valid length", nb = str.count)
			until
				i > nb
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

				txt.set_caret_position (i)
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

			window.prune (txt)
			txt.remove_text
			window.destroy
		end

	text_large_selection (txt: EV_TEXT_COMPONENT; is_unicode: BOOLEAN)
			-- Demonstrate that selection of characters
			-- in an {EV_TEXT_COMPONENT} instance can problematic for
			-- certain characters.
		local
			str: STRING_32
			i, nb: INTEGER_32
			c: CHARACTER_32
			window: EV_TITLED_WINDOW
		do
			create window.make_with_title (txt.generating_type.name)
			window.extend (txt)
			window.set_size (200, 600)
			window.show

			create str.make (66000)
			from
					-- We start at character '0' to avoid all control characters
				i := 48
			until
				str.count > 66000
			loop
				if str.count \\ 100 = 0 then
						-- So that the text look nice and that we have %N characters.
					str.append_character ('%N')
				end
				if is_unicode then
					if i >= 0x0300 and i <= 0x036F then
							-- Ignore diacritical marks
						i := 0x0370
					elseif i >= 0xD800 and i <= 0xF8FF then
							-- Ignore UTF-16 surrogates and private use character
						i := 0xF900
					end
					if
						(i = 0x2028 or i = 0x2029 or i = 0xFFFC) and
						{PLATFORM}.is_windows and
						attached {EV_RICH_TEXT} txt
					then
							-- On Windows EV_RICH_EDIT, the character 0x2028 and 0x2029 are replaced by %N and 0xFFFC
							-- handled as an object placeholder (see U+FFFC character
							-- description) and is replaced by the space character
							-- upon retrieval so we ignore it.
					else
						c := i.to_character_32
					end
				else
						-- We ensure it fits into an extended ASCII.
					c := i.to_character_32
					if i = 255 then
						i := 47
					end
				end
				str.append_character (c)
				i := i + 1
			end

			txt.append_text (str)

				-- Ensure that selection is correct.
			from
				i := 1
				nb := txt.text_length
				assert ("valid length", nb = str.count)
			until
				i > nb
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

				txt.set_caret_position (i)
				assert ("no selection", not txt.has_selection)
				assert ("selected_text_empty", txt.selected_text.is_empty)
				assert ("caret position set", txt.caret_position = i)
				assert ("proper start selection", txt.start_selection = i)
				assert ("proper end selection", txt.end_selection = i)

					-- It is to slow to iterate over 65K+ of text,
					-- so we skip
				if i > 65535 then
					i := i + 100
				else
					i := i + 7919
				end
			end
			txt.set_selection (nb + 1, nb + 1)
			assert ("no selection", not txt.has_selection)
			assert ("selected_text_empty", txt.selected_text.is_empty)
			assert ("caret position set", txt.caret_position = nb + 1)
			assert ("proper start selection", txt.start_selection = nb + 1)
			assert ("proper end selection", txt.end_selection = nb + 1)

			window.prune (txt)
			txt.remove_text
			window.destroy
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
