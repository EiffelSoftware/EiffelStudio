note
	description: "Assembly open error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_ASOP

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (an_assembly: READABLE_STRING_GENERAL; a_parent_target: READABLE_STRING_GENERAL)
			-- Create.
		require
			an_assembly_not_void: an_assembly /= Void
		local
			l_text: STRING_32
		do
			create l_text.make (256)
			l_text.append_string_general ("Could not open assembly: ")
			l_text.append_string_general (an_assembly)
			l_text.append_string_general ("%Nin configuration file: ")
			l_text.append_string_general (a_parent_target)
			l_text.append_character ('.')
			text := l_text
		end

feature -- Access

	text: READABLE_STRING_32;
		-- Error text.

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
