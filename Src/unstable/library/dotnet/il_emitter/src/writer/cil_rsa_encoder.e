note
	description: "Manage SNK file & perform RSA signature"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_RSA_ENCODER

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
		do
			create private_exponent.make_empty
			create key_pair.make_empty
			create modulus.make_empty
		end

feature -- Access


	modulus_bits: NATURAL_64

    public_exponent: INTEGER

	private_exponent:  ARRAY [NATURAL_8]

	key_pair:  ARRAY [NATURAL_8]

	modulus: ARRAY [NATURAL_8]


feature -- Status Report

	load_strong_name_keys (a_file: STRING_32)
		do
			to_implement ("Add implementation")
		end


	get_public_key_data (a_key: ARRAY [NATURAL_8]): NATURAL_32
		do
			to_implement ("Add implementation")
		end

	get_strong_name_signature (a_sig: ARRAY [NATURAL_8]; a_sig_len: CELL [NATURAL_64]; a_hash: ARRAY [NATURAL_8]; a_hash_size: NATURAL_64 )
			-- Defined as void RSAEncoder::GetStrongNameSignature(Byte* sig, size_t* sigSize, const Byte* hash, size_t hashSize)
		do
			to_implement ("Add implementation")
		end

end
