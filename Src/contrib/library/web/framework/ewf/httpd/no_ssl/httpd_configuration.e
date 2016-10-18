note
	description: "Standalone server configuration (ssl NOT supported)."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_CONFIGURATION

inherit
	HTTPD_CONFIGURATION_I

create
	make

feature -- Status

	Server_details: STRING_8 = "Server: Standalone Eiffel Server"

	has_secure_support: BOOLEAN = False
			-- Precursor

feature -- SSL Helpers

	set_secure_protocol_to_ssl_2_or_3
			-- Set `secure_protocol' with `Ssl_23'.
		do
				-- Ignored
		end


	set_secure_protocol_to_tls_1_0
			-- Set `secure_protocol' with `Tls_1_0'.
		do
				-- Ignored
		end

	set_secure_protocol_to_tls_1_1
			-- Set `secure_protocol' with `Tls_1_1'.
		do
				-- Ignored
		end

	set_secure_protocol_to_tls_1_2
			-- Set `secure_protocol' with `Tls_1_2'.
		do
				-- Ignored
		end

	set_secure_protocol_to_dtls_1_0
			-- Set `secure_protocol' with `Dtls_1_0'.
		do
				-- Ignored
		end


note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
