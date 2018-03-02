note
	description: "test application root class"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ECSA", "src=https://www.openssl.org/docs/man1.1.0/crypto/ECDSA_do_sign.html", "protocol=uri"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			test_ecc
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
		--
end
