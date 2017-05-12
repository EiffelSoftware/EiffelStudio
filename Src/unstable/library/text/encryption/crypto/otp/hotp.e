note
	description: "[
			HMAC-based One-time Password Algorithm. (HOTP)

			see https://en.wikipedia.org/wiki/HMAC-based_One-time_Password_Algorithm
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=HOTP", "protocol=URI", "src=https://tools.ietf.org/html/rfc4226"

class
	HOTP

create
	make_with_secret

feature {NONE} -- Initialization

	make_with_secret (k: READABLE_STRING_8)
			-- Initialize current with secret `k`.
		do
			secret := k
			digits_count := 6
		end

feature -- Access

	secret: IMMUTABLE_STRING_8
			-- Secret key.

	digits_count: INTEGER
			-- Number of digits.
			-- Default: 6

feature -- Basic operation

	token (a_counter: NATURAL_64): STRING
			-- Token for counter `a_counter`.
		local
			ba: BYTE_ARRAY_CONVERTER
			hmac: HMAC_SHA1
			v: NATURAL_64
			o: INTEGER
			l_bytes: SPECIAL [NATURAL_8]
		do
				-- HMAC Key
			create ba.make_from_string ((create {BASE32}).decoded_string (secret))
			create hmac.make (ba.to_natural_8_special)

				-- HMAC Counter message
			create ba.make_from_natural_64 (8, a_counter)
			hmac.update_from_bytes (ba.to_natural_8_special)

				-- HMAC digest
			l_bytes := hmac.digest

				-- Truncate (see https://tools.ietf.org/html/rfc4226#section-5.3 )
			o := l_bytes [l_bytes.count - 1] & 15
			create ba.make (4)
			ba.extend (l_bytes [o])
			ba.extend (l_bytes [o + 1])
			ba.extend (l_bytes [o + 2])
			ba.extend (l_bytes [o + 3])
			v := ba.to_natural_64 & 0x7fff_ffff
			Result := (v \\ (10 ^ digits_count).truncated_to_integer_64.as_natural_64).out

			from
			until
				Result.count >= digits_count
			loop
				Result.prepend_character ('0')
			end
		ensure
			digits_count_satisfied: Result.count = digits_count
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
