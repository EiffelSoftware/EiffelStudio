note
	description: "Summary description for {TEST_RSA_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RSA_API

inherit

	EQA_TEST_SET
		select
			default_create
		end
	SSL_SHARED
		rename
			default_create as default_create_ssl
		end

feature -- Tests

	test_sign_and_verify
		local
			l_rsa: SSL_RSA
			l_keypair: SSL_KEY_PAIR
			l_text : STRING
			l_priv_key: SSL_RSA_PRIVATE_KEY
			l_pub_key: SSL_RSA_PUBLIC_KEY
			l_digest: READABLE_STRING_8
		do
			initialize_ssl
				-- Generate keypair (public and private key)
			create l_keypair.make (2048)

				-- Text
			l_text := "Eiffel Programming Language"

				-- Create an object SSL_RSA and set pkcs1 padding.
			create l_rsa.make
			l_rsa.mark_pkcs1_padding

				-- Set private key using our generated key
			create l_priv_key.make (l_keypair.private_key)
				-- Set public key using our generated key
			create l_pub_key.make (l_keypair.public_key)


				-- Create a signed digest using RSA SHA 256
			l_digest := l_rsa.sha256_signed_message (l_priv_key, l_text)


				-- Signature Verification
			if attached l_digest then
				assert ("Expected True", l_rsa.is_sha256_verified (l_pub_key, l_text, l_digest) = True)
			else
				assert ("Not expected", False)
			end
		end


	test_encrypt_decrypt_pkcs1
		local
			l_rsa: SSL_RSA
			l_pub_key: SSL_RSA_PUBLIC_KEY
			l_priv_key: SSL_RSA_PRIVATE_KEY
			l_result: STRING
		do
			initialize_ssl
				-- mark_pkcs1_padding
			create l_rsa.make
			l_rsa.mark_pkcs1_padding
			public_key.adjust
			create l_pub_key.make (public_key)
			l_result := l_rsa.public_encrypt ("Eiffel", l_pub_key)
			private_key.adjust
			create l_priv_key.make (private_key)
			assert ("Expected Eiffel:", l_rsa.private_decrypt (l_result, l_priv_key).same_string ("Eiffel"))

		end


	test_encrypt_decrypt_oaep
		local
			l_rsa: SSL_RSA
			l_pub_key: SSL_RSA_PUBLIC_KEY
			l_priv_key: SSL_RSA_PRIVATE_KEY
			l_result: STRING
		do
			initialize_ssl
				-- rsa_pkcs1_oaep_padding
			create l_rsa.make
			public_key.adjust
			create l_pub_key.make (public_key)
			l_result := l_rsa.public_encrypt ("Eiffel", l_pub_key)
			private_key.adjust
			create l_priv_key.make (private_key)
			check Eiffel: l_rsa.private_decrypt (l_result, l_priv_key).same_string ("Eiffel") end
		end





