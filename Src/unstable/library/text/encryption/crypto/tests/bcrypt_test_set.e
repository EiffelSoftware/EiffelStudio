note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	EIS: "name= BCrypt test suite", "src=https://github.com/SpringSource/spring-security/blob/master/crypto/src/test/java/org/springframework/security/crypto/bcrypt/BCryptTests.java", "protocol=url"

class
	BCRYPT_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_hashed_password
			-- Test method for 'BCrypt.hashpw(String, String)'
		local
			i: INTEGER
			plain: STRING
			salt: STRING
			expected: STRING
			hashed: STRING
			l_bcrypt: BCRYPT
		do
			create l_bcrypt.make
			print ("BCrypt.hashed_password: ")
			from
				i := 1
			until
				i = test_vectors.count
			loop
				plain := (test_vectors [i]) [1]
				salt := (test_vectors [i]) [2]
				expected := (test_vectors [i]) [3]
				hashed := l_bcrypt.hashed_password_general (plain, salt)
				assert ("Equals", hashed.same_string (expected))
				i := i + 1
			end
			print ("%N");
		end

	test_new_salt
			--Test method for 'BCrypt.gensalt(int)'
		local
			i, j: INTEGER
			plain: STRING
			salt: STRING
			hashed1, hashed2: STRING
			l_bcrypt: BCRYPT
		do
			create l_bcrypt.make
			print ("BCrypt.new_salt ")
			from
				i := 4
			until
				i > 12
			loop
				i := i + 1;
				from
					j := 1
				until
					j > test_vectors.count
				loop
					plain := (test_vectors [j]) [1]
					salt := l_bcrypt.new_salt (i)
					hashed1 := l_bcrypt.hashed_password_unicode (plain, salt)
					hashed2 := l_bcrypt.hashed_password_unicode (plain, hashed1)
					assert ("Equals", hashed1.same_string (hashed2))
					j := j + 4
				end
				print ("%N")
			end
		end

	test_default_salt
			--Test method for 'BCrypt.default_gensalt'
		local
			i: INTEGER
			plain: STRING
			salt: STRING
			hashed1, hashed2: STRING
			l_bcrypt: BCRYPT
		do
			create l_bcrypt.make
			print ("BCrypt.default_gensalt ")
			from
				i := 1
			until
				i > test_vectors.count
			loop
				plain := (test_vectors [i]) [1]
				salt := l_bcrypt.default_gensalt
				hashed1 := l_bcrypt.hashed_password_unicode (plain, salt)
				hashed2 := l_bcrypt.hashed_password_unicode (plain, hashed1)
				assert ("Equals", hashed1.same_string (hashed2))
				i := i + 4
			end
			print ("%N")
		end

	test_is_valid_password_success
			-- Test method for 'BCrypt.checkpw(String, String)' expecting success
		local
			i: INTEGER
			plain: STRING
			expected: STRING
			l_bcrypt: BCRYPT
		do
			create l_bcrypt.make
			print ("BCrypt.checkpw w/ good passwords: ")
			from
				i := 1
			until
				i > test_vectors.count
			loop
				plain := (test_vectors [i]) [1]
				expected := (test_vectors [i]) [3]
				assert ("True", l_bcrypt.is_valid_password (plain, expected))
				i := i + 1
			end
			print ("%N")
		end

	test_is_valid_password_failure
			-- Test method for 'BCrypt.checkpw(String, String)' expecting failure
		local
			i: INTEGER
			plain: STRING
			expected: STRING
			l_bcrypt: BCRYPT
			broken_index: INTEGER
		do
			create l_bcrypt.make
			print ("BCrypt.checkpw w/ bad passwords: ")
			from
				i := 1
			until
				i > test_vectors.count
			loop
				broken_index := ((i + 4) \\ test_vectors.count) + 1 -- Eiffel Arrays start in 1
				plain := (test_vectors [i]) [1]
				expected := (test_vectors [broken_index]) [3]
				assert ("False", not l_bcrypt.is_valid_password (plain, expected))
				i := i + 1
			end
			print ("%N")
		end

	test_international_chars
			-- Test for correct hashing of non-US-ASCII passwords
		local
			pw1: STRING_32
			pw2: STRING_32
			h1, h2: STRING_32
			l_bcrypt: BCRYPT
		do
			print ("BCrypt.hashpw w/ international chars: ")
			create l_bcrypt.make
			create pw1.make_from_string ({STRING_32} "ππππππππ")
			create pw2.make_from_string ({STRING_32} "????????")
			h1 := l_bcrypt.hashed_password (pw1, l_bcrypt.default_gensalt)
			assert ("False", not l_bcrypt.is_valid_password (pw2, h1))
			h2 := l_bcrypt.hashed_password (pw2, l_bcrypt.default_gensalt)
			assert ("False", not l_bcrypt.is_valid_password (pw1, h2))
		end


	test_ascii_chars
		local
			pw1: STRING_8
			pw2: STRING_8
			h1, h2: STRING_8
			l_bcrypt: BCRYPT
		do
			print ("BCrypt.hashpw w/ ascii chars: ")
			create l_bcrypt.make
			create pw1.make_from_string ({STRING_8} "testing123")
			create pw2.make_from_string ({STRING_8} "password")
			h1 := l_bcrypt.hashed_password (pw1, l_bcrypt.default_gensalt)
			assert ("False", not l_bcrypt.is_valid_password (pw2, h1))
			h2 := l_bcrypt.hashed_password (pw2, l_bcrypt.default_gensalt)
			assert ("False", not l_bcrypt.is_valid_password (pw1, h2))
		end


	test_rounds_for_does_not_overflow
		local
			l_bcrypt: BCRYPT
			long: INTEGER_64
		do
			long := 0x80000000
			create l_bcrypt.make
			assert ("valid log round", l_bcrypt.is_valid_log_round (10))
			assert ("Equals", 1024 = l_bcrypt.rounds_for_log_rounds (10))

			assert ("valid log round", l_bcrypt.is_valid_log_round (31))
			assert ("Equals", long = l_bcrypt.rounds_for_log_rounds (31))

		end


	test_empty_array_cannot_be_encoded
		local
			l_arr: ARRAY [NATURAL_8]
			l_bcrypt: BCRYPT
			l_no_retry: BOOLEAN
		do
			create l_bcrypt.make
			if not l_no_retry then
				create l_arr.make_empty
				l_bcrypt.append_encoded_base64_to (l_arr, 0, "")
			end
			l_no_retry := True
			assert ("Invalid Arguments", True)
		rescue
			if not l_no_retry then
				l_no_retry := True
				retry
			end
		end



	more_bytes_than_in_the_array_cannot_be_encoded
		local
			l_bcrypt: BCRYPT
			l_no_retry: BOOLEAN
		do
			create l_bcrypt.make
			if not l_no_retry then
				l_bcrypt.append_encoded_base64_to (<<{NATURAL_8}1>>, 2, "")
			end
			l_no_retry := True
			assert ("Invalid Arguments", True)
		rescue
			if not l_no_retry then
				l_no_retry := True
				retry
			end
		end



	decoding_must_request_more_than_zero_bytes
		local
			l_bcrypt: BCRYPT
			l_no_retry: BOOLEAN
			l_arr : SPECIAL [NATURAL_8]
		do
			create l_bcrypt.make
			if not l_no_retry then
				l_arr := l_bcrypt.decoded_base64_array ("",0)
			end
			l_no_retry := True
			assert ("Invalid Arguments", True)
		rescue
			if not l_no_retry then
				l_no_retry := True
				retry
			end
		end



    test_base64_encode_simple_byte_arrays
   		local
   			l_bcrypt : BCRYPT
   			rs : STRING_8
    	do
    		create l_bcrypt.make
    		create rs.make_empty
    		l_bcrypt.append_encoded_base64_to (<<{NATURAL_8}0>>, 1, rs)
			assert("Equals",rs.same_string (".."))

    		create rs.make_empty
			l_bcrypt.append_encoded_base64_to (<<{NATURAL_8}0,{NATURAL_8}0>>, 2, rs)
			assert("Equals",rs.same_string ("..."))

    		create rs.make_empty
			l_bcrypt.append_encoded_base64_to (<<{NATURAL_8}0,{NATURAL_8}0,{NATURAL_8}0 >>, 3, rs)
			assert("Equals",rs.same_string ("...."))

		end


	decoding_chars_outside_ascii_gives_no_results
		local
			l_bcrypt : BCRYPT
			ba : SPECIAL[NATURAL_8]
		do
			create l_bcrypt.make
			ba := l_bcrypt.decoded_base64_array ({STRING_32}"ππππππππ", 1)
			assert ("Expected 0", ba.count = 0)
		end


	decoding_stops_with_first_invalid_character
		local
			l_bcrypt : BCRYPT
		do
			create l_bcrypt.make
			assert("Expected 1",l_bcrypt.decoded_base64_array ({STRING_32}"....", 1).count = 1)
			assert("Expected 0",l_bcrypt.decoded_base64_array ({STRING_32}" ....", 1).count = 0)
		end



    decoding_only_provides_available_bytes
		local
			l_bcrypt : BCRYPT
		do
			create l_bcrypt.make
			assert("Expected 0",l_bcrypt.decoded_base64_array ({STRING_32}"", 1).count = 0)
			assert("Expected 3",l_bcrypt.decoded_base64_array ({STRING_32}"......", 3).count = 3)
			assert("Expected 4",l_bcrypt.decoded_base64_array ({STRING_32}"......", 4).count = 4)
			assert("Expected 4",l_bcrypt.decoded_base64_array ({STRING_32}"......", 5).count = 4)
		end



    test_base64_encode_decode
    		--  Encode and decode each byte value in each position.
    	local
    		ba, decoded : SPECIAL[NATURAL_8]
    		i,b : NATURAL_8
    		s : STRING_8
    		l_bcrypt : BCRYPT
    	do
    		create l_bcrypt.make
    		from
    			b := 0
    		until
				b = 0xFF
    		loop
    			from
    				i := 0
    			until
    				i = 3
    			loop
    				create ba.make_filled (0,3)
    				ba[i] := b;
					create s.make_empty
    				l_bcrypt.append_encoded_base64_to (ba,3,s)
					assert ("Equal lenght:", s.count = 4)

    				i := i + 1
					decoded := l_bcrypt.decoded_base64_array (s, 3)
					assert("Array Equals Count", ba.count = decoded.count)
					assert("Element 1",ba[0] = decoded[0])
					assert("Element 2",ba[1] = decoded[1])
					assert("Element 3",ba[2] = decoded[2])

    			end
			 b := b + 1
    		end
    	end



	gensalt_fails_with_too_few_rounds
		local
			l_bcrypt: BCRYPT
			l_no_retry: BOOLEAN
		do
			create l_bcrypt.make
			if not l_no_retry then
				print (l_bcrypt.new_salt (3) )
			end
			l_no_retry := True
			assert ("Invalid Arguments", True)
		rescue
			if not l_no_retry then
				l_no_retry := True
				retry
			end
		end


	gensalt_fails_with_too_many_rounds
		local
			l_bcrypt: BCRYPT
			l_no_retry: BOOLEAN
		do
			create l_bcrypt.make
			if not l_no_retry then
				print (l_bcrypt.new_salt (32) )
			end
			l_no_retry := True
			assert ("Invalid Arguments", True)
		rescue
			if not l_no_retry then
				l_no_retry := True
				retry
			end
		end


    gensalt_generates_correct_salt_prefix
    	local
    		l_bcrypt : BCRYPT
    	do
    		create l_bcrypt.make
    		assert("True",l_bcrypt.new_salt (4).starts_with ("$2a$04$"))
    		assert("True",l_bcrypt.new_salt (31).starts_with ("$2a$31$"))
    	end


	hash_password_fails_when_salt_specifies_too_few_rounds
		local
			l_bcrypt: BCRYPT
		do
			create l_bcrypt.make
			print (l_bcrypt.hashed_password ("password", "$2a$03$......................"))
			assert ("Invalid Arguments", l_bcrypt.has_error)
		end


    hash_password_fails_when_salt_specifies_too_many_rounds
		local
			l_bcrypt: BCRYPT
			l_salt: READABLE_STRING_8
		do
			create l_bcrypt.make
			l_salt := {STRING_8}"$2a$32$......................"
			if  l_salt.count > 28 and then
				l_bcrypt.is_valid_salt_version (l_salt)
			then
				print (l_bcrypt.hashed_password ({STRING_8}"password", {STRING_8}"$2a$32$......................"))
				assert ("Has Error", l_bcrypt.has_error)
			else
				assert ("Wrong Implemenation", False)
			end
		end


	 salt_length_is_checked
		local
			l_bcrypt: BCRYPT
			l_no_retry: BOOLEAN
		do
			create l_bcrypt.make
			if not l_no_retry then
				print (l_bcrypt.hashed_password ("",""))
			end
			l_no_retry := True
			assert ("Invalid Arguments", True)
		rescue
			if not l_no_retry then
				l_no_retry := True
				retry
			end
		end


