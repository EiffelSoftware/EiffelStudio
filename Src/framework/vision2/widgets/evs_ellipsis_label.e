note
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_ELLIPSIS_LABEL

inherit
	EV_LABEL
		redefine
			set_text,
			refresh_now,
			create_interface_objects,
			initialize
		end

create
	default_create,
	make_with_text

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			create original_text.make_empty
		end

	initialize
		local
			agt: like update_agent
			dagt: like dpi_update_agent
		do
			Precursor
			agt := update_agent
			if agt = Void then
				agt := agent (i_x: INTEGER; i_y: INTEGER; i_width: INTEGER; i_height: INTEGER)
						do
							update
						end
				update_agent := agt
				resize_actions.extend (agt)
			elseif not resize_actions.has (agt) then
				resize_actions.extend (agt)
			end

			dagt :=dpi_update_agent
			if dagt = Void then
				dagt := agent (i_dpi: NATURAL_32; i_x: INTEGER; i_y: INTEGER; i_width: INTEGER; i_height: INTEGER)
						do
							update
						end
				dpi_update_agent := dagt
				dpi_changed_actions.extend (dagt)
			elseif not dpi_changed_actions.has (dagt) then
				dpi_changed_actions.extend (dagt)
			end
		end

	update_agent: detachable PROCEDURE [TUPLE [i_x: INTEGER; i_y: INTEGER; i_width: INTEGER; i_height: INTEGER]]
	dpi_update_agent: detachable PROCEDURE [TUPLE [i_dpi: NATURAL_32; i_x: INTEGER; i_y: INTEGER; i_width: INTEGER; i_height: INTEGER]]

feature -- Settings

	is_ellipsing_character: BOOLEAN assign set_is_ellipsing_character
			-- Ellipsing at character level?
			-- i.e  if True "once upon a time", would be ellipsed (for 6 chars) as  "once up...",
			--		else as "once..."

feature -- Settings change

	set_is_ellipsing_character (b: BOOLEAN)
		do
			is_ellipsing_character := b
		end

feature -- Basic operation

	refresh_now
		do
			update
			Precursor
		end

	update
		local
			l_original_text: like original_text
			l_text_w: INTEGER
			l_3dots_w: INTEGER
			l_available_w: INTEGER
			t: STRING_32
		do
			l_original_text := original_text
			l_text_w := font.string_width (l_original_text)
			if l_text_w > width then
				l_3dots_w := font.string_width (ellipsis_text)
				l_available_w := width - l_3dots_w

				t := ellipsed_text_within_width (l_available_w)
				set_text (t + ellipsis_text)
				original_text := l_original_text
			else
				set_text (l_original_text)
			end
		end

	ellipsed_text_within_width (a_available_width: INTEGER): STRING_32
		local
			l_words: like split_words
			w: INTEGER
			ft: like font
			l_done: BOOLEAN
			l_remaining_width: INTEGER
			i,n: INTEGER
			l_first_word: detachable READABLE_STRING_32
		do
			create Result.make (0)
			ft := font
			if is_ellipsing_character then
				l_first_word := original_text
			else
				l_words := split_words (original_text)
				l_remaining_width := a_available_width
				across
					l_words as ic
				until
					l_done
				loop
					if l_first_word = Void then
						l_first_word := ic
					end
					w := ft.string_width (ic)
					if w < l_remaining_width then
						Result.append (ic)
						l_remaining_width := l_remaining_width - w
					else
						l_done := True
					end
				end
			end
			if Result.is_empty and then l_first_word /= Void then
				from
					l_remaining_width := a_available_width
					l_done := False
					i := 1
					n := l_first_word.count
				until
					i > n or l_done
				loop
					w := ft.string_width (l_first_word.head (i))
					if w < a_available_width then
						Result.extend (l_first_word[i])
					end
					i := i + 1
				end
			end
		end

feature -- Element change

	set_text (a_text: separate READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			Precursor (a_text)
			create original_text.make_from_separate (a_text)
		end

feature {NONE} -- Implementation

	original_text: IMMUTABLE_STRING_32

	ellipsis_text: IMMUTABLE_STRING_32
		do
			Result := internal_ellipsis_text
			if Result = Void or else Result.is_whitespace then
				create Result.make_from_string_32 ({STRING_32} "%/8230/")
				internal_ellipsis_text := Result
			end
		end

	internal_ellipsis_text: detachable like ellipsis_text

feature {NONE} -- Line analysis

	split_words (a_line: READABLE_STRING_32): ARRAYED_LIST [READABLE_STRING_32]
			-- Splits a line of text into words and whitespace
			--
			-- `a_line': A line of text to split into words
			-- `Result': An array of words (non-whitespace) and whitespace character sequences.
		require
			a_line_attached: a_line /= Void
		local
			l_word: STRING_32
			l_count, i: INTEGER
			c: CHARACTER_32
			l_last_is_space: BOOLEAN
		do
			create Result.make (0)
			if not a_line.is_empty then
				create l_word.make (24)
				from
					i := 1
					l_count := a_line.count
				until
					l_count < i
				loop
						-- We take code > 255 as non space.
						-- This needs to improve when Unicode `is_space' is ready.
					l_last_is_space := (c.is_character_8 and then c.is_space)
					c := a_line.item (i)
					if i > 1 and then (c.is_character_8 and then c.is_space) /= l_last_is_space then
						Result.extend (l_word)
						create l_word.make (24)
					end
					l_word.append_character (c)
					i := i + 1
				end
				Result.extend (l_word)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: a_line.is_empty = Result.is_empty
			result_contains_valid_items: across Result as ic all not ic.is_empty end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
