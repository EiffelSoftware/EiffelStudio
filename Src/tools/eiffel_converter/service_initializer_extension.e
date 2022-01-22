note
	description: "An extension to initialize more command-line services in addiion to standard services of the compiler."

class
	SERVICE_INITIALIZER_EXTENSION

inherit
	SERVICE_INITIALIZER
		redefine
			add_core_services
		end

feature -- Services

	add_core_services (c: SERVICE_CONTAINER_S)
			-- <Precursor>
		do
			Precursor (c)
			c.register_with_activator ({COMMAND_LINE_OPTION_EXTENSION_S}, agent new_command_line_option_service, False)
		end

feature {NONE} -- Factory

	new_command_line_option_service: COMMAND_LINE_OPTION_EXTENSION_S
			-- New command-line option service.
		do
			create {EC_COMMAND_LINE_OPTION_EXTENSION} Result
		ensure
			is_interface_usable: attached Result implies Result.is_interface_usable
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	author: "Alexander Kogtenkov"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
	licensing_options: "http://www.eiffel.com/licensing"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
