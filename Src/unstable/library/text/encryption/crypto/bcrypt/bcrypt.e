note
	description: "[
				BCrypt implements OpenBSD-style Blowfish password hashing using
				the scheme described in "A Future-Adaptable Password Scheme" by
				Niels Provos and David Mazieres.
				A bcrypt password should look like this

				$2a$12$D4G5f18o7aMMfwasBL7GpuQWuP3pkrZrOAnqP.bmezbMng.QwJ/pG
				2a identifies the bcrypt algorithm version that was used.
				12 is the cost factor; 2^12 iterations of the key derivation function are used.It's recommend a cost of 12 or more.
				D4G5f18o7aMMfwasBL7GpuQWuP3pkrZrOAnqP.bmezbMng.QwJ/pG is the salt and the cipher text, concatenated and encoded in a modified Base-64.
				The first 22 characters decode to a 16-byte value for the salt.
				The remaining characters are cipher text to be compared for authentication.
				$ are used as delimiters for the header section of the hash.
			]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=BCrypt", "src=http://en.wikipedia.org/wiki/Bcrypt", "protocol=url"
	EIS: "name=C Original BCrypt", "src=http://bcrypt.sourceforge.net/", "protocol=url"
	EIS: "name=C OpenWall BCrypt", "src=http://www.openwall.com/crypt/", "protocol=url"
	EIS: "name=Java BCrypt", "src=https://github.com/SpringSource/spring-security/blob/master/crypto/src/main/java/org/springframework/security/crypto/bcrypt/BCrypt.java", "protocol=url"

class
	BCRYPT

create
	make,
	make_with_salt_generator

feature {NONE} --Initialization

	make
			-- Create an instance BCrypt,
			-- with a developer random generator.
		do
			create p_array.make_empty (0)
			create s_boxes.make_empty (0)
			make_with_salt_generator (create {SALT_DEVELOPER_RANDOM_GENERATOR}.make (Bcrypt_salt_len))
		ensure
			salt_generator_set: salt_generator.conforms_to (create {SALT_DEVELOPER_RANDOM_GENERATOR}.make (Bcrypt_salt_len))
		end

	make_with_salt_generator (a_salt_generator: SALT_GENERATOR)
			-- Create an instance BCrypt,
			-- with `salt_generator' set as `a_salt_generator'
			-- with a developer random generator.
		do
			create p_array.make_empty (0)
			create s_boxes.make_empty (0)
			salt_generator := a_salt_generator
		ensure
			salt_generator_set: salt_generator = a_salt_generator
		end

feature -- Access

	is_valid_log_round (log_rounds: INTEGER): BOOLEAN
			-- Log rounds is valid if it's between (4 and 31).
			-- the interval is exclusive.
		do
			Result := log_rounds >= 4 and log_rounds <= 31
		end

	salt_generator: SALT_GENERATOR
			-- Salt random generator.

