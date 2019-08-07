note
	description: "Test for SHA1"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SHA1

inherit
	EQA_TEST_SET

feature -- Test routines

	test_sha1
			-- Test sha1
			-- Test suite from standard specification:
		do
			assert ("", sha1_string ("").is_case_insensitive_equal ("da39a3ee5e6b4b0d3255bfef95601890afd80709"))
			assert ("", sha1_string ("a").is_case_insensitive_equal ("86f7e437faa5a7fce15d1ddcb9eaeaea377667b8"))
			assert ("", sha1_string ("abc").is_case_insensitive_equal ("a9993e364706816aba3e25717850c26c9cd0d89d"))
			assert ("", sha1_string ("message digest").is_case_insensitive_equal ("c12252ceda8be8994d5fa0290a47231c1d16aae3"))
			assert ("", sha1_string ("abcdefghijklmnopqrstuvwxyz").is_case_insensitive_equal ("32d10c7b8cf96570ca04ce37f2a19d84240d3a89"))
			assert ("", sha1_string ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789").is_case_insensitive_equal ("761c457bf73b14d27e9e9265c46f4b4dda11f940"))
			assert ("", sha1_string ("12345678901234567890123456789012345678901234567890123456789012345678901234567890").is_case_insensitive_equal ("50abf5706a150990a08b2c5ea40fa0e585554732"))
		end

	test_sha1_no_reset
			-- Test SHA1 without reset.
		do
			sha1.reset
			assert ("", update_sha1_string_no_reset ("").is_case_insensitive_equal ("da39a3ee5e6b4b0d3255bfef95601890afd80709"))
			assert ("", update_sha1_string_no_reset ("a").is_case_insensitive_equal ("86f7e437faa5a7fce15d1ddcb9eaeaea377667b8"))
				-- "abc"
			assert ("", update_sha1_string_no_reset ("bc").is_case_insensitive_equal ("a9993e364706816aba3e25717850c26c9cd0d89d"))
				-- "abcdefghijklmnopqrstuvwxyz"
			assert ("", update_sha1_string_no_reset ("defghijklmnopqrstuvwxyz").is_case_insensitive_equal ("32d10c7b8cf96570ca04ce37f2a19d84240d3a89"))
		end

	test_sha1_no_reset_1
			--
		local
			l_sha1_string: STRING
		do
			l_sha1_string := sha1_string ("abc")
			assert ("", not l_sha1_string.is_case_insensitive_equal (update_sha1_string_no_reset ("")))
			assert ("", not l_sha1_string.is_case_insensitive_equal (update_sha1_string_no_reset ("a")))
			assert ("", not l_sha1_string.is_case_insensitive_equal (update_sha1_string_no_reset ("b")))
			assert ("", l_sha1_string.is_case_insensitive_equal (update_sha1_string_no_reset ("c")))
		end

	test_file
			-- Test computaton from file
		local
			l_file: RAW_FILE
			l_s: STRING
		do
			create l_file.make_create_read_write ("sha1_test.tmp")
			l_file.put_string ("12345678901234567890123456789012345678901234567890123456789012345678901234567890")
			l_file.close

			create l_file.make_open_read ("sha1_test.tmp")
			l_s := sha1_from_file (l_file)
			l_file.close
			l_file.delete
			assert ("sha1 from file", l_s.is_case_insensitive_equal ("50abf5706a150990a08b2c5ea40fa0e585554732"))
		end

	test_sha1_reset_update
			-- SHA1 + salt using update from bytes
			-- and update from string
		local
			s1,s2: STRING
            h_s: STRING
            h_b: SPECIAL [NATURAL_8]
            l_content: STRING
            l_salt: STRING
            l_encoder: UTF_CONVERTER
		do
			sha1.reset
            sha1.update_from_string ("salt")
            sha1.update_from_string ("content")
            h_s := sha1.digest_as_string

			sha1_1.reset
            sha1_1.update_from_string ("salt")
            sha1_1.update_from_string ("content")
            h_b := sha1_1.digest
            across 1 |..| 1000 as i loop
            	sha1.reset
            	sha1_1.reset

                sha1.update_from_hexadecimal_string (h_s)
                h_s := sha1.digest_as_string

				sha1_1.update_from_bytes (h_b)
				h_b := sha1.digest

				s1 := sha1.digest_as_string
				s2 := sha1_1.digest_as_string
				assert ("Same Hash [" + i.item.out + "]:", s1.same_string_general (s2))
            end


				-- Expected value: 30F914D0BCF42A91973C2695CF3F1041C9F0A295
			s1 := sha1_util_update_from_bytes ("content", "salt")
			s2 := sha1_util_update_from_string ("content", "salt")
			assert ("Same Hash:", s1.same_string_general (s2))
		end

feature {NONE} -- Implementation

	sha1_util_update_from_bytes (content: STRING; salt: STRING): STRING_8
		local
			l_encoder: UTF_CONVERTER
			hash: SPECIAL [NATURAL_8]
		do
			sha1.reset
			sha1.update_from_string (salt)
			sha1.update_from_string (content)
			hash := sha1.digest
			across 1 |..| 1000 as i loop
				sha1.reset
				sha1.update_from_bytes (hash)
				hash := sha1.digest
			end
			Result := sha1.digest_as_string
		end

	 sha1_util_update_from_string (content: STRING; salt: STRING): STRING
        local
            hash: STRING
            l_content: STRING
            l_salt: STRING
            l_encoder: UTF_CONVERTER
        do
            sha1.reset
            sha1.update_from_string (salt)
            sha1.update_from_string (content)
            hash := sha1.digest_as_string
            across 1 |..| 1000 as i loop
                sha1.reset
                sha1.update_from_hexadecimal_string (hash)
                hash := sha1.digest_as_string
            end
            Result := hash
        end


	sha1_string (a_str: STRING): STRING
		do
			sha1.update_from_string (a_str)
			Result := sha1.digest_as_string
			sha1.reset
		end

	sha1_from_file (a_file: FILE): STRING
		do
			sha1.update_from_io_medium (a_file)
			Result := sha1.digest_as_string
			sha1.reset
		end

	update_sha1_string_no_reset (a_str: STRING): STRING
		do
			sha1_1.update_from_string (a_str)
			Result := sha1_1.digest_as_string
		end

	sha1: SHA1
		once
			create Result.make
		end

	sha1_1: SHA1
		once
			create Result.make
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
