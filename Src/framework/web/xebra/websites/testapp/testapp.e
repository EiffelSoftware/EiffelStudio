note
	description: "[
		No comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTAPP_SERVLET

inherit
	SERVLET

create
	make

feature-- Access

	controller: TESTAPP_CONTROLLER

feature-- Implementation

	make
		do
			create controller.make
		end

	handle_request (request: REQUEST): RESPONSE
		local
			response: RESPONSE
		do
			create response.make
			response.append ("[
				<html><head><title>Sample Application XEBRA Page</title></head><body bgcolor=white><table border="0"><tr><td align=center><img src="images/tomcat.gif"></td><td><h1>Sample Application XEBRA Page</h1>This is the output of a XEBRA page that is part of the Hello, Worldapplication.</td></tr></table>
			]")
			response.put_string (controller.give_me_a_hello)
			response.append ("[
				</body></html>
			]")
			Result := response
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
