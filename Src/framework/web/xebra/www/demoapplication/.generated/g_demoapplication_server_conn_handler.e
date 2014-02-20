note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_DEMOAPPLICATION_SERVER_CONN_HANDLER

inherit
	XWA_SERVER_CONN_HANDLER

create
	make

feature-- Access

feature-- Implementation

	add_servlets
			--<Precursor>
		do
			stateless_servlets.put (create {G_RESERVATIONS_SERVLET}.make, "/demoapplication/reservations.xeb")
			stateless_servlets.put (create {G_UPLOAD_RCV_SERVLET}.make, "/demoapplication/upload_rcv.xeb")
			stateless_servlets.put (create {G_DELETE_SERVLET}.make, "/demoapplication/delete.xeb")
			stateless_servlets.put (create {G_LOGOUT_SERVLET}.make, "/demoapplication/logout.xeb")
			stateless_servlets.put (create {G_INDEX_SERVLET}.make, "/demoapplication/index.xeb")
			stateless_servlets.put (create {G_UPLOAD_SERVLET}.make, "/demoapplication/upload.xeb")
			stateless_servlets.put (create {G_CONTACT_SERVLET}.make, "/demoapplication/contact.xeb")
			stateless_servlets.put (create {G_LOGIN_SERVLET}.make, "/demoapplication/login.xeb")
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
		]"end
