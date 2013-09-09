note
	description: "Test for SHA256"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SHA256

inherit
	EQA_TEST_SET

feature -- Test routines

	test_sha256
			-- Test sha256
			-- Test suite from standard specification:
		do
			assert ("", sha256_string ("").is_case_insensitive_equal ("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"))
			assert ("", sha256_string ("a").is_case_insensitive_equal ("ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"))
			assert ("", sha256_string ("abc").is_case_insensitive_equal ("ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"))
			assert ("", sha256_string ("message digest").is_case_insensitive_equal ("f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650"))
			assert ("", sha256_string ("abcdefghijklmnopqrstuvwxyz").is_case_insensitive_equal ("71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73"))
			assert ("", sha256_string ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789").is_case_insensitive_equal ("db4bfcbd4da0cd85a60c3c37d3fbd8805c77f15fc6b1fdfe614ee0a7c8fdb4c0"))
			assert ("", sha256_string ("12345678901234567890123456789012345678901234567890123456789012345678901234567890").is_case_insensitive_equal ("f371bc4a311f2b009eef952dd83ca80e2b60026c8e935592d0f9c308453c813e"))
		end

	test_sha256_no_reset
			-- Test SHA256 without reset.
		do
			assert ("", update_sha256_string_no_reset ("").is_case_insensitive_equal ("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"))
			assert ("", update_sha256_string_no_reset ("a").is_case_insensitive_equal ("ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb"))
				-- "abc"
			assert ("", update_sha256_string_no_reset ("bc").is_case_insensitive_equal ("ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"))
				-- "abcdefghijklmnopqrstuvwxyz"
			assert ("", update_sha256_string_no_reset ("defghijklmnopqrstuvwxyz").is_case_insensitive_equal ("71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73"))
		end

	test_sha256_no_reset_1
			--
		local
			l_sha256_string: STRING
		do
			l_sha256_string := sha256_string ("abc")
			assert ("", not l_sha256_string.is_case_insensitive_equal (update_sha256_string_no_reset ("")))
			assert ("", not l_sha256_string.is_case_insensitive_equal (update_sha256_string_no_reset ("a")))
			assert ("", not l_sha256_string.is_case_insensitive_equal (update_sha256_string_no_reset ("b")))
			assert ("", l_sha256_string.is_case_insensitive_equal (update_sha256_string_no_reset ("c")))
		end

	test_file
			-- Test computaton from file
		local
			l_file: RAW_FILE
			l_s: STRING
		do
			create l_file.make_create_read_write ("sha256_test.tmp")
			l_file.put_string ("12345678901234567890123456789012345678901234567890123456789012345678901234567890")
			l_file.close

			create l_file.make_open_read ("sha256_test.tmp")
			l_s := sha256_from_file (l_file)
			l_file.close
			l_file.delete
			assert ("sha256 from file", l_s.is_case_insensitive_equal ("f371bc4a311f2b009eef952dd83ca80e2b60026c8e935592d0f9c308453c813e"))
		end

feature {NONE} -- Implementation

	sha256_string (a_str: STRING): STRING
		do
			sha256.update_from_string (a_str)
			Result := sha256.digest_as_string
			sha256.reset
		end

	sha256_from_file (a_file: FILE): STRING
		do
			sha256.update_from_io_medium (a_file)
			Result := sha256.digest_as_string
			sha256.reset
		end

	update_sha256_string_no_reset (a_str: STRING): STRING
		do
			sha256_1.update_from_string (a_str)
			Result := sha256_1.digest_as_string
		end

	sha256: SHA256
		once
			create Result.make
		end

	sha256_1: SHA256
		once
			create Result.make
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
