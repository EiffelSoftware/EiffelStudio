note
	description: "[
		Deferred class which defines all the {SERVLET_ELEMENT}s generated directly
		from the xeb-page
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OUTPUT_ELEMENT

inherit
	SERVLET_ELEMENT

feature -- Initialisation

	make_empty
		-- All string attributes are initialized empty
		do
			controller_var := ""
			response_name := ""
			response_var := ""
		end

feature -- Access

	controller_var: STRING
			-- Variable name of the controller

	response_var: STRING
			-- Variable name of the response

	response_name: STRING
			-- The response variable name

feature -- Status Setting

	set_controller_var (a_name: STRING)
			-- Sets the name of the controller variable
		require
			a_name_is_valid: not a_name.is_empty
		do
			controller_var := a_name
		end

	set_response_var (a_name: STRING)
			-- Sets the name of the response variable
		require
			a_name_is_valid: not a_name.is_empty
		do
			response_var := a_name
		end

	set_response_name(a_name: STRING)
			-- Sets the response variable name.		
		require
			name_not_empty: not a_name.is_empty
		do
			response_name := a_name
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
