note
	description: "List of conditions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITION_LIST

inherit
	ARRAYED_LIST [CONF_CONDITION]
		redefine
			make
		end

create
	make

create {CONF_CONDITION_LIST}
	make_filled

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Create.
		do
			Precursor {ARRAYED_LIST} (n)
			compare_objects
		end

feature -- Output

	text: STRING_32
			-- Text representation of the conditions.
		local
			l_cursor: ARRAYED_LIST_CURSOR
		do
			l_cursor := cursor
			create Result.make_empty
			from
				start
			until
				after
			loop
				Result.append ({STRING_32} "(")
				Result.append (item.text)
				Result.append ({STRING_32} ") or ")
				forth
			end
			if not Result.is_empty then
				Result.remove_tail (4)
			end
			if valid_cursor (l_cursor) then
				go_to (l_cursor)
			end
		ensure then
			Result_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