feature -- Test data

	test_vectors: ARRAY [ARRAY [STRING]]
		do
			Result := <<
						<<"", "$2a$06$DCq7YPn5Rq63x1Lad4cll.", "$2a$06$DCq7YPn5Rq63x1Lad4cll.TV4S6ytwfsfvkgY8jIucDrjc8deX1s.">>,
						<<"", "$2a$08$HqWuK6/Ng6sg9gQzbLrgb.", "$2a$08$HqWuK6/Ng6sg9gQzbLrgb.Tl.ZHfXLhvt/SgVyWhQqgqcZ7ZuUtye">>,
						<<"", "$2a$10$k1wbIrmNyFAPwPVPSVa/ze", "$2a$10$k1wbIrmNyFAPwPVPSVa/zecw2BCEnBwVS2GbrmgzxFUOqW9dk4TCW">>,
						<<"", "$2a$12$k42ZFHFWqBp3vWli.nIn8u", "$2a$12$k42ZFHFWqBp3vWli.nIn8uYyIkbvYRvodzbfbK18SSsY.CsIQPlxO">>,
						<<"a", "$2a$06$m0CrhHm10qJ3lXRY.5zDGO", "$2a$06$m0CrhHm10qJ3lXRY.5zDGO3rS2KdeeWLuGmsfGlMfOxih58VYVfxe">>,
						<<"a", "$2a$08$cfcvVd2aQ8CMvoMpP2EBfe", "$2a$08$cfcvVd2aQ8CMvoMpP2EBfeodLEkkFJ9umNEfPD18.hUF62qqlC/V.">>,
						<<"a", "$2a$10$k87L/MF28Q673VKh8/cPi.", "$2a$10$k87L/MF28Q673VKh8/cPi.SUl7MU/rWuSiIDDFayrKk/1tBsSQu4u">>,
						<<"a", "$2a$12$8NJH3LsPrANStV6XtBakCe", "$2a$12$8NJH3LsPrANStV6XtBakCez0cKHXVxmvxIlcz785vxAIZrihHZpeS">>,
						<<"abc", "$2a$06$If6bvum7DFjUnE9p2uDeDu", "$2a$06$If6bvum7DFjUnE9p2uDeDu0YHzrHM6tf.iqN8.yx.jNN1ILEf7h0i">>,
						<<"abc", "$2a$08$Ro0CUfOqk6cXEKf3dyaM7O", "$2a$08$Ro0CUfOqk6cXEKf3dyaM7OhSCvnwM9s4wIX9JeLapehKK5YdLxKcm">>,
						<<"abc", "$2a$10$WvvTPHKwdBJ3uk0Z37EMR.", "$2a$10$WvvTPHKwdBJ3uk0Z37EMR.hLA2W6N9AEBhEgrAOljy2Ae5MtaSIUi">>,
						<<"abc", "$2a$12$EXRkfkdmXn2gzds2SSitu.", "$2a$12$EXRkfkdmXn2gzds2SSitu.MW9.gAVqa9eLS1//RYtYCmB1eLHg.9q">>,
						<<"abcdefghijklmnopqrstuvwxyz", "$2a$06$.rCVZVOThsIa97pEDOxvGu", "$2a$06$.rCVZVOThsIa97pEDOxvGuRRgzG64bvtJ0938xuqzv18d3ZpQhstC">>,
						<<"abcdefghijklmnopqrstuvwxyz", "$2a$08$aTsUwsyowQuzRrDqFflhge", "$2a$08$aTsUwsyowQuzRrDqFflhgekJ8d9/7Z3GV3UcgvzQW3J5zMyrTvlz.">>,
						<<"abcdefghijklmnopqrstuvwxyz", "$2a$10$fVH8e28OQRj9tqiDXs1e1u", "$2a$10$fVH8e28OQRj9tqiDXs1e1uxpsjN0c7II7YPKXua2NAKYvM6iQk7dq">>,
						<<"abcdefghijklmnopqrstuvwxyz", "$2a$12$D4G5f18o7aMMfwasBL7Gpu", "$2a$12$D4G5f18o7aMMfwasBL7GpuQWuP3pkrZrOAnqP.bmezbMng.QwJ/pG">>,
						<<"~!@#$%%^&*()      ~!@#$%%^&*()PNBFRD", "$2a$06$fPIsBO8qRqkjj273rfaOI.", "$2a$06$fPIsBO8qRqkjj273rfaOI.HtSV9jLDpTbZn782DC6/t7qT67P6FfO">>,
						<<"~!@#$%%^&*()      ~!@#$%%^&*()PNBFRD", "$2a$08$Eq2r4G/76Wv39MzSX262hu", "$2a$08$Eq2r4G/76Wv39MzSX262huzPz612MZiYHVUJe/OcOql2jo4.9UxTW">>,
						<<"~!@#$%%^&*()      ~!@#$%%^&*()PNBFRD", "$2a$10$LgfYWkbzEvQ4JakH7rOvHe", "$2a$10$LgfYWkbzEvQ4JakH7rOvHe0y8pHKF9OaFgwUZ2q7W2FFZmZzJYlfS">>,
						<<"~!@#$%%^&*()      ~!@#$%%^&*()PNBFRD", "$2a$12$WApznUOJfkEGSmYRfnkrPO", "$2a$12$WApznUOJfkEGSmYRfnkrPOr466oFDCaj4b6HY3EXGvfxm43seyhgC">>
					>>
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
