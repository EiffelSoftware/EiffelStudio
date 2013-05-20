note
	description: "[
		Provides features to encode and decode messages
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_ENCODING_FACILITIES

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

note
	copyright: "2011-2011, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
