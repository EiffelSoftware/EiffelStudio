indexing
	description: "DES encryption and decryption";
	product: EiffelLicense;
	keywords: Des, Encryption, Decryption;
	date: "$Date$";
	revision: "$Revision$"

class
	DES_ENCODER

inherit
	EXCEPTIONS

creation
	make, make_with_key

feature -- Initialization

	make is
			-- Prepare object for encryption
		do
			des_init (1)
			set_key (secret_key);	
		end

	make_with_key (key: STRING) is
			-- Prepare object for encryption with `key'.
		require
			key_not_void: key /= Void
			valid_key_count: key.count = 128
		do
			des_init (1)
			set_key (key)
		end

feature -- Disposal

	terminate is
			-- Dispose the allocated structures.
		do
			desdone
		end

feature -- Encryption

	encrypt (s: STRING): STRING is
			-- Padding done if length not multiple of 8
		require
			string_not_void: s /= Void;
		local
			c_string: ANY;
			pad: STRING;
		do
			Result := clone (s);
			if (s.count \\ 8) /= 0 then
				!! pad.make (8 - (s.count \\ 8));
				pad.fill_character ('%U');
				Result.append (pad);
			end;
			c_string := Result.to_c;
			c_encrypt ($c_string, Result.count);
		end;

	decrypt (s: STRING): STRING is
			-- Padding done if length not multiple of 8
		require
			string_not_void: s /= Void;
		local
			c_string: ANY;
			pad: STRING;
		do
			Result := clone (s);
			if (s.count \\ 8) /= 0 then
				!! pad.make (8 - (s.count \\ 8));
				pad.fill_character ('%U');
				Result.append (pad);
			end;
			c_string := Result.to_c;
			c_decrypt ($c_string, Result.count);
			Result.prune_all ('%U');
			Result.adapt_size;
		end;

feature -- Status

	des_init (mode: INTEGER) is
			-- mode 0: standard Data Encryption Algorithm
			-- mode 1: DEA without initial and final permutation for speed
			-- mode 2: DEA without permutations and with 128-byte key
			-- In modes 0 and 1, 8 key bytes are expected, with the low order
			-- bit of each key byte ignored (parity is not checked). This
			-- gives a 56-bit key.
			-- In mode 2, 128 key bytes are expected; the high order 2 bits
			-- of each byte are ignored, giving a 768 bit key.
		require
			mode_low_enough: mode <= 2;
			mode_high_enough: mode >= 0;
		do
			if desinit (mode) < 0 then
				raise ("Unable to initialize DES encryption.")
			end;
		end;

	set_key (key: STRING) is
		require
			key_not_void: key /= Void;
		local
			c_string: ANY;
		do
			c_string := key.to_c;
			setkey ($c_string);
		end;

feature {NONE}

	secret_key: STRING is
		once
			Result := "%/23/%/05/%/37/%/16/%/01/%/03/%/07/%/39/%/63/%/25/%
					%%/37/%/56/%/23/%/19/%/54/%/63/%/21/%/53/%/32/%/40/%
					%%/30/%/06/%/12/%/21/%/53/%/35/%/59/%/19/%/57/%/03/%
					%%/44/%/10/%/12/%/01/%/25/%/35/%/16/%/19/%/21/%/02/%
					%%/37/%/21/%/16/%/01/%/98/%/55/%/44/%/09/%/37/%/49/%
					%%/11/%/62/%/09/%/46/%/32/%/45/%/15/%/53/%/46/%/25/%
					%%/07/%/05/%/54/%/38/%/61/%/48/%/76/%/03/%/59/%/38/%
					%%/35/%/24/%/38/%/39/%/28/%/02/%/53/%/10/%/40/%/19/%
					%%/39/%/51/%/36/%/02/%/57/%/62/%/39/%/24/%/82/%/56/%
					%%/09/%/01/%/31/%/19/%/20/%/49/%/25/%/29/%/49/%/09/%
					%%/36/%/61/%/10/%/03/%/45/%/50/%/42/%/10/%/31/%/39/%
					%%/50/%/02/%/30/%/17/%/17/%/49/%/63/%/10/%/58/%/38/%
					%%/14/%/21/%/14/%/18/%/13/%/04/%/11/%/57/"
		end

feature {NONE} -- Externals

	c_decrypt (data: POINTER; size: INTEGER) is
		external
			"C | %"desop.h%""
		alias
			"des_decrypt"
		end;

	c_encrypt (data: POINTER; size: INTEGER) is
		external
			"C | %"desop.h%""
		alias
			"des_encrypt"
		end;

	desinit (mode: INTEGER): INTEGER is
		external
			"C | %"des.h%""
		alias
			"ise_desinit"
		end;

	desdone is
		external
			"C | %"des.h%""
		alias
			"ise_desdone"
		end;

	setkey (key: POINTER) is
		external
			"C | %"des.h%""
		alias
			"ise_setkey"
		end;

end -- class DES_ENCODER
