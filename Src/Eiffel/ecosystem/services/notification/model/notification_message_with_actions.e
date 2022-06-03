note
	description: "[
			Message handled by service {NOTIFICATION_S}, with action associated with label.
			Such action labels, could be represented by a button or a link in the 
			notification widget.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_MESSAGE_WITH_ACTIONS

inherit
	NOTIFICATION_MESSAGE
		redefine
			make,
			to_archive
		end

create
	make

feature {NONE} -- Creation

	make (txt: READABLE_STRING_GENERAL; a_category: detachable READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			Precursor (txt, a_category)
			create actions.make (1)
		end

feature -- Access

	actions: STRING_TABLE [PROCEDURE]
			-- Action indexed by label.

feature -- Element change			

	register_action (a_action: PROCEDURE; a_label: READABLE_STRING_GENERAL)
			-- Register action `a_action` with title `a_label`.
		do
			actions [a_label] := a_action
		end

feature -- Conversion

	to_archive: NOTIFICATION_MESSAGE
		local
			s: STRING_32
		do
			Result := Precursor
			create s.make_from_string_general (text)
			across
				actions as ic
			loop
				s.append_character (' ')
				s.append_character ('[')
				s.append_string_general (@ ic.key)
				s.append_character (']')
			end
			Result.set_text (s)
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
