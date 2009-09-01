note
	description: "[
		Creates a MINI_REQUEST from a request_message
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST_MINI_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature -- Access

	request (a_request_message: STRING): detachable XH_MINI_REQUEST
			-- Returns a XH_REQUEST if the message could be parsed successfully
		require
			not_a_request_message_is_detached_or_empty: a_request_message /= Void and then not a_request_message.is_empty
		local
			l_message: STRING
		do
			create Result.make_empty
			l_message := a_request_message.twin
			if l_message.has_substring ({XU_CONSTANTS}.Request_post_too_big) then
				Result.set_post_too_big (True)
			end
			if l_message.has_substring ({XU_CONSTANTS}.Request_http) and l_message.has ('/') then
				l_message.remove_tail ( l_message.substring_index ({XU_CONSTANTS}.Request_http, 1))
				Result.set_webapp (l_message.split ('/').i_th (2))
			end
		end
feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

invariant

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

