note
	description: "[
		Provides a means to create different types of requests.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST_BUILDER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Access

feature -- Basic operations

	create_goto_request (a_url: STRING; a_previous_request: XH_REQUEST): XH_REQUEST
			-- Creates a goto request
		require
			not_a_url_is_detached_or_empty: a_url /= Void and then not a_url.is_empty
			a_previous_request_attached: a_previous_request /= Void
		local
			l_parser: XH_REQUEST_PARSER
			l_temp: STRING
		do
			create Result.make_empty
			create l_parser.make

			l_temp := a_previous_request.method + " " + a_url + " " + a_previous_request.request_message.split (' ').i_th (3)
			if attached {XH_REQUEST} l_parser.request (l_temp) as l_rec then
				Result := l_rec
			end
		ensure
			result_attached: Result /= Void
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