feature -- Hash password

	is_valid_salt_version (a_salt: READABLE_STRING_8): BOOLEAN
			-- Is `a_salt' a valid salt version?.
			-- a_salt should look like
			-- $2a$05$ZIcnsKbqJYRmK.LbyZo07u
			-- 2a identifies the bcrypt algorithm version that was used.
			-- 05 is the cost factor.
			-- ZIcnsKbqJYRmK. is the salt
			-- LbyZo07u is the cipher
			-- $ are used as delimiters for the header section of the hash.
		local
			off: INTEGER
		do
			if a_salt.count < 29 then
				Result := False
			else
				Result := True
				if a_salt [1] /= '$' or else a_salt [2] /= '2' then
					Result := False
				else
					if a_salt [3] = '$' then
						off := 3
					else
						if a_salt [3] /= 'a' or else a_salt [4] /= '$' then
							Result := False
						else
							off := 4
						end
					end
				end
				Result := Result and then
							(a_salt.count - off >= 25) and then
							(a_salt [off + 3] <= '$')
			end
		ensure
			Result implies a_salt.count >= 29
		end

	hashed_password_general (a_password: READABLE_STRING_GENERAL; a_salt: READABLE_STRING_GENERAL): STRING_8
			-- General version of hashed_password.
		do
			if a_password.is_valid_as_string_8 and a_salt.is_valid_as_string_8 then
				Result := hashed_password (a_password.to_string_8, a_salt.to_string_8)
			else
				Result := hashed_password_unicode (a_password.to_string_32, a_salt.to_string_32)
			end
		end

	hashed_password_unicode (a_password: READABLE_STRING_32; a_salt: READABLE_STRING_32): STRING_8
			-- Unicode version of hashed_password
			-- We encode unicode passwords and salts using utf-8 before execute them through bcrypt.
		local
			l_utf: UTF_CONVERTER
			l_utf_8_salt: READABLE_STRING_8
		do
			l_utf_8_salt := l_utf.string_32_to_utf_8_string_8 (a_salt)
			if is_valid_salt_version (l_utf_8_salt) then
				Result := hashed_password (l_utf.string_32_to_utf_8_string_8 (a_password), l_utf_8_salt)
			else
				create Result.make_empty
				report_error ("Not `valid_salt_length` or `valid_salt_version` calling `hashed_password`.")
			end
		end

	hashed_password (password: READABLE_STRING_8; salt: READABLE_STRING_8): STRING_8
			-- Hashed `password` with salt `salt` using OpenBSD bcrypt scheme.
			-- Note:
			--		`password` and `salt` are UTF-8 string values.
			-- 		`salt` could be generated using BRCRYPT.new_salt
		require
			valid_salt_length: salt.count > 28
			valid_salt_version: is_valid_salt_version (salt)
		local
			real_salt: READABLE_STRING_8
			l_password, l_salt, l_hashed: SPECIAL [NATURAL_8]
			rounds, off: INTEGER
			minor: CHARACTER_8
			pwd: STRING_8
			l_substring: READABLE_STRING_8
			i,n: INTEGER
			l_bcrypt: BCRYPT
		do
			rounds := 0
			if salt [3] = '$' then
				minor := '%U'
				off := 3
			else
				minor := salt [3]
				off := 4
			end
			l_substring := salt.substring (off + 1, off + 2)
			if l_substring.is_integer then
				rounds := l_substring.to_integer
			end
			real_salt := salt.substring (off + 4, off + 25)
			create pwd.make_from_string (password)
			if minor >= 'a' then
				pwd.append_character ('%U')
			end
			create l_password.make_filled (0, pwd.count)
			from
				i := 0
				n := pwd.count
			until
				i = n
			loop
				l_password.put (pwd [i + 1].code.as_natural_8, i)
				i := i + 1
			end
			create Result.make_empty
			if is_valid_log_round (rounds) then
				l_salt := decoded_base64_array (real_salt, bcrypt_salt_len)
				create l_bcrypt.make_with_salt_generator (salt_generator)
				l_hashed := l_bcrypt.crypt_raw (l_password, l_salt, rounds)
				if l_bcrypt.has_error then
					report_error (l_bcrypt.error_description)
				else
					Result.append ("$2")
					if minor >= 'a' then
						Result.append_character (minor)
					end
					Result.append_character ('$')
					if rounds < 10 then
						Result.append_integer (0)
					end
					Result.append_integer (rounds)
					Result.append_character ('$')
					append_encoded_base64_to (l_salt, l_salt.count, Result)
					append_encoded_base64_to (l_hashed, bf_crypt_ciphertext.count * 4 - 1, Result)
				end
			else
				report_error ("Invalid `rounds` to call `crypt_raw`.")
			end
		end

feature -- helper

	rounds_for_log_rounds (a_log_rounds: INTEGER): INTEGER_64
		require
			valid_round_number: is_valid_log_round (a_log_rounds)
		do
			Result := {INTEGER_64} 1 |<< a_log_rounds
		end

feature -- Generate Salt

	new_salt (a_log_rounds: INTEGER): STRING_8
			--	Generate a salt for use with the BCrypt.hashed_password method
			-- 	`a_log_rounds' the log2 of the number of rounds of
			--  hashing to apply - the work factor therefore increases as 2**a_log_rounds.
			--  random an instance of SecureRandom to use
			--  Result an encoded salt value.
		require
			valid_rounds: is_valid_log_round (a_log_rounds)
		local
			l_sequence: SPECIAL [NATURAL_8]
		do
			create Result.make_empty
			Result.append ("$2a$")
			if a_log_rounds < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (a_log_rounds)
			Result.append_character ('$')

			l_sequence := salt_generator.new_sequence
			if
				Bcrypt_salt_len <= l_sequence.count
			then
				append_encoded_base64_to (l_sequence, Bcrypt_salt_len, Result)
			else
				report_error ("Invalid `bcrypt_salt_len` to call `append_encoded_base64_to`.")
			end
		ensure
			is_valid_salt_version: is_valid_salt_version (Result)
		end

	default_gensalt: STRING_8
			-- Generate a salt for use with the BCrypt.hashpw() method,
			-- selecting a reasonable default for the number of hashing
			-- rounds to apply
			-- Result an encoded salt value.
		do
				-- `gensalt_default_log2_rounds' is a valid log round
				-- so no need to check precondition ``valid_rounds` of `new_salt`.
			check
				valid_log_round: is_valid_log_round (gensalt_default_log2_rounds)
			end
			Result := new_salt (gensalt_default_log2_rounds)
		ensure
			is_valid_salt_version: is_valid_salt_version (Result)
		end

	is_valid_password (plaintext: READABLE_STRING_8; hashed: READABLE_STRING_8): BOOLEAN
			-- Check that a plaintext password matches a previously hashed one
			-- plaintext the plaintext password to verify
			-- hashed    the previously-hashed password
			-- True if the passwords match, False otherwise.
		do
			Result := hashed.same_string (hashed_password (plaintext, hashed))
		end

	is_valid_password_unicode (plaintext: READABLE_STRING_32; hashed: READABLE_STRING_32): BOOLEAN
			-- Unicode version of is_valid_password.			
		do
			Result := hashed.same_string_general (hashed_password_unicode (plaintext, hashed))
		end

	is_valid_password_general (plaintext: READABLE_STRING_GENERAL; hashed: READABLE_STRING_GENERAL): BOOLEAN
			-- General version of is_valid_password.
		do
			Result := hashed.same_string (hashed_password_general (plaintext, hashed))
		end

feature -- Error Report

	has_error: BOOLEAN
			-- There was an error?
		do
			Result := attached error_description
		end

	error_description: detachable IMMUTABLE_STRING_8
			-- Last error description.

	reset_error
			-- Clean up error description
		do
			error_description := Void
		end

	report_error (a_description: detachable READABLE_STRING_8)
		do
			if a_description /= Void then
				create error_description.make_from_string (a_description)
			end
		end

feature {NONE} -- Bcrypt Parameters

	Gensalt_default_log2_rounds: INTEGER = 10
			-- BCrypt parameters.

	Bcrypt_salt_len: INTEGER = 16

feature {NONE} --  Blowfish parameters

	Blowfish_num_rounds: INTEGER = 16
			-- Blowfish parameters.

