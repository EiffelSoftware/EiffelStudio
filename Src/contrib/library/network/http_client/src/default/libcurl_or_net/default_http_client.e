note
	description: "[
			Default HTTP_CLIENT based on LIBCURL_HTTP_CLIENT or NET_HTTP_CLIENT.
			
			The preference goes to libcurl implementation for now,
			since the net implementation has currently less functionalities.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEFAULT_HTTP_CLIENT

inherit
	HTTP_CLIENT

feature -- Access

	new_session (a_base_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
			-- Create a new session using `a_base_url'.
		local
			libcurl: LIBCURL_HTTP_CLIENT
			net: NET_HTTP_CLIENT
		do
				--| For now, try libcurl first, and then net
				--| the reason is the net implementation is still in progress.
			create libcurl
			Result := libcurl.new_session (a_base_url)
			if not Result.is_available then
				create net
				Result := net.new_session (a_base_url)
			end
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
