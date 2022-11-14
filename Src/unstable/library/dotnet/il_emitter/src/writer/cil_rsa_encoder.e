note
	description: "Manage SNK file & perform RSA signature"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_RSA_ENCODER

inherit

	REFACTORING_HELPER

feature -- Access


	modulus_bits: NATURAL

    public_exponent: INTEGER

	private_exponent: detachable ARRAY [NATURAL_8]

	key_pair: detachable ARRAY [NATURAL_8]

	modulus: detachable ARRAY [NATURAL_8]


feature -- Status Report

	load_strong_name_keys (a_file: STRING_32)
		do
			to_implement ("Add implementation")
		end


	get_public_key_data (a_key: ARRAY [NATURAL_8]): NATURAL_32
		do
			to_implement ("Add implementation")
		end

	get_strong_name_signature (a_sig: ARRAY [NATURAL_8]; a_hash: ARRAY [NATURAL_8]; a_hash_size: NATURAL_32 ): NATURAL_32
		do
			to_implement ("Add implementation")
		end

end