feature {NONE} -- Initial contents of key schedule

	Bf_crypt_ciphertext: SPECIAL [INTEGER]
			-- bcrypt IV: "OrpheanBeholderScryDoubt"
		once
			Result := <<0x4f727068, 0x65616e42, 0x65686f6c, 0x64657253, 0x63727944, 0x6f756274>>
		end

	p_array_orig: SPECIAL [INTEGER_32]
			-- Initial contents of key schedule
		local
			l_array: ARRAY [INTEGER_32]
		do
			l_array := {ARRAY [INTEGER_32]} <<
					0x243f6a88, 0x85a308d3, 0x13198a2e, 0x03707344, 0xa4093822, 0x299f31d0,
					0x082efa98, 0xec4e6c89, 0x452821e6, 0x38d01377, 0xbe5466cf, 0x34e90c6c,
					0xc0ac29b7, 0xc97c50dd, 0x3f84d5b5, 0xb5470917, 0x9216d5d9, 0x8979fb1b
					>>
			Result := l_array
		end

	s_boxes_orig: SPECIAL [INTEGER_32]
			-- Initial contents of key schedule
		local
			l_array: ARRAY [INTEGER_32]
		do
			l_array := {ARRAY [INTEGER_32]} <<0xd1310ba6, 0x98dfb5ac, 0x2ffd72db, 0xd01adfb7, 0xb8e1afed,
			0x6a267e96, 0xba7c9045, 0xf12c7f99, 0x24a19947, 0xb3916cf7, 0x0801f2e2,
			0x858efc16, 0x636920d8, 0x71574e69, 0xa458fea3, 0xf4933d7e, 0x0d95748f,
			0x728eb658, 0x718bcd58, 0x82154aee, 0x7b54a41d, 0xc25a59b5, 0x9c30d539,
			0x2af26013, 0xc5d1b023, 0x286085f0, 0xca417918, 0xb8db38ef, 0x8e79dcb0,
			0x603a180e, 0x6c9e0e8b, 0xb01e8a3e, 0xd71577c1, 0xbd314b27, 0x78af2fda,
			0x55605c60, 0xe65525f3, 0xaa55ab94, 0x57489862, 0x63e81440, 0x55ca396a,
			0x2aab10b6, 0xb4cc5c34, 0x1141e8ce, 0xa15486af, 0x7c72e993, 0xb3ee1411,
			0x636fbc2a, 0x2ba9c55d, 0x741831f6, 0xce5c3e16, 0x9b87931e, 0xafd6ba33,
			0x6c24cf5c, 0x7a325381, 0x28958677, 0x3b8f4898, 0x6b4bb9af, 0xc4bfe81b,
			0x66282193, 0x61d809cc, 0xfb21a991, 0x487cac60, 0x5dec8032, 0xef845d5d,
			0xe98575b1, 0xdc262302, 0xeb651b88, 0x23893e81, 0xd396acc5, 0x0f6d6ff3,
			0x83f44239, 0x2e0b4482, 0xa4842004, 0x69c8f04a, 0x9e1f9b5e, 0x21c66842,
			0xf6e96c9a, 0x670c9c61, 0xabd388f0, 0x6a51a0d2, 0xd8542f68, 0x960fa728,
			0xab5133a3, 0x6eef0b6c, 0x137a3be4, 0xba3bf050, 0x7efb2a98, 0xa1f1651d,
			0x39af0176, 0x66ca593e, 0x82430e88, 0x8cee8619, 0x456f9fb4, 0x7d84a5c3,
			0x3b8b5ebe, 0xe06f75d8, 0x85c12073, 0x401a449f, 0x56c16aa6, 0x4ed3aa62,
			0x363f7706, 0x1bfedf72, 0x429b023d, 0x37d0d724, 0xd00a1248, 0xdb0fead3,
			0x49f1c09b, 0x075372c9, 0x80991b7b, 0x25d479d8, 0xf6e8def7, 0xe3fe501a,
			0xb6794c3b, 0x976ce0bd, 0x04c006ba, 0xc1a94fb6, 0x409f60c4, 0x5e5c9ec2,
			0x196a2463, 0x68fb6faf, 0x3e6c53b5, 0x1339b2eb, 0x3b52ec6f, 0x6dfc511f,
			0x9b30952c, 0xcc814544, 0xaf5ebd09, 0xbee3d004, 0xde334afd, 0x660f2807,
			0x192e4bb3, 0xc0cba857, 0x45c8740f, 0xd20b5f39, 0xb9d3fbdb, 0x5579c0bd,
			0x1a60320a, 0xd6a100c6, 0x402c7279, 0x679f25fe, 0xfb1fa3cc, 0x8ea5e9f8,
			0xdb3222f8, 0x3c7516df, 0xfd616b15, 0x2f501ec8, 0xad0552ab, 0x323db5fa,
			0xfd238760, 0x53317b48, 0x3e00df82, 0x9e5c57bb, 0xca6f8ca0, 0x1a87562e,
			0xdf1769db, 0xd542a8f6, 0x287effc3, 0xac6732c6, 0x8c4f5573, 0x695b27b0,
			0xbbca58c8, 0xe1ffa35d, 0xb8f011a0, 0x10fa3d98, 0xfd2183b8, 0x4afcb56c,
			0x2dd1d35b, 0x9a53e479, 0xb6f84565, 0xd28e49bc, 0x4bfb9790, 0xe1ddf2da,
			0xa4cb7e33, 0x62fb1341, 0xcee4c6e8, 0xef20cada, 0x36774c01, 0xd07e9efe,
			0x2bf11fb4, 0x95dbda4d, 0xae909198, 0xeaad8e71, 0x6b93d5a0, 0xd08ed1d0,
			0xafc725e0, 0x8e3c5b2f, 0x8e7594b7, 0x8ff6e2fb, 0xf2122b64, 0x8888b812,
			0x900df01c, 0x4fad5ea0, 0x688fc31c, 0xd1cff191, 0xb3a8c1ad, 0x2f2f2218,
			0xbe0e1777, 0xea752dfe, 0x8b021fa1, 0xe5a0cc0f, 0xb56f74e8, 0x18acf3d6,
			0xce89e299, 0xb4a84fe0, 0xfd13e0b7, 0x7cc43b81, 0xd2ada8d9, 0x165fa266,
			0x80957705, 0x93cc7314, 0x211a1477, 0xe6ad2065, 0x77b5fa86, 0xc75442f5,
			0xfb9d35cf, 0xebcdaf0c, 0x7b3e89a0, 0xd6411bd3, 0xae1e7e49, 0x00250e2d,
			0x2071b35e, 0x226800bb, 0x57b8e0af, 0x2464369b, 0xf009b91e, 0x5563911d,
			0x59dfa6aa, 0x78c14389, 0xd95a537f, 0x207d5ba2, 0x02e5b9c5, 0x83260376,
			0x6295cfa9, 0x11c81968, 0x4e734a41, 0xb3472dca, 0x7b14a94a, 0x1b510052,
			0x9a532915, 0xd60f573f, 0xbc9bc6e4, 0x2b60a476, 0x81e67400, 0x08ba6fb5,
			0x571be91f, 0xf296ec6b, 0x2a0dd915, 0xb6636521, 0xe7b9f9b6, 0xff34052e,
			0xc5855664, 0x53b02d5d, 0xa99f8fa1, 0x08ba4799, 0x6e85076a, 0x4b7a70e9,
			0xb5b32944, 0xdb75092e, 0xc4192623, 0xad6ea6b0, 0x49a7df7d, 0x9cee60b8,
			0x8fedb266, 0xecaa8c71, 0x699a17ff, 0x5664526c, 0xc2b19ee1, 0x193602a5,
			0x75094c29, 0xa0591340, 0xe4183a3e, 0x3f54989a, 0x5b429d65, 0x6b8fe4d6,
			0x99f73fd6, 0xa1d29c07, 0xefe830f5, 0x4d2d38e6, 0xf0255dc1, 0x4cdd2086,
			0x8470eb26, 0x6382e9c6, 0x021ecc5e, 0x09686b3f, 0x3ebaefc9, 0x3c971814,
			0x6b6a70a1, 0x687f3584, 0x52a0e286, 0xb79c5305, 0xaa500737, 0x3e07841c,
			0x7fdeae5c, 0x8e7d44ec, 0x5716f2b8, 0xb03ada37, 0xf0500c0d, 0xf01c1f04,
			0x0200b3ff, 0xae0cf51a, 0x3cb574b2, 0x25837a58, 0xdc0921bd, 0xd19113f9,
			0x7ca92ff6, 0x94324773, 0x22f54701, 0x3ae5e581, 0x37c2dadc, 0xc8b57634,
			0x9af3dda7, 0xa9446146, 0x0fd0030e, 0xecc8c73e, 0xa4751e41, 0xe238cd99,
			0x3bea0e2f, 0x3280bba1, 0x183eb331, 0x4e548b38, 0x4f6db908, 0x6f420d03,
			0xf60a04bf, 0x2cb81290, 0x24977c79, 0x5679b072, 0xbcaf89af, 0xde9a771f,
			0xd9930810, 0xb38bae12, 0xdccf3f2e, 0x5512721f, 0x2e6b7124, 0x501adde6,
			0x9f84cd87, 0x7a584718, 0x7408da17, 0xbc9f9abc, 0xe94b7d8c, 0xec7aec3a,
			0xdb851dfa, 0x63094366, 0xc464c3d2, 0xef1c1847, 0x3215d908, 0xdd433b37,
			0x24c2ba16, 0x12a14d43, 0x2a65c451, 0x50940002, 0x133ae4dd, 0x71dff89e,
			0x10314e55, 0x81ac77d6, 0x5f11199b, 0x043556f1, 0xd7a3c76b, 0x3c11183b,
			0x5924a509, 0xf28fe6ed, 0x97f1fbfa, 0x9ebabf2c, 0x1e153c6e, 0x86e34570,
			0xeae96fb1, 0x860e5e0a, 0x5a3e2ab3, 0x771fe71c, 0x4e3d06fa, 0x2965dcb9,
			0x99e71d0f, 0x803e89d6, 0x5266c825, 0x2e4cc978, 0x9c10b36a, 0xc6150eba,
			0x94e2ea78, 0xa5fc3c53, 0x1e0a2df4, 0xf2f74ea7, 0x361d2b3d, 0x1939260f,
			0x19c27960, 0x5223a708, 0xf71312b6, 0xebadfe6e, 0xeac31f66, 0xe3bc4595,
			0xa67bc883, 0xb17f37d1, 0x018cff28, 0xc332ddef, 0xbe6c5aa5, 0x65582185,
			0x68ab9802, 0xeecea50f, 0xdb2f953b, 0x2aef7dad, 0x5b6e2f84, 0x1521b628,
			0x29076170, 0xecdd4775, 0x619f1510, 0x13cca830, 0xeb61bd96, 0x0334fe1e,
			0xaa0363cf, 0xb5735c90, 0x4c70a239, 0xd59e9e0b, 0xcbaade14, 0xeecc86bc,
			0x60622ca7, 0x9cab5cab, 0xb2f3846e, 0x648b1eaf, 0x19bdf0ca, 0xa02369b9,
			0x655abb50, 0x40685a32, 0x3c2ab4b3, 0x319ee9d5, 0xc021b8f7, 0x9b540b19,
			0x875fa099, 0x95f7997e, 0x623d7da8, 0xf837889a, 0x97e32d77, 0x11ed935f,
			0x16681281, 0x0e358829, 0xc7e61fd6, 0x96dedfa1, 0x7858ba99, 0x57f584a5,
			0x1b227263, 0x9b83c3ff, 0x1ac24696, 0xcdb30aeb, 0x532e3054, 0x8fd948e4,
			0x6dbc3128, 0x58ebf2ef, 0x34c6ffea, 0xfe28ed61, 0xee7c3c73, 0x5d4a14d9,
			0xe864b7e3, 0x42105d14, 0x203e13e0, 0x45eee2b6, 0xa3aaabea, 0xdb6c4f15,
			0xfacb4fd0, 0xc742f442, 0xef6abbb5, 0x654f3b1d, 0x41cd2105, 0xd81e799e,
			0x86854dc7, 0xe44b476a, 0x3d816250, 0xcf62a1f2, 0x5b8d2646, 0xfc8883a0,
			0xc1c7b6a3, 0x7f1524c3, 0x69cb7492, 0x47848a0b, 0x5692b285, 0x095bbf00,
			0xad19489d, 0x1462b174, 0x23820e00, 0x58428d2a, 0x0c55f5ea, 0x1dadf43e,
			0x233f7061, 0x3372f092, 0x8d937e41, 0xd65fecf1, 0x6c223bdb, 0x7cde3759,
			0xcbee7460, 0x4085f2a7, 0xce77326e, 0xa6078084, 0x19f8509e, 0xe8efd855,
			0x61d99735, 0xa969a7aa, 0xc50c06c2, 0x5a04abfc, 0x800bcadc, 0x9e447a2e,
			0xc3453484, 0xfdd56705, 0x0e1e9ec9, 0xdb73dbd3, 0x105588cd, 0x675fda79,
			0xe3674340, 0xc5c43465, 0x713e38d8, 0x3d28f89e, 0xf16dff20, 0x153e21e7,
			0x8fb03d4a, 0xe6e39f2b, 0xdb83adf7, 0xe93d5a68, 0x948140f7, 0xf64c261c,
			0x94692934, 0x411520f7, 0x7602d4f7, 0xbcf46b2e, 0xd4a20068, 0xd4082471,
			0x3320f46a, 0x43b7d4b7, 0x500061af, 0x1e39f62e, 0x97244546, 0x14214f74,
			0xbf8b8840, 0x4d95fc1d, 0x96b591af, 0x70f4ddd3, 0x66a02f45, 0xbfbc09ec,
			0x03bd9785, 0x7fac6dd0, 0x31cb8504, 0x96eb27b3, 0x55fd3941, 0xda2547e6,
			0xabca0a9a, 0x28507825, 0x530429f4, 0x0a2c86da, 0xe9b66dfb, 0x68dc1462,
			0xd7486900, 0x680ec0a4, 0x27a18dee, 0x4f3ffea2, 0xe887ad8c, 0xb58ce006,
			0x7af4d6b6, 0xaace1e7c, 0xd3375fec, 0xce78a399, 0x406b2a42, 0x20fe9e35,
			0xd9f385b9, 0xee39d7ab, 0x3b124e8b, 0x1dc9faf7, 0x4b6d1856, 0x26a36631,
			0xeae397b2, 0x3a6efa74, 0xdd5b4332, 0x6841e7f7, 0xca7820fb, 0xfb0af54e,
			0xd8feb397, 0x454056ac, 0xba489527, 0x55533a3a, 0x20838d87, 0xfe6ba9b7,
			0xd096954b, 0x55a867bc, 0xa1159a58, 0xcca92963, 0x99e1db33, 0xa62a4a56,
			0x3f3125f9, 0x5ef47e1c, 0x9029317c, 0xfdf8e802, 0x04272f70, 0x80bb155c,
			0x05282ce3, 0x95c11548, 0xe4c66d22, 0x48c1133f, 0xc70f86dc, 0x07f9c9ee,
			0x41041f0f, 0x404779a4, 0x5d886e17, 0x325f51eb, 0xd59bc0d1, 0xf2bcc18f,
			0x41113564, 0x257b7834, 0x602a9c60, 0xdff8e8a3, 0x1f636c1b, 0x0e12b4c2,
			0x02e1329e, 0xaf664fd1, 0xcad18115, 0x6b2395e0, 0x333e92e1, 0x3b240b62,
			0xeebeb922, 0x85b2a20e, 0xe6ba0d99, 0xde720c8c, 0x2da2f728, 0xd0127845,
			0x95b794fd, 0x647d0862, 0xe7ccf5f0, 0x5449a36f, 0x877d48fa, 0xc39dfd27,
			0xf33e8d1e, 0x0a476341, 0x992eff74, 0x3a6f6eab, 0xf4f8fd37, 0xa812dc60,
			0xa1ebddf8, 0x991be14c, 0xdb6e6b0d, 0xc67b5510, 0x6d672c37, 0x2765d43b,
			0xdcd0e804, 0xf1290dc7, 0xcc00ffa3, 0xb5390f92, 0x690fed0b, 0x667b9ffb,
			0xcedb7d9c, 0xa091cf0b, 0xd9155ea3, 0xbb132f88, 0x515bad24, 0x7b9479bf,
			0x763bd6eb, 0x37392eb3, 0xcc115979, 0x8026e297, 0xf42e312d, 0x6842ada7,
			0xc66a2b3b, 0x12754ccc, 0x782ef11c, 0x6a124237, 0xb79251e7, 0x06a1bbe6,
			0x4bfb6350, 0x1a6b1018, 0x11caedfa, 0x3d25bdd8, 0xe2e1c3c9, 0x44421659,
			0x0a121386, 0xd90cec6e, 0xd5abea2a, 0x64af674e, 0xda86a85f, 0xbebfe988,
			0x64e4c3fe, 0x9dbc8057, 0xf0f7c086, 0x60787bf8, 0x6003604d, 0xd1fd8346,
			0xf6381fb0, 0x7745ae04, 0xd736fccc, 0x83426b33, 0xf01eab71, 0xb0804187,
			0x3c005e5f, 0x77a057be, 0xbde8ae24, 0x55464299, 0xbf582e61, 0x4e58f48f,
			0xf2ddfda2, 0xf474ef38, 0x8789bdc2, 0x5366f9c3, 0xc8b38e74, 0xb475f255,
			0x46fcd9b9, 0x7aeb2661, 0x8b1ddf84, 0x846a0e79, 0x915f95e2, 0x466e598e,
			0x20b45770, 0x8cd55591, 0xc902de4c, 0xb90bace1, 0xbb8205d0, 0x11a86248,
			0x7574a99e, 0xb77f19b6, 0xe0a9dc09, 0x662d09a1, 0xc4324633, 0xe85a1f02,
			0x09f0be8c, 0x4a99a025, 0x1d6efe10, 0x1ab93d1d, 0x0ba5a4df, 0xa186f20f,
			0x2868f169, 0xdcb7da83, 0x573906fe, 0xa1e2ce9b, 0x4fcd7f52, 0x50115e01,
			0xa70683fa, 0xa002b5c4, 0x0de6d027, 0x9af88c27, 0x773f8641, 0xc3604c06,
			0x61a806b5, 0xf0177a28, 0xc0f586e0, 0x006058aa, 0x30dc7d62, 0x11e69ed7,
			0x2338ea63, 0x53c2dd94, 0xc2c21634, 0xbbcbee56, 0x90bcb6de, 0xebfc7da1,
			0xce591d76, 0x6f05e409, 0x4b7c0188, 0x39720a3d, 0x7c927c24, 0x86e3725f,
			0x724d9db9, 0x1ac15bb4, 0xd39eb8fc, 0xed545578, 0x08fca5b5, 0xd83d7cd3,
			0x4dad0fc4, 0x1e50ef5e, 0xb161e6f8, 0xa28514d9, 0x6c51133c, 0x6fd5c7e7,
			0x56e14ec4, 0x362abfce, 0xddc6c837, 0xd79a3234, 0x92638212, 0x670efa8e,
			0x406000e0, 0x3a39ce37, 0xd3faf5cf, 0xabc27737, 0x5ac52d1b, 0x5cb0679e,
			0x4fa33742, 0xd3822740, 0x99bc9bbe, 0xd5118e9d, 0xbf0f7315, 0xd62d1c7e,
			0xc700c47b, 0xb78c1b6b, 0x21a19045, 0xb26eb1be, 0x6a366eb4, 0x5748ab2f,
			0xbc946e79, 0xc6a376d2, 0x6549c2c8, 0x530ff8ee, 0x468dde7d, 0xd5730a1d,
			0x4cd04dc6, 0x2939bbdb, 0xa9ba4650, 0xac9526e8, 0xbe5ee304, 0xa1fad5f0,
			0x6a2d519a, 0x63ef8ce2, 0x9a86ee22, 0xc089c2b8, 0x43242ef6, 0xa51e03aa,
			0x9cf2d0a4, 0x83c061ba, 0x9be96a4d, 0x8fe51550, 0xba645bd6, 0x2826a2f9,
			0xa73a3ae1, 0x4ba99586, 0xef5562e9, 0xc72fefd3, 0xf752f7da, 0x3f046f69,
			0x77fa0a59, 0x80e4a915, 0x87b08601, 0x9b09e6ad, 0x3b3ee593, 0xe990fd5a,
			0x9e34d797, 0x2cf0b7d9, 0x022b8b51, 0x96d5ac3a, 0x017da67d, 0xd1cf3ed6,
			0x7c7d2d28, 0x1f9f25cf, 0xadf2b89b, 0x5ad6b472, 0x5a88f54c, 0xe029ac71,
			0xe019a5e6, 0x47b0acfd, 0xed93fa9b, 0xe8d3c48d, 0x283b57cc, 0xf8d56629,
			0x79132e28, 0x785f0191, 0xed756055, 0xf7960e44, 0xe3d35e8c, 0x15056dd4,
			0x88f46dba, 0x03a16125, 0x0564f0bd, 0xc3eb9e15, 0x3c9057a2, 0x97271aec,
			0xa93a072a, 0x1b3f6d9b, 0x1e6321f5, 0xf59c66fb, 0x26dcf319, 0x7533d928,
			0xb155fdf5, 0x03563482, 0x8aba3cbb, 0x28517711, 0xc20ad9f8, 0xabcc5167,
			0xccad925f, 0x4de81751, 0x3830dc8e, 0x379d5862, 0x9320f991, 0xea7a90c2,
			0xfb3e7bce, 0x5121ce64, 0x774fbe32, 0xa8b6e37e, 0xc3293d46, 0x48de5369,
			0x6413e680, 0xa2ae0810, 0xdd6db224, 0x69852dfd, 0x09072166, 0xb39a460a,
			0x6445c0dd, 0x586cdecf, 0x1c20c8ae, 0x5bbef7dd, 0x1b588d40, 0xccd2017f,
			0x6bb4e3bb, 0xdda26a7e, 0x3a59ff45, 0x3e350a44, 0xbcb4cdd5, 0x72eacea8,
			0xfa6484bb, 0x8d6612ae, 0xbf3c6f47, 0xd29be463, 0x542f5d9e, 0xaec2771b,
			0xf64e6370, 0x740e0d8d, 0xe75b1357, 0xf8721671, 0xaf537d5d, 0x4040cb08,
			0x4eb4e2cc, 0x34d2466a, 0x0115af84, 0xe1b00428, 0x95983a1d, 0x06b89fb4,
			0xce6ea048, 0x6f3f3b82, 0x3520ab82, 0x011a1d4b, 0x277227f8, 0x611560b1,
			0xe7933fdc, 0xbb3a792b, 0x344525bd, 0xa08839e1, 0x51ce794b, 0x2f32c9b7,
			0xa01fbac9, 0xe01cc87e, 0xbcc7d1f6, 0xcf0111c3, 0xa1e8aac7, 0x1a908749,
			0xd44fbd9a, 0xd0dadecb, 0xd50ada38, 0x0339c32a, 0xc6913667, 0x8df9317c,
			0xe0b12b4f, 0xf79e59b7, 0x43f5bb3a, 0xf2d519ff, 0x27d9459c, 0xbf97222c,
			0x15e6fc2a, 0x0f91fc71, 0x9b941525, 0xfae59361, 0xceb69ceb, 0xc2a86459,
			0x12baa8d1, 0xb6c1075e, 0xe3056a0c, 0x10d25065, 0xcb03a442, 0xe0ec6e0e,
			0x1698db3b, 0x4c98a0be, 0x3278e964, 0x9f1f9532, 0xe0d392df, 0xd3a0342b,
			0x8971f21e, 0x1b0a7441, 0x4ba3348c, 0xc5be7120, 0xc37632d8, 0xdf359f8d,
			0x9b992f2e, 0xe60b6f47, 0x0fe3f11d, 0xe54cda54, 0x1edad891, 0xce6279cf,
			0xcd3e7e6f, 0x1618b166, 0xfd2c1d05, 0x848fd2c5, 0xf6fb2299, 0xf523f357,
			0xa6327623, 0x93a83531, 0x56cccd02, 0xacf08162, 0x5a75ebb5, 0x6e163697,
			0x88d273cc, 0xde966292, 0x81b949d0, 0x4c50901b, 0x71c65614, 0xe6c6c7bd,
			0x327a140a, 0x45e1d006, 0xc3f27b9a, 0xc9aa53fd, 0x62a80f00, 0xbb25bfe2,
			0x35bdd2f6, 0x71126905, 0xb2040222, 0xb6cbcf7c, 0xcd769c2b, 0x53113ec0,
			0x1640e3d3, 0x38abbd60, 0x2547adf0, 0xba38209c, 0xf746ce76, 0x77afa1c5,
			0x20756060, 0x85cbfe4e, 0x8ae88dd8, 0x7aaaf9b0, 0x4cf9aa7e, 0x1948c25c,
			0x02fb8a8c, 0x01c36ae4, 0xd6ebe1f9, 0x90d4f869, 0xa65cdea0, 0x3f09252d,
			0xc208e69f, 0xb74e6132, 0xce77e25b, 0x578fdfe3, 0x3ac372e6>>

			Result := l_array
		end

