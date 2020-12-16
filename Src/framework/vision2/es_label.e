note
	description: "Objects that represents a label with word wrapping preserving original line breaks."
	upgrade: "It might be good to use EVS_LABEL instead, but they are not really compatible."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LABEL

inherit
	EV_LABEL
		redefine
			create_interface_objects,
			initialize
		end

	EV_SHARED_APPLICATION
		undefine
			copy,
			default_create
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create {STRING_32} original_text.make_empty
			Precursor
		end

	make (t: READABLE_STRING_GENERAL)
			-- Initialize label with text `t'.
		require
			valid_t: not t.has ('%R')
		do
			default_create
			set_and_wrap_text (t)
		end

	initialize
			-- <Precursor>
		do
			Precursor
			resize_actions.extend
				(agent (x, y, w, h: INTEGER_32)
					do
						refresh_wrapped_text
					end)
			dpi_changed_actions.extend
				(agent (a_dpi: NATURAL_32; x, y, w, h: INTEGER_32)
					do
						refresh_wrapped_text
					end)

		end

feature -- Element change

	set_and_wrap_text (a_text: READABLE_STRING_GENERAL)
			-- Set `text' to `a_text' and enable word wrapping.
		require
			valid_a_text: not a_text.has ('%R')
		do
			if not minimum_width_set_by_user then
				set_minimum_width (0)
			end
				-- Record original text to keep new lines.
			original_text := a_text
				-- Update text visualization.
			refresh_wrapped_text
		end

feature {NONE} -- Access

	original_text: READABLE_STRING_GENERAL
			-- Original text set for this label.
			-- It is used to preserve new lines of the original text.

feature {NONE} -- State

	previous_lines: detachable ARRAYED_LIST [STRING_32]
			-- Previously generated lines for word wrapping.

feature {ES_SCROLLABLE_LABEL} -- Update

	refresh_wrapped_text
			-- Display `text' as a wrapped text.
			-- Preserve line breaks in `original_text'.
		local
			l_previous_lines: like previous_lines
			l_counter, l_last_counter: INTEGER
			l_current_width: INTEGER
			l_last_string: detachable STRING_32
			l_temp_string: STRING_32
			l_modified_text: STRING_32
			l_lines: ARRAYED_LIST [STRING_32]
			l_start_pos: INTEGER
			l_output: STRING_32
			l_maximum_string_width: INTEGER
			l_lines_changed: BOOLEAN
			l_all_space_indexes: ARRAYED_LIST [INTEGER]
			l_font: detachable like font
			n: INTEGER
		do
			create l_all_space_indexes.make (20)
			create l_lines.make (4)
			create l_modified_text.make_from_string_general (original_text)
			l_modified_text.append_character (' ')
			l_maximum_string_width := width
			if l_maximum_string_width < 0 then
				 l_maximum_string_width := 0
			end

				-- Set up all space indexes which stores the index of each space in the
				-- text, as these are the wrapping criterion.
				-- Note that if a word is contained that is longer than the width of the label,
				-- this will probable lead to problems. No attempt to prevent this is made in the code.
			from
				l_counter := 1
				n := l_modified_text.count
			until
				l_counter > n
			loop
				inspect l_modified_text [l_counter]
				when ' ', '%N' then
						-- Words can also be separated by new lines.
					l_all_space_indexes.extend (l_counter)
				else
				end
				l_counter := l_counter + 1
			end

				-- Perform calculations to determine where wrapping must occur.
			from
				l_start_pos := 1
				l_last_counter := 0
				l_counter := 1
			until
				l_counter > l_all_space_indexes.count
				or l_counter <= l_last_counter
			loop
				from
					l_current_width := 0
					l_last_string := {STRING_32} ""
				until
						-- Wrap at long strings.
					l_current_width > l_maximum_string_width or
						-- Stop at end.
					l_counter > l_all_space_indexes.count
				loop
					l_temp_string := l_modified_text.substring (l_start_pos, l_all_space_indexes.i_th (l_counter) - 1)
					if l_font = Void then
						l_font := font
					end
					l_current_width := l_font.string_width (l_temp_string)
					if l_current_width <= l_maximum_string_width then
							-- The string is still short enough.
							-- Record it.
						l_last_string := l_temp_string
							-- Look for new lines.
						if l_modified_text [l_all_space_indexes [l_counter]] = '%N' then
								-- Wrap at new lines.
								-- Pretend that a text is long enough to exit from the loop.
							l_current_width := l_maximum_string_width + 1
						else
								-- Attempt to add some more words.
							l_counter := l_counter + 1
						end
					elseif l_last_string.is_empty then
							-- The string starts with just one long word, no way to wrap it, so use it.
						l_last_string := l_temp_string
					else
							-- The string is longer than visible area and has more than one word, wrap it.
						l_counter := l_counter - 1
					end
				end

				if l_counter < l_all_space_indexes.count then
					l_start_pos := l_all_space_indexes.i_th (l_counter) + 1
				end
				if l_counter > l_last_counter then
					l_last_counter := l_counter
					l_counter := l_counter + 1
				end

				l_lines.extend (l_last_string)
			end

				-- Too small?  => Increase width.
			if l_counter <= l_all_space_indexes.count then
				set_minimum_width (width + 10)
			else
					-- Now determine if the contents of the line have actually changed.
					-- If they have not, then there is no need to set the text again, as it
					-- causes flicker.
				l_previous_lines := previous_lines
				if l_previous_lines = Void or else l_lines.count /= l_previous_lines.count then
					l_lines_changed := True
				elseif l_previous_lines /= Void then
					from
						l_lines.start
						l_previous_lines.start
					until
						l_lines_changed or l_lines.after
					loop
						check
							not_previous_after: not l_previous_lines.after
						end
						l_lines_changed := l_lines.item.count /= l_previous_lines.item.count
						l_previous_lines.forth
						l_lines.forth
					end
				end

					-- Now create and set the text on the label if
					-- it needs to be changed.
				if l_lines_changed then
					create l_output.make_empty
					from
						l_lines.start
					until
						l_lines.after
					loop
						l_output.append (l_lines.item)
						if l_lines.index < l_lines.count then
							l_output.append_character ('%N')
						end
						l_lines.forth
					end
					previous_lines := l_lines

					set_text (l_output)
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
