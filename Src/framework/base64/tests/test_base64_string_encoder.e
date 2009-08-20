note
	description: "[
		Tests for {BASE64_STRING_ENCODER}.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_BASE64_STRING_ENCODER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_encoder
			-- Tests encoding from an Eiffel {STRING_8}
        note
        	testing:  "covers/{BASE64_ENCODER}.encode64"
            testing:  "covers/{BASE64_STRING_ENCODER}.encode64"
		local
			l_encoder: BASE64_STRING_ENCODER
			l_value: STRING
		do
			create l_encoder
			l_value := l_encoder.encode64 ("A")
			assert ("correct_encoding_1", l_value ~ "QQ==")
			l_value := l_encoder.encode64 ("AB")
			assert ("correct_encoding_2", l_value ~ "QUI=")
			l_value := l_encoder.encode64 ("ABC")
			assert ("correct_encoding_3", l_value ~ "QUJD")
			l_value := l_encoder.encode64 ("ABCD")
			assert ("correct_encoding_4", l_value ~ "QUJDRA==")
			l_value := l_encoder.encode64 ("ABCDE")
			assert ("correct_encoding_5", l_value ~ "QUJDREU=")
			l_value := l_encoder.encode64 ("ABCDEF")
			assert ("correct_encoding_6", l_value ~ "QUJDREVG")
		end

	test_decoder
			-- Tests decoding to an Eiffel {STRING_8}
        note
            testing:  "covers/{BASE64_STRING_ENCODER}.decode64"
		local
			l_encoder: BASE64_STRING_ENCODER
			l_value: STRING
		do
			create l_encoder
			l_value := l_encoder.decode64 ("QQ==")
			assert ("correct_decoding_1", l_value ~ "A")
			l_value := l_encoder.decode64 ("QUI=")
			assert ("correct_decoding_2", l_value ~ "AB")
			l_value := l_encoder.decode64 ("QUJD")
			assert ("correct_decoding_3", l_value ~ "ABC")
			l_value := l_encoder.decode64 ("QUJDRA==")
			assert ("correct_decoding_4", l_value ~ "ABCD")
			l_value := l_encoder.decode64 ("QUJDREU=")
			assert ("correct_decoding_5", l_value ~ "ABCDE")
			l_value := l_encoder.decode64 ("QUJDREVG")
			assert ("correct_decoding_6", l_value ~ "ABCDEF")
		end

	test_encode_decode
			-- Tests encoding and decoding process.
        note
        	testing:  "covers/{BASE64_ENCODER}.encode64"
            testing:  "covers/{BASE64_STRING_ENCODER}.encode64"
            testing:  "covers/{BASE64_STRING_ENCODER}.decode64"
		local
			l_encoder: BASE64_STRING_ENCODER
			l_strings: like strings
			l_string: STRING_8
			l_encoded: STRING_8
			l_decoded: STRING_8
		do
			create l_encoder
			l_strings := strings
			from l_strings.start until l_strings.after loop
				l_string := l_strings.item
				l_encoded := l_encoder.encode64 (l_string)
				l_decoded := l_encoder.decode64 (l_encoded)
				assert ("symmetric_decoding_" + l_strings.index.out, l_string ~ l_decoded)
				l_strings.forth
			end
		end

feature {NONE} -- Implementation

	strings: ARRAYED_LIST [STRING]
			-- List of random strings.
		local
			i: INTEGER
			l_rnd: RANDOM
		once
			create Result.make (100)
			create l_rnd.set_seed (2130498)
			from i := 1 until i > 100 loop
				Result.extend (random_string (i, l_rnd))
				i := i + 1
			end
		end

	random_string (a_len: INTEGER; a_rnd: RANDOM): STRING
			-- Generates a random series of characters.
		local
			l_next: INTEGER
			i, j: INTEGER
		do
			create Result.make (a_len)
			from i := 1 until i > a_len loop
				l_next := (a_rnd.next_random (i + j) & 0xFF)
				if l_next.is_valid_character_8_code then
					Result.append_code (l_next.as_natural_32)
					i := i + 1
				else
					j := j + 1
				end
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

end
