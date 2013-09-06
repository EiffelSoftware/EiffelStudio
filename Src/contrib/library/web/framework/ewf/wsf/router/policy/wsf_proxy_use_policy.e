note

	description: "[
						Policies that determine if the client must use a proxy server
						 to access the resource.

						The default policy implemented here is to require
						 use of the proxy for HTTP/1.0 clients (only) for all requests.
						]"

	date: "$Date$"
	revision: "$Revision$"

deferred class WSF_PROXY_USE_POLICY

feature -- Access

	requires_proxy (req: WSF_REQUEST): BOOLEAN
			-- Does `req' require use of `proxy_server'?
		require
			req_attached: req /= Void
		local
			l_version: WSF_HTTP_PROTOCOL_VERSION
		do
				--| This default version just replies True for HTTP/1.0.
				--| For HTTP/0.9 or other protocols, we hope
				--| that the connector has already rejected the request. Anyway, a
				--| proxy server won't help us (? - is that correct?)
			create l_version.make (req.server_protocol)
			if
				l_version.is_valid and then
				l_version.major = 1 and then
			 	l_version.minor = 0
			then
				Result := True
			end
		end

	proxy_server (req: WSF_REQUEST): URI
			-- Absolute URI of proxy server which `req' must use
		require
			req_attached: req /= Void
			proxy_required: requires_proxy (req)
		deferred
		ensure
			proxy_server_attached: Result /= Void
			valid_uri: Result.is_valid
			absolute_uri: not Result.scheme.is_empty
			http_or_https: Result.scheme.is_case_insensitive_equal ("http") or
				Result.scheme.is_case_insensitive_equal ("https")
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
