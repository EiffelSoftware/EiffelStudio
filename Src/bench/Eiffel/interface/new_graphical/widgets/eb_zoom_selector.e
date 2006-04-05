indexing
	description: "Objects that lets the user select a zoom level"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ZOOM_SELECTOR

inherit
	EV_COMBO_BOX

create
	make_default

feature -- Initialization

	make_default is
			-- Initialize with "100%" as zoom level.
		do
			make_with_strings (Initial_strings)
			remove_selection
			set_text ("100%%")
			set_minimum_width_in_characters (5)
			return_actions.extend (agent on_zoom_level_typed)
		end

feature -- Element change

	show_as_text (i: INTEGER) is
			-- Replace and show `i' %.
		require
			i_in_range: i > 0
		local
			l_text: like text
		do
			remove_selection
			create l_text.make (5)
			l_text.append_integer (i)
			l_text.append_character ('%%')
			set_text (l_text)
		end

	add_and_show (i: INTEGER) is
			-- Add and show `i' %.
		require
			i_in_range: i > 0
		local
			tmp: like strings_8
			l_text: like text
		do
			create l_text.make (5)
			l_text.append_integer (i)
			l_text.append_character ('%%')
			tmp := strings_8
			tmp.compare_objects
			if tmp.has (l_text) then
				tmp.prune_all (l_text)
			end
			tmp.put_front (l_text)
			set_strings (tmp)
		end

feature {NONE} -- Events

	on_zoom_level_typed is
			-- A view name was typed in `Current' text field.
		local
			l_text: like text
			new_val: INTEGER
		do
			l_text := text.twin

			if l_text.is_integer then
				new_val := l_text.to_integer
				if new_val > 5 then
					add_and_show (new_val)
				end
			end
		end

feature {NONE} -- Implementation

	initial_strings: ARRAY [STRING] is
			-- Initial list items.
		once
			create Result.make (1, 9)
			Result.put ("1000%%", 1)
			Result.put ("500%%", 2)
			Result.put ("250%%", 3)
			Result.put ("200%%", 4)
			Result.put ("100%%", 5)
			Result.put ("75%%", 6)
			Result.put ("50%%", 7)
			Result.put ("25%%", 8)
			Result.put ("10%%", 9)
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

end -- class EB_ZOOM_SELECTOR
