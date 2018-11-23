note
	description: "test application root class"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ECSA", "src=https://www.openssl.org/docs/man1.1.0/crypto/ECDSA_do_sign.html", "protocol=uri"

class
	APPLICATION

inherit
	SSL_SHARED

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			test_ecc
			test_encrypt_decrypt_set_keys
			test_generate_keys
		end

feature -- Tests


	test_ecc
		local
			ec_key: POINTER
			ec_group: POINTER
			group_status: INTEGER
			status: INTEGER
			signature: POINTER
			c_string: C_STRING
		do
			 -- First step: create an EC_KEY object (note: this part is not ECDSA specific)
			ec_key := {SSL_ECC}.c_ec_key_new
			check not_null_ec_key: ec_key /= default_pointer end

			ec_group := {SSL_ECC}.c_ec_group_new_by_curve_name ({SSL_OBJ_MAC}.nid_secp192k1)
			check not_null_ec_group: ec_group /= default_pointer end

			group_status := {SSL_ECC}.c_ec_key_set_group (ec_key, ec_group)
			check success: group_status = 1 end

			status := {SSL_ECC}.c_ec_key_generate_key (ec_key)
			check success: status = 1 end

				-- Second step: compute the ECDSA signature of a SHA-256 hash value using ECDSA_do_sign():
			create c_string.make (hash)
			signature := {SSL_ECC}.c_ecdsa_do_sign (c_string.item, hash.count, ec_key)
			check not_null_signature: signature /= default_pointer end

				-- Third step: verify the created ECDSA signature using ECDSA_do_verify():
			status := {SSL_ECC}.c_ecdsa_do_verify (c_string.item, hash.count, signature, ec_key)
				-- Finallt Return value  1 = OK, 0 incorrect signature, other error.
			print ("Status:" + status.out)

			{SSL_ECC}.c_ec_group_free (ec_group)
			{SSL_ECC}.c_ec_key_free (ec_key)
		end


	hash: STRING = "81ccf4bb0a9b360569ce7f7413c0717447c06e3de39fefae0551dbc1fbd6ba23"

	test_encrypt_decrypt_set_keys
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
			check Eiffel: l_rsa.private_decrypt (l_result, l_priv_key).same_string ("Eiffel") end

				-- rsa_pkcs1_oaep_padding
			create l_rsa.make
			public_key.adjust
			create l_pub_key.make (public_key)
			l_result := l_rsa.public_encrypt ("Eiffel", l_pub_key)
			private_key.adjust
			create l_priv_key.make (private_key)
			check Eiffel: l_rsa.private_decrypt (l_result, l_priv_key).same_string ("Eiffel") end
		end


	test_generate_keys
		local
			l_keys: SSL_KEY_PAIR
		do
			initialize_ssl
			create l_keys.make (2048)
			print (l_keys.public_key)
			io.put_new_line
			print (l_keys.private_key)
		end



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
