note
	description: "[
			layout entry of a grid ...
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_LAYOUT_ITEM

inherit
	ANY

	DEBUG_OUTPUT

create
	make,
	make_with_details

feature {NONE} -- Initialization

	make (a_id: like id)
		do
			id := a_id
		end

	make_with_details (a_id: like id; a_subrows: like subrows; a_value: like value; a_is_visible_row: BOOLEAN)
		do
			make (a_id)
			subrows := a_subrows
			value := a_value
			is_visible_row := a_is_visible_row
		end

feature -- Access

	id: STRING_32

	subrows: detachable LIST [detachable ES_GRID_LAYOUT_ITEM]

	value: detachable ANY assign set_value

	is_visible_row: BOOLEAN

feature -- Element change

	set_value (v: like value)
		do
			value := v
		end

feature -- Status report

	debug_output: STRING_32
		do
			create Result.make (100)
			Result.append_character ('[')
			if is_visible_row then
				Result.append_character ('|')
			end
			Result.append (id)
			if attached subrows as lst then
				Result.append_character ('{')
				across
					lst as c
				loop
					if attached c as l_c_item then
						Result.append (l_c_item.debug_output)
					else
						Result.append ("Void")
					end
					Result.append_character ('%N')
				end
				Result.append_character ('}')
			else
				Result.append (" Void ")
			end
			if attached value as v then
				Result.append (v.out)
			end
			Result.append_character (']')
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
