note
	description: "Communication Support Response"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SUPPORT_RESPONSE

create
	make

feature {NONE} -- Initialization

	make (a_href: like href; h: like http_response; a_status: like status; a_cj: like collection)
			-- Initialize object with href `a_ref', response `h', status `a_status' and collection json `a_cj'.
		do
			href := a_href
			http_response := h
			status := a_status
			collection := a_cj
		ensure
			href_set: href = a_href
			http_response_set: http_response = h
			status_set: status = a_status
			collection_set: collection = a_cj
		end

feature -- Access

	href: READABLE_STRING_8
		-- URL, which is the actual link.

	http_response: READABLE_STRING_8
		-- Http server response message after receiving and interpret a request message.
		--! to the given href url.

	status: INTEGER
		-- Status code.

	collection: detachable CJ_COLLECTION
		-- Collection json representation.


;note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
