note
	description: "Test for MD5"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_MD5

inherit
	EQA_TEST_SET

feature -- Test routines

	test_md5
			-- Test md5
			-- Test suite from standard specification:
			-- http://tools.ietf.org/html/rfc1321
		do
			md5.reset
			assert ("", md5_string ("").is_case_insensitive_equal ("d41d8cd98f00b204e9800998ecf8427e"))
			assert ("", md5_string ("a").is_case_insensitive_equal ("0cc175b9c0f1b6a831c399e269772661"))
			assert ("", md5_string ("abc").is_case_insensitive_equal ("900150983cd24fb0d6963f7d28e17f72"))
			assert ("", md5_string ("message digest").is_case_insensitive_equal ("f96b697d7cb7938d525a2f31aaf161d0"))
			assert ("", md5_string ("abcdefghijklmnopqrstuvwxyz").is_case_insensitive_equal ("c3fcd3d76192e4007dfb496cca67e13b"))
			assert ("", md5_string ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789").is_case_insensitive_equal ("d174ab98d277d9f5a5611c2c9f419d9f"))
			assert ("", md5_string ("12345678901234567890123456789012345678901234567890123456789012345678901234567890").is_case_insensitive_equal ("57edf4a22be3c955ac49da2e2107b67a"))
		end

	test_md5_no_reset
			-- Test MD5 without reset.
		do
			md5.reset
			assert ("", update_md5_string_no_reset ("").is_case_insensitive_equal ("d41d8cd98f00b204e9800998ecf8427e"))
			assert ("", update_md5_string_no_reset ("a").is_case_insensitive_equal ("0cc175b9c0f1b6a831c399e269772661"))
				-- "abc"
			assert ("", update_md5_string_no_reset ("bc").is_case_insensitive_equal ("900150983cd24fb0d6963f7d28e17f72"))
				-- "abcdefghijklmnopqrstuvwxyz"
			assert ("", update_md5_string_no_reset ("defghijklmnopqrstuvwxyz").is_case_insensitive_equal ("c3fcd3d76192e4007dfb496cca67e13b"))
		end

	test_md5_no_reset_1
			--
		local
			l_md5_string: STRING
		do
			l_md5_string := md5_string ("abc")
			assert ("", not l_md5_string.is_case_insensitive_equal (update_md5_string_no_reset ("")))
			assert ("", not l_md5_string.is_case_insensitive_equal (update_md5_string_no_reset ("a")))
			assert ("", not l_md5_string.is_case_insensitive_equal (update_md5_string_no_reset ("b")))
			assert ("", l_md5_string.is_case_insensitive_equal (update_md5_string_no_reset ("c")))
		end

	test_file
			-- Test computaton from file
		local
			l_file: RAW_FILE
			l_s: STRING
		do
			create l_file.make_create_read_write ("md5_test.tmp")
			l_file.put_string ("12345678901234567890123456789012345678901234567890123456789012345678901234567890")
			l_file.close

			create l_file.make_open_read ("md5_test.tmp")
			l_s := md5_from_file (l_file)
			l_file.close
			l_file.delete
			assert ("md5 from file", l_s.is_case_insensitive_equal ("57edf4a22be3c955ac49da2e2107b67a"))
		end

feature {NONE} -- Implementation

	md5_string (a_str: STRING): STRING
		do
			md5.update_from_string (a_str)
			Result := md5.digest_as_string
			md5.reset
		end

	md5_from_file (a_file: FILE): STRING
		do
			md5.update_from_io_medium (a_file)
			Result := md5.digest_as_string
			md5.reset
		end

	update_md5_string_no_reset (a_str: STRING): STRING
		do
			md5_1.update_from_string (a_str)
			Result := md5_1.digest_as_string
		end

	md5: MD5
		once
			create Result.make
		end

	md5_1: MD5
		once
			create Result.make
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
