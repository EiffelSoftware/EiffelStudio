note
	description: "Summary description for {TEST_SSL_PROTOCOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SSL_PROTOCOL

inherit

	EQA_TEST_SET


feature -- Test New Procotol Constants

	test_ssl_protocol
		do
			assert ("Exptected SSL3_VERSION True", {SSL_PROTOCOL}.Ssl_23 = {SSL_PROTOCOL}.SSL3_VERSION )
			assert ("Exptected TLS1_VERSION True", {SSL_PROTOCOL}.Tls_1_0 = {SSL_PROTOCOL}.TLS1_VERSION )
			assert ("Exptected TLS1_1_VERSION True", {SSL_PROTOCOL}.Tls_1_1 = {SSL_PROTOCOL}.TLS1_1_VERSION )
			assert ("Exptected TLS1_2_VERSION True", {SSL_PROTOCOL}.Tls_1_2 = {SSL_PROTOCOL}.TLS1_2_VERSION )
			assert ("Exptected DTLS1_VERSION True", {SSL_PROTOCOL}.DTls_1_0 = {SSL_PROTOCOL}.DTLS1_VERSION )
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
