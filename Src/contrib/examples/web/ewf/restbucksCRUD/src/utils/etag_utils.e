note
	description: "Summary description for {ETAG_UTILS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ETAG_UTILS

inherit
	ARRAY_FACILITIES

feature -- Access

	md5_digest (a_string: STRING): STRING
			-- Cryptographic hash function that produces a 128-bit (16-byte) hash value, based on `a_string'
		local
			md5: MD5
			output: SPECIAL [NATURAL_8]
		do
			create md5.make
			create output.make_filled (0, 16)
			md5.sink_string (a_string)
			md5.do_final (output, 0)
			Result := as_natural_32_be (output, 0).to_hex_string
			Result.append (as_natural_32_be (output, 4).to_hex_string)
			Result.append (as_natural_32_be (output, 8).to_hex_string)
			Result.append (as_natural_32_be (output, 12).to_hex_string)
		end

note
	copyright: "2011-2012, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