feature {NONE} --  Expanded Blowfish key

	p_array: SPECIAL [INTEGER]

	s_boxes: SPECIAL [INTEGER]

feature {NONE} -- Implementations

	encipher (lr: SPECIAL [INTEGER]; off: INTEGER)
			-- Blowfish encipher a single 64-bit block encoded as
			-- two 32-bit halves.
			-- `lr'    an array containing the two 32-bit half blocks
			-- `off'   the position in the array of the blocks
		local
			i, n: INTEGER
			l, r: INTEGER
			l_p_array: like p_array
			l_s_boxes: like s_boxes
		do
			l_p_array := p_array
			l_s_boxes := s_boxes

			l := lr [off]
			r := lr [off + 1]
			l := l.bit_xor (l_p_array [0])

			from
				i := 0
			until
				i > Blowfish_num_rounds - 2
			loop
					-- Feistel substitution on left word
				n := l_s_boxes [(l |>> 24) & 0xff]
				n := n + l_s_boxes [0x100 | ((l |>> 16) & 0xff)]
				n := n.bit_xor (l_s_boxes [0x200 | ((l |>> 8) & 0xff)])
				n := n + l_s_boxes [0x300 | (l & 0xff)]
				i := i + 1
				r := r.bit_xor (n.bit_xor (l_p_array [i]))

					-- Feistel substitution on right word
				n := l_s_boxes [(r |>> 24) & 0xff]
				n := n + l_s_boxes [0x100 | ((r |>> 16) & 0xff)]
				n := n.bit_xor (l_s_boxes [0x200 | ((r |>> 8) & 0xff)])
				n := n + l_s_boxes [0x300 | (r & 0xff)]
				i := i + 1
				l := l.bit_xor (n.bit_xor (l_p_array [i]))

			end
			lr [off] := r.bit_xor (l_p_array [Blowfish_num_rounds + 1])
			lr [off + 1] := l
		end

	stream_to_word (data: SPECIAL [NATURAL_8]; offp: SPECIAL [INTEGER]): INTEGER
			-- Cycically extract a word of key material
			-- `data'  the string to extract the data from
			-- `offp'  a "pointer" (as a one-entry array) to the
			-- current offset into data
			-- the next word of material from data.
		local
			i: INTEGER
			off: INTEGER
		do
			off := offp [0]
			from
				i := 0
			until
				i = 4
			loop
				Result := (Result |<< 8) | (data [off] & 0xff)
				off := (off + 1) \\ data.count
				i := i + 1
			end
			offp [0] := off
		end

	init_key
			-- Initialise the Blowfish key schedule.
		do
			p_array := p_array_orig
			s_boxes := s_boxes_orig
		end

	build_key (a_key: SPECIAL [NATURAL_8])
			-- Key the Blowfish cipher
			-- key an array containing the key.
		local
			i: INTEGER
			koffp: SPECIAL [INTEGER]
			lr: SPECIAL [INTEGER]
			plen: INTEGER
			slen: INTEGER
			l_p_array: like p_array
			l_s_boxes: like s_boxes
		do
			l_p_array := p_array
			l_s_boxes := s_boxes

			create koffp.make_filled (0, 1)
			create lr.make_filled (0, 2)

			plen := l_p_array.count
			slen := s_boxes.count
			from
				i := 0
			until
				i = plen
			loop
				l_p_array [i] := l_p_array [i].bit_xor (stream_to_word (a_key, koffp))
				i := i + 1
			end
			from
				i := 0
			until
				i = plen
			loop
				encipher (lr, 0)
				l_p_array [i] := lr [0]
				l_p_array [i + 1] := lr [1]
				i := i + 2
			end
			from
				i := 0
			until
				i = slen
			loop
				encipher (lr, 0)
				l_s_boxes [i] := lr [0]
				l_s_boxes [i + 1] := lr [1]
				i := i + 2
			end
		end

	eks_key (a_data: SPECIAL [NATURAL_8]; a_key: SPECIAL [NATURAL_8])
			-- Perform the "enhanced key schedule" step described by
			-- Provos and Mazieres in "A Future-Adaptable Password Scheme"
			-- see EIS reference
			-- `a_data'  salt information
			-- `a_key'   password information
		note
			EIS: "name=A Future-Adaptable Password Scheme", "src=http://www.openbsd.org/papers/bcrypt-paper.ps","protocol=uri"
		local
			i: INTEGER
			koffp: SPECIAL [INTEGER]
			doffp: SPECIAL [INTEGER]
			lr: SPECIAL [INTEGER]
			plen: INTEGER
			slen: INTEGER
			l_p_array: like p_array
			l_s_boxes: like s_boxes
		do
			koffp := <<0>>
			doffp := <<0>>
			lr := <<0, 0>>
			l_p_array := p_array
			l_s_boxes := s_boxes

			plen := l_p_array.count
			slen := l_s_boxes.count
			from
				i := 0
			until
				i = plen
			loop
				l_p_array [i] := l_p_array [i].bit_xor (stream_to_word (a_key, koffp))
				i := i + 1
			end
			from
				i := 0
			until
				i = plen
			loop
				lr [0] := lr [0].bit_xor (stream_to_word (a_data, doffp))
				lr [1] := lr [1].bit_xor (stream_to_word (a_data, doffp))
				encipher (lr, 0)
				l_p_array [i] := lr [0]
				l_p_array [i + 1] := lr [1]
				i := i + 2
			end
			from
				i := 0
			until
				i = slen
			loop
				lr [0] := lr [0].bit_xor (stream_to_word (a_data, doffp))
				lr [1] := lr [1].bit_xor (stream_to_word (a_data, doffp))
				encipher (lr, 0)
				l_s_boxes [i] := lr [0]
				l_s_boxes [i + 1] := lr [1]
				i := i + 2
			end
		end



