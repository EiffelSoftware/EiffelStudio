note
	description: "Two different configuration files have the same uuid."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_UUIDFILE

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_first_target_context, a_first_location, a_second_target_context, a_second_location: STRING_32)
			-- Create.
		require
			a_first_context_not_void: a_first_target_context /= Void
			a_first_location_not_void: a_first_location /= Void
			a_second_context_not_void: a_second_target_context /= Void
			a_second_location_not_void: a_second_location /= Void
		local
			l_text: STRING_32
		do
			create l_text.make (256)
			l_text.append_string_general ("Two different configuration files share the same UUID. In configuration:%N ")
			l_text.append (a_first_target_context)
			l_text.append_string_general ("%Nthe following reference:%N ")
			l_text.append (a_first_location)
			l_text.append_string_general ("%Nhas the same UUID as the configuration file:%N ")
			l_text.append (a_second_location)
			l_text.append_string_general ("%Nreferenced from:%N ")
			l_text.append (a_second_target_context)
			l_text.append_string_general (".")
			text := l_text
		end

feature -- Access

	text: READABLE_STRING_32;
		-- Error text.

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
