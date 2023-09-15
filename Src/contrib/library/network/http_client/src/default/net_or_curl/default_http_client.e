note
	description: "[
			Default HTTP_CLIENT based on LIBCURL_HTTP_CLIENT or NET_HTTP_CLIENT or CURL_HTTP_CLIENT.
			
			The preference goes to libcurl implementation for now,
			since the net implementation has currently less functionalities.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEFAULT_HTTP_CLIENT

inherit
	DEFAULT_HTTP_CLIENT_I
		redefine
			force_default_client
		end

feature -- Access

	new_session (a_base_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
			-- Create a new session using `a_base_url'.
		local
			cl: HTTP_CLIENT
		do
			cl := forced_default_client
			if cl /= Void then
				Result := cl.new_session (a_base_url)
			end
			if Result = Void or else not Result.is_available then
					--| For now, try libcurl first, and then net
					--| the reason is the net implementation is still in progress.
				create {NET_HTTP_CLIENT} cl
				Result := cl.new_session (a_base_url)
				if not Result.is_available then
					create {CURL_HTTP_CLIENT} cl
					Result := cl.new_session (a_base_url)
				end
			end
		end

feature {NONE} -- Implementation

	forced_default_client: detachable HTTP_CLIENT
			-- Forced default client, if any is forced.

feature -- Change

	force_default_client (a_cl_name: detachable READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			cl: HTTP_CLIENT
		do
			if a_cl_name /= Void then
				if a_cl_name.is_case_insensitive_equal ("net") then
					cl := Void -- Already the default
				elseif a_cl_name.is_case_insensitive_equal ("curl") then
					create {CURL_HTTP_CLIENT} cl
				end
			end
			forced_default_client := cl
		end

note
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
