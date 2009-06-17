note
	description: "Provides features to encode and decode messages"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_ENCODING_FACILITIES

create
	make

feature -- Initialization

	make
		do
		end

feature -- Conversion

	encode_natural(a_i: NATURAL; a_is_fragmented: BOOLEAN): NATURAL
			-- Leftshift of the natural (don't use numbers >= 2^31) and subsequent append of the flag bit.
			-- Use decode_natural and decode_flag for decoding.
		require
			no_too_big: a_i < 2147483648
		do
			Result := (a_i |<< 1) + a_is_fragmented.to_integer.as_natural_32
		end

	change_flag(a_i: NATURAL; a_new_flag: BOOLEAN): NATURAL
			-- Changes the flag to "new_flag" and doesn't change the encoded natural.
		do
			Result := (a_i & 0xFFFFFFFE) + a_new_flag.to_integer.as_natural_32
		end

	decode_natural_and_flag (a_i: NATURAL): TUPLE [NATURAL, BOOLEAN]
			-- Convenience feature which combines both decodings (natural and flag)
		do
			Result := [decode_natural (a_i), decode_flag (a_i)]
		end

	decode_natural  (a_i: NATURAL): NATURAL
			-- The natural that was encoded in {ENCODING_FACILITIES}.encode_natural.
		do
			Result := (a_i |>> 1)
		end

	decode_flag (a_i: NATURAL): BOOLEAN
			--`Result': the flag that was encoded in encode_natural
		do
			Result := (a_i.bit_and (1) = 1)
		end

--		test_encoding_facility
--			--
--		local
--			code: XS_ENCODING_FACILITIES
--			d: NATURAL
--			b: BOOLEAN
--			e: NATURAL
--			t: TUPLE [value: NATURAL; flag: BOOLEAN]
--		do
--			d := 2147483647
--			b := false
--			create code.make
--			e := code.encode_natural (d, b)
--			io.new_line
--			io.new_line
--			assert_equal (d, code.decode_natural (e))
--			assert_equal (b, code.decode_flag (e))
--			e := code.change_flag (e, true)
--			assert_equal (d, code.decode_natural (e))
--			assert_equal (code.decode_flag (e), true)
--			t := code.decode_natural_and_flag (e)
--			assert_equal (t.value, d)
--			assert_equal (t.flag, true)
--		end

--	assert_equal (a, b: ANY)
--			--
--		local
--			l_e: DEVELOPER_EXCEPTION
--			retried: BOOLEAN
--		do
--			if not retried then
--				if a /= b then
--					create l_e
--					l_e.set_message ("Not equal")
--					(create {EXCEPTION_MANAGER}).raise (l_e)
--				else
--					print ('.')
--				end
--			else
--				print ('#')
--			end
--		rescue
--			retried := True
--			retry
--		end
end