feature {BCRYPT} -- Implementation

	crypt_raw (a_password: SPECIAL [NATURAL_8]; a_salt: SPECIAL [NATURAL_8]; a_log_rounds: INTEGER): SPECIAL [NATURAL_8]
			-- Perform the central password hashing step in the bcrypt scheme.
			-- `a_password'  the password to hash.
			-- `a_salt'  the binary salt to hash with the password.
			-- `a_log_rounds' the binary logarithm of the number of rounds of hashing to apply.
			-- Result an array containing the binary hashed password.
		require
			is_valid_log_rounds: is_valid_log_round (a_log_rounds)
		local
			cdata: SPECIAL [INTEGER]
			clen: INTEGER
			rounds: INTEGER_64
			i64: INTEGER_64
			i: INTEGER
			j: INTEGER
		do
			cdata := bf_crypt_ciphertext.twin
			clen := cdata.count
			rounds := rounds_for_log_rounds (a_log_rounds)
			create Result.make_filled (0, clen * 4)
			init_key
			eks_key (a_salt, a_password)
			from
				i64 := 0
			until
				i64 = rounds
			loop
				build_key (a_password)
				build_key (a_salt)
				i64 := i64 + 1
			end

			from i := 0 until i = 64 loop
				from j := 0 until j = (clen |>> 1) loop
					encipher (cdata, j |<< 1)
					j := j + 1
				end
				i := i + 1
			end

			from
				i := 0
				j := 0
			until
				i = clen
			loop
				Result [j] := ((cdata [i] |>> 24) & 0xff).to_natural_8
				Result [j+1] := ((cdata [i] |>> 16) & 0xff).to_natural_8
				Result [j+2] := ((cdata [i] |>> 8) & 0xff).to_natural_8
				Result [j+3] := (cdata [i] & 0xff).to_natural_8
				j := j + 4
				i := i + 1
			end
		end

feature {NONE} -- bcrypt modified version of base64 encoding: Constants

	Base64_code: SPECIAL [CHARACTER_8]
			-- Table for Bcrypt-base64 encoding.
		once
			Result := ("./ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789").area
		end

	char64_at (str: READABLE_STRING_GENERAL; i: INTEGER): INTEGER_8
			-- Look up the 3 bits bcrypt-base64-encoded by the specified character `str[i]',
			-- range-checking against conversion table.
		local
			c: NATURAL_32
		do
			c := str.code (i + 1)

			-- The following code behave as a table for Base64 decoding
			-- the value is a byte, in Eiffel a CHARACTER.
			--	 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, --   0 ->   9
			--	 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, --  10 ->  19
			--	 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, --  20 ->  29
			--	 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, --  30 ->  39
			--	 	-1, -1, -1, -1, -1, -1,				    --  40 ->  45
			--		 0,  1, 								--  46 ->  47
			--		54, 55, 56, 57, 58, 59, 60, 61, 62, 63, --  48 ->  57
			--		-1, -1, -1, -1, -1, -1, -1,  			--  58 ->  64
			--		 2,  3,  4,  5,  6,  7,  8,  9, 10, 11, --  65 ->  74
			--		12, 13, 14, 15, 16, 17, 18, 19, 20, 21, --  75 ->  84
			--		22, 23, 24, 25, 26, 27, 				--  85 ->  90
			--		-1, -1, -1, -1, -1, -1, 				--  91 ->  96
			--		28, 29, 30, 31, 32, 33, 34, 35, 36, 37,	--  97 -> 106
			--		38, 39, 40, 41, 42, 43, 44, 45, 46, 47, -- 107 -> 116
			--		48, 49, 50, 51, 52, 53, 				-- 117 -> 122
			--		-1, -1, -1, -1, -1						-- 123 -> 127			

			if c <= 45 then
				Result := {INTEGER_8} -1
			elseif c = 46 then
				Result := {INTEGER_8} 0
			elseif c = 47 then
				Result := {INTEGER_8} 1
			elseif c <= 57  then
				Result := (c + 6).to_integer_8
			elseif c <= 64 then
				Result := {INTEGER_8} -1
			elseif c <= 90 then
				Result := (c - 63).to_integer_8
			elseif c <= 96 then
				Result := {INTEGER_8} -1
			elseif c <= 122 then
				Result := (c - 69).to_integer_8
			else
					-- from 123 to 127
					-- and also include > 127
				Result := {INTEGER_8} -1
			end
		end

