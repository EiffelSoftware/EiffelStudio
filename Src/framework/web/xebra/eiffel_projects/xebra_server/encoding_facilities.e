note
	description: "Summary description for {ENCODING_FACILITIES}."
	author: "sdz"
	date: "$Date$"
	revision: "$Revision$"

class
	ENCODING_FACILITIES

create
	make

feature -- Initialization
	make
		local
		do

		end

feature --encoding
	encode_natural(i: NATURAL; fragmented: BOOLEAN): NATURAL
		--leftshift of the natural (don't use numbers >= 2^31) and subsequent append of the flag bit
		--use decode_natural and decode_flag for decoding
		require
			no_too_big: i < 2147483648
		do
			result := (i |<< 1) + fragmented.to_integer.as_natural_32
		end

	change_flag(i: NATURAL; new_flag: BOOLEAN): NATURAL
		--changes the flag to "new_flag" and doesn't change the encoded natural
		do
			result := (i & 0xFFFFFFFE) + new_flag.to_integer.as_natural_32
		end

feature --decoding
	decode_natural_and_flag (i: NATURAL): TUPLE[NATURAL, BOOLEAN]
		--convenience feature which combines both decodings (natural and flag)
		do
			result := [decode_natural(i), decode_flag(i)]
		end

	decode_natural  (i: NATURAL): NATURAL
		--returns the natural that was encoded in encode_natural
		do
			result := (i |>> 1)
		end

	decode_flag (i: NATURAL): BOOLEAN
		--`Result': the flag that was encoded in encode_natural
		do
			result := (i.bit_and (1) = 1)
		end
end
