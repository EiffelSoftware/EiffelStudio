note
	description: "Object representing the OpenSSL wrapper for the Elliptic Curve Digital Signature Algorithm"
	date: "$Date$"
	revision: "$Revision$"
	EIS:"name=ECDSA", "src=https://www.openssl.org/docs/man1.1.0/crypto/ECDSA_do_sign.html", "protocol=uri"

class
	SSL_ECC

feature -- C externals

	c_ec_key_new: POINTER
			-- Creates a new EC_KEY object
			-- return EC_KEY object or NULL if an error occurred.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EC_KEY_new();"
		end

	c_ec_group_new_by_curve_name (a_nid: INTEGER): POINTER
			-- Creates a EC_GROUP object with a curve specified by a NID
			-- param  nid  NID of the OID of the curve name
			-- return newly created EC_GROUP object with specified curve or NULL
			-- if an error occurred
			-- EC_KEY *EC_KEY_new_by_curve_name(int nid);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EC_GROUP_new_by_curve_name((int)$a_nid);"
		end

	c_ec_key_set_group(a_key: POINTER; a_group: POINTER): INTEGER
			--/** Sets the EC_GROUP of a EC_KEY object.
			-- *  \param  key    EC_KEY object
			-- *  \param  group  EC_GROUP to use in the EC_KEY object (note: the EC_KEY
			-- *                 object will use an own copy of the EC_GROUP).
			-- *  \return 1 on success and 0 if an error occurred.
			-- */
			-- int EC_KEY_set_group(EC_KEY *key, const EC_GROUP *group);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EC_KEY_set_group((EC_KEY *)$a_key, (const EC_GROUP *)$a_group);"
		end

	c_ec_key_generate_key (a_key: POINTER): INTEGER
			--/** Creates a new ec private (and optional a new public) key.
			-- *  \param  key  EC_KEY object
			-- *  \return 1 on success and 0 if an error occurred.
			-- */
			--int EC_KEY_generate_key(EC_KEY *key);	
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EC_KEY_generate_key((EC_KEY *)$a_key);"
		end

	c_ecdsa_do_sign (a_dgst: POINTER; a_len: INTEGER; a_key: POINTER): POINTER
			--/** Computes the ECDSA signature of the given hash value using
			-- *  the supplied private key and returns the created signature.
			-- *  \param  dgst      pointer to the hash value
			-- *  \param  dgst_len  length of the hash value
			-- *  \param  eckey     EC_KEY object containing a private EC key
			-- *  \return pointer to a ECDSA_SIG structure or NULL if an error occurred
			-- */
			--ECDSA_SIG *ECDSA_do_sign(const unsigned char *dgst, int dgst_len,
			--                         EC_KEY *eckey);
		external
				"C inline use %"eif_openssl.h%""
		alias
			"return (ECDSA_SIG *) ECDSA_do_sign((const unsigned char *)$a_dgst, (int) $a_len, (EC_KEY *)$a_key);"
		end

	c_ecdsa_do_verify (a_dgst: POINTER; a_len: INTEGER; a_sig: POINTER; a_key: POINTER): INTEGER
			--/** Verifies that the supplied signature is a valid ECDSA
			-- *  signature of the supplied hash value using the supplied public key.
			-- *  \param  dgst      pointer to the hash value
			-- *  \param  dgst_len  length of the hash value
			-- *  \param  sig       ECDSA_SIG structure
			-- *  \param  eckey     EC_KEY object containing a public EC key
			-- *  \return 1 if the signature is valid, 0 if the signature is invalid
			-- *          and -1 on error
			-- */
			--int ECDSA_do_verify(const unsigned char *dgst, int dgst_len,
			--                    const ECDSA_SIG *sig, EC_KEY *eckey);	
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return ECDSA_do_verify((const unsigned char *)$a_dgst, (int) $a_len, (const ECDSA_SIG *)$a_sig, (EC_KEY *)$a_key);"
		end

	c_ec_group_free (a_group: POINTER)
			--/** Frees a EC_GROUP object
			-- *  \param  group  EC_GROUP object to be freed.
			-- */
			--void EC_GROUP_free(EC_GROUP *group);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"EC_GROUP_free((EC_GROUP *)$a_group);"
		end

	c_ec_key_free (a_key: POINTER)
			--/** Frees a EC_KEY object.
			-- *  \param  key  EC_KEY object to be freed.
			-- */
			--void EC_KEY_free(EC_KEY *key);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"EC_KEY_free((EC_KEY *)$a_key);"
		end

	c_ecdsa_sig_get0 (a_sig: POINTER; a_pr: POINTER; a_ps: POINTER)
		--/** Accessor for r and s fields of ECDSA_SIG
		-- *  \param  sig  pointer to ECDSA_SIG pointer
		-- *  \param  pr   pointer to BIGNUM pointer for r (may be NULL)
		-- *  \param  ps   pointer to BIGNUM pointer for s (may be NULL)
		-- */
		--void ECDSA_SIG_get0(const ECDSA_SIG *sig, const BIGNUM **pr, const BIGNUM **ps);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"ECDSA_SIG_get0($a_sig, $a_pr, $a_ps)"
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