feature -- bcrypt modified version of base64 encoding

	append_encoded_base64_to (d: SPECIAL [NATURAL_8]; len: INTEGER; rs: STRING_8)
			-- Append to `rs' encoded byte array `d' using bcrypt's slightly-modified base64
			-- encoding scheme.
			-- Note that this is NOT compatible with standard MIME-base64 encoding.
		require
			valid_length: len > 0 and then len <= d.count
		local
			off: INTEGER
			c1, c2: INTEGER_32
			l_base64_code: like base64_code
			flag: BOOLEAN
		do
			from
				off := 0
				l_base64_code := base64_code
				flag := False
			until
				off = len or flag
			loop
				c1 := d [off].as_integer_8 & 0xff
				rs.append_character (l_base64_code [(c1 |>> 2) & 0x3f])
				c1 := (c1 & 0x03) |<< 4
				off := off + 1
				if off >= len then
					rs.append_character (l_base64_code [c1 & 0x3f])
					flag := True
				else
					c2 := d [off].as_integer_8 & 0xff
					c1 := c1 | ((c2 |>> 4) & 0x0f)
					off := off + 1
					rs.append_character (l_base64_code [c1 & 0x3f])
					c1 := (c2 & 0x0f) |<< 2
					if off >= len then
						rs.append_character (l_base64_code [c1 & 0x3f])
						flag := True
					else
						c2 := d [off].as_integer_8 & 0xff
						c1 := c1 | ((c2 |>> 6) & 0x03)
						rs.append_character (l_base64_code [c1 & 0x3f])
						rs.append_character (l_base64_code [c2 & 0x3f])
						off := off + 1
					end
				end
			end
		end

	decoded_base64_array (str: READABLE_STRING_8; maxolen: INTEGER): SPECIAL [NATURAL_8]
			-- Decode a string encoded using bcrypt's base64 scheme to a byte array.
			-- Note that this is *not* compatible with standard MIME-base64 encoding.
		require
			valid_lengh: maxolen > 0
		local
			l_off: INTEGER
			l_len: INTEGER
			l_olen: INTEGER
			c1, c2, c3, c4, o: INTEGER_8
			flag : BOOLEAN
			res : ARRAYED_LIST [NATURAL_8]
		do
			create res.make (maxolen)
			l_off := 0
			l_len := str.count
			l_olen := 0
			from
				flag := False
			until
				l_off >= l_len - 1 or l_olen = maxolen or flag
			loop
				c1 := char64_at (str, l_off)
				l_off := l_off + 1
				c2 := char64_at (str, l_off)
				l_off := l_off + 1
				if c1 = -1 or else c2 = -1 then
					flag := True
				else
					o := c1 |<< 2
					o := o | ((c2 & 0x30) |>> 4)
					res.force (o.to_natural_8)
					l_olen := l_olen + 1
					if l_olen >= maxolen or else l_off >= l_len then
						flag := True
					else
						c3 := char64_at (str ,l_off)
						l_off := l_off + 1
						if c3 = -1 then
							flag := True
						else
							o := (c2 & 0x0f) |<< 4
							o := o | ((c3 & 0x3c) |>> 2)
							res.force (o.to_natural_8)
							l_olen := l_olen + 1
							if l_olen >= maxolen or else l_off >= l_len then
								flag := True
							else
								c4 := char64_at (str ,l_off)
								l_off := l_off + 1
								o := (c3 & 0x03) |<< 6
								o := o | c4
								res.force (o.to_natural_8)
								l_olen := l_olen + 1
							end
						end
					end
				end
			end
			Result := res.to_array
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
