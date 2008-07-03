indexing
	description: "Objects that represents a label with word wrapping."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LABEL

obsolete
	"Use {EVS_LABEL} instead"

inherit
	EV_LABEL

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

create
	default_create

feature -- Element change

	set_and_wrap_text (a_text: STRING_GENERAL) is
			-- Set `text' to `a_text' and enable word wrapping.
		local
			l_no_width: BOOLEAN
		do
			if not minimum_width_set_by_user then
				set_minimum_width (0)
				l_no_width := True
			end
			set_text (a_text)
			if not l_no_width then
				refresh_wrapped_text
			end
			resize_actions.force_extend (agent refresh_wrapped_text)
		end

feature {NONE} -- Implementation

	previous_lines: ARRAYED_LIST [STRING_32];
			-- Previously generated lines for word wrapping.

	refresh_wrapped_text is
			-- Display `text' as a wrapped text.
			-- Replace all '%N' characters as spaces.
		require
			width_big_enough: width > 0
		local
			l_counter, l_last_counter: INTEGER
			l_current_width: INTEGER
			l_last_string: STRING_32
			l_temp_string: STRING_32
			l_modified_text: STRING_32
			l_lines: ARRAYED_LIST [STRING_32]
			l_start_pos: INTEGER
			l_output: STRING_32
			l_maximum_string_width: INTEGER
			l_lines_changed: BOOLEAN
			l_all_space_indexes: ARRAYED_LIST [INTEGER]
			l_font: like font
		do
			create l_all_space_indexes.make (20)
			create l_lines.make (4)
			l_modified_text := text.twin
			l_modified_text.replace_substring_all ("%N", " ")
			l_modified_text.append_character (' ')
			l_maximum_string_width := width - 10
			if l_maximum_string_width < 0 then
				 l_maximum_string_width := 0
			end

				-- Set up all space indexes which stores the index of each space in the
				-- text, as these are the wrapping criterion.
				-- Note that if a word is contained that is longer than the width of the label,
				-- this will probable lead to problems. No attempt to prevent this is made in the code.
			from
				l_counter := l_modified_text.index_of (' ', 1)
			until
				l_counter = 0
			loop
				l_all_space_indexes.extend (l_counter)
				l_counter := l_modified_text.index_of (' ', l_counter + 1)
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
				until
					l_current_width > l_maximum_string_width or
					l_counter > l_all_space_indexes.count
				loop
					l_temp_string := l_modified_text.substring (l_start_pos, l_all_space_indexes.i_th (l_counter) - 1)
					if l_font = Void then
						l_font := font
					end
					l_current_width := l_font.string_width (l_temp_string)
					if l_current_width <= l_maximum_string_width then
						l_last_string := l_temp_string
						l_counter := l_counter + 1
					else
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

				-- to small? => increase width
			if l_counter <= l_all_space_indexes.count then
				set_minimum_width (width + 10)
			else
					-- Now determine if the contents of the line have actually changed.
					-- If they have not, then there is no need to set the text again, as it
					-- causes flicker.
				if previous_lines = Void or else l_lines.count /= previous_lines.count then
					l_lines_changed := True
				else
					from
						l_lines.start
						previous_lines.start
					until
						l_lines_changed or l_lines.after
					loop
						check
							not_previous_after: not previous_lines.after
						end
						l_lines_changed := l_lines.item.count /= previous_lines.item.count
						previous_lines.forth
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