feature -- Keys


	public_key: STRING = "[
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoRAce3WYYjXXxtbNRMAm
kC51JFl5Nrt8gAelT6xD58310cZTKv2EKxCuGhyioiP5s4SpUoRSHuiHWee1p1Ji
r/C726JhPfLn5pg1IAhqfBi0URItOKNkjyW2oaXQJY+ySIgFcFKi3HAhk7RI0iwj
5kf3p7Z8exOVfD80TAYeGpxEZ1DslEz0Vt8ch6jJZ8TtUqgIqFAl7BhDreae/GGw
2KGna17dOa9NVjbEKwchiu1FEjubg7DlFFMul2LQmMn+aKwQsF4a2ZfLeOOBCYNb
QP4ygE6M8AZ9V2RQ0vewXKd03Cic2VoiRlkIwTNTKgcgmn9NxbSjx9AF33ygzeVh
KwIDAQAB
-----END PUBLIC KEY-----
]"


	private_key: STRING = "[
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAoRAce3WYYjXXxtbNRMAmkC51JFl5Nrt8gAelT6xD58310cZT
Kv2EKxCuGhyioiP5s4SpUoRSHuiHWee1p1Jir/C726JhPfLn5pg1IAhqfBi0URIt
OKNkjyW2oaXQJY+ySIgFcFKi3HAhk7RI0iwj5kf3p7Z8exOVfD80TAYeGpxEZ1Ds
lEz0Vt8ch6jJZ8TtUqgIqFAl7BhDreae/GGw2KGna17dOa9NVjbEKwchiu1FEjub
g7DlFFMul2LQmMn+aKwQsF4a2ZfLeOOBCYNbQP4ygE6M8AZ9V2RQ0vewXKd03Cic
2VoiRlkIwTNTKgcgmn9NxbSjx9AF33ygzeVhKwIDAQABAoIBAQCaW8+APvZ5ATM4
HHsDrcgHnI6l9J4n501tgmZbUjSOPySdFB528BqwDz9cRR9Ul3fjJXwFWk091AqM
DnZY0qtEBUp1N01MyrSXmj4n4gjzv9VocSwnwOhKDJHYoAo5RVtPChV0Ta5J56k2
Xqz/yE/rjgN6l3j7l4xHVGexiJdnVeEmBHQum9eU66jxGpaO1N3XlFxQoLZWjV2P
8dPPybd+ibHgDJ7VKnrw1Ml9+tj/ZKqz7TSIEiZp4KCIGWM/wx/FITG2GDlcCSxF
H2WnHuZT7OFzHvnisbv9VgrtDUYdztJMNfkYiVq/rkf/jZh8anK6EKAfw/ti1fvK
aEAsLgkRAoGBAM+IZRCdVNqkpxOfmGdlaCEllTXhBEfvO3A6/KnKq6U0EPAnQVY5
ikHoxr0pWb2VXmQULb/q89BH4+0vPPI6Ed1w9PI2PxBlk6pNyqdXi0HnZXdS9+XO
q+z1dGk8Qe0j5ldNQFyaDkKE7h6CG9IWdpupjyPxAjiC+7uT4OFhwsYTAoGBAMat
dVx78IXI2eEQ5+pFdAwrTcTKTNZbTzO0+k2NUEyFarkkWrPGTqBCilgD1xcvf2gU
dZ5v+Sc4pvyrMzYnr4S3ANG3JBv9kd2v+JppVMgxQMTLzTtDqFxrVf3KGwv3lO/Y
8rAee+UAQkrXNlmeOrCCiMAMeoSkStNZJvr/UTuJAoGBALpvwrMxU/hzsHCtkCFa
9TfJ5oiXk9v3q8MACtmR668m3gyQh16ppG3fayKmUitBU6G+ivb9YHj9DGKYbD0D
M+dmQXaSiwb06bo11leNCtpywTF4BKGbj9H5E9IyQtuBw70r9iT6dNMHTk9z/QA4
E+d1ZNUZ/y+7Y+A4Ue7Hf02nAoGAfB67tkab0gjTzV7RdDNlt4CKOkokTLqItYX3
5eFF7Dhhnz7OB4f5cPeBFFF527tJvk0h2hScNFuZPzr5aHjMl3343gurXG1C5ptc
FaN+Wv8iNpAYLFEtameINmBAG27WNi10GIFC56MMx1LCWqSWh9VU954UIK+/K2CE
EMTXC/kCgYBOxRchdW9EukGnT6owPex67wBnhxWL1wCrPouTpfyUsfC/XD12LDSX
52fhydJSOlWGvDYOIWFh6x0rqNJu2kuF6LGt9me5/2zV8VTRRNJNSc6MMdFxDPj5
fjIbXqHiJNWCTHY+f31V1h+sT2iibcXop/FvMsCZGpvr8KK3X4kHsA==
-----END RSA PRIVATE KEY-----
]"

	verify_with_sha256_imp (a_text: READABLE_STRING_GENERAL; a_signed: READABLE_STRING_8; a_pub_key: SSL_RSA_PUBLIC_KEY): BOOLEAN
		local
			l_buffer: C_STRING
			l_message: C_STRING
			l_sign: C_STRING
			l_res: INTEGER
			l_temp: STRING
			l_error: SSL_ERROR
		do
			create l_buffer.make_empty ({SSL_CRYPTO_EXTERNALS}.SHA256_DIGEST_LENGTH)
			create l_message.make (a_text)
			{SSL_CRYPTO_EXTERNALS}.c_sha256 (l_message.item, l_message.count, l_buffer.item)

			l_temp := (create {BASE64}).decoded_string (a_signed)
			l_temp.append_character ('%U')
			create l_sign.make (l_temp)
			l_res := {SSL_CRYPTO_EXTERNALS}.c_rsa_verify ({SSL_CRYPTO_EXTERNALS}.nid_sha256, l_buffer.item, l_sign.item, {SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_pub_key.rsa), a_pub_key.rsa);
			if l_res /= 1 then
				create l_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
			else
				Result := True
			end
		end


note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
