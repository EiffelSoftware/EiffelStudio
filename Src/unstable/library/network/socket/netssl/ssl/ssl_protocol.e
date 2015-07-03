note
	description: "Constants for SSL/TLS protocols."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=TLS", "src=http://en.wikipedia.org/wiki/Transport_Layer_Security", "protocol=uri"
	EIS: "name=SSL", "src=http://en.wikipedia.org/wiki/SSL", "protocol=uri"

class
	SSL_PROTOCOL

feature -- Access

	Ssl_23: NATURAL = 1
		-- Ssl version 3 but can rollback to version 2.

	Tls_1_0: NATURAL = 3
		-- Tls version 1.

	Tls_1_1: NATURAL = 4
		-- Tls version 1.1.

	Tls_1_2: NATURAL = 5
		-- Tls version 1.2.

	Dtls_1_0: NATURAL = 6
		-- Dtls version 1.0.	

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
