note
	description: "Summary description for {HMAC_SHA256}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The bureaucracy is expanding to meet the needs of an expanding bureaucracy."

class
	HMAC_SHA256

inherit
	BYTE_FACILITIES

create

	make,
	make_ascii_key

feature {NONE}

	make (key_a: READABLE_INTEGER_X)
		local
			reduced_key: READABLE_INTEGER_X
		do
			if key_a.bytes <= 64 then
				reduced_key := pad_key (key_a)
			else
				reduced_key := reduce_key (key_a)
			end
			ipad := (reduced_key.bit_xor_value (create {INTEGER_X}.make_from_hex_string ("36363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636"))).as_fixed_width_byte_array (64)
			opad := (reduced_key.bit_xor_value (create {INTEGER_X}.make_from_hex_string ("5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c"))).as_fixed_width_byte_array (64)
			create hmac.default_create
			create message_hash.make
			feed_inner_mix
		end

	make_ascii_key (key_a: READABLE_STRING_8)
		local
			key_bytes: SPECIAL [NATURAL_8]
			i: INTEGER
		do
			create key_bytes.make_filled (0, key_a.count)
			from
				i := 1
			until
				i > key_a.count
			loop
				key_bytes [i - 1] := key_a [i].code.to_natural_8
				i := i + 1
			end
			make (create {INTEGER_X}.make_from_bytes (key_bytes, 0, key_bytes.count - 1))
		end

feature

	finish
		local
			hash_inner: SPECIAL [NATURAL_8]
			hash_outer: SPECIAL [NATURAL_8]
			hmac_hash: SHA256
		do
			create hash_inner.make_filled (0, 32)
			message_hash.do_final (hash_inner, 0)
			create hmac_hash.make
			hmac_hash.sink_special_lsb (opad, 0, 63)
			hmac_hash.sink_special_lsb (hash_inner, 0, 31)
			create hash_outer.make_filled (0, 32)
			hmac_hash.do_final (hash_outer, 0)
			create hmac.make_from_bytes (hash_outer, 0, 31)
			finished := True
		ensure
			finished
		end

	finished: BOOLEAN

	hmac: INTEGER_X
--		require
--			finished
--		attribute
--		end

	reset
		do
			message_hash.reset
			finished := False
		ensure
			not finished
		end

feature {NONE}

	reduce_key (key_a: READABLE_INTEGER_X): INTEGER_X
		require
--			key_a.bytes <= 64
		local
			hash: SHA256
			result_bytes: SPECIAL [NATURAL_8]
			key_bytes: SPECIAL [NATURAL_8]
		do
			create hash.make
			key_bytes := key_a.as_bytes
			hash.sink_special (key_bytes, key_bytes.lower, key_bytes.upper)
			create result_bytes.make_filled (0, 64)
			hash.do_final (result_bytes, 0)
			create Result.make_from_bytes (result_bytes, 0, 63)
		end

	pad_key (key_a: READABLE_INTEGER_X): INTEGER_X
		local
			key_bytes: SPECIAL [NATURAL_8]
			result_bytes: SPECIAL [NATURAL_8]
		do
			create result_bytes.make_filled (0, 64)
			key_bytes := key_a.as_bytes
			result_bytes.copy_data (key_bytes, 0, 0, key_bytes.count)
			create Result.make_from_bytes (result_bytes, 0, 63)
		end

	feed_inner_mix
		do
			sink_special_lsb (ipad, 0, 63)
		end

	byte_sink (in: NATURAL_8)
		do
			message_hash.update (in)
		end

	message_hash: SHA256
	ipad: SPECIAL [NATURAL_8]
	opad: SPECIAL [NATURAL_8]
end
