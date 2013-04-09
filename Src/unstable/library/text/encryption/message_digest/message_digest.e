note
	description: "[
					This class provides applications the functionality of a message digest algorithm, 
					such as MD5 or SHA. Message digests are secure one-way hash functions that take 
					arbitrary-sized data and output a fixed-length hash value.
				]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MESSAGE_DIGEST

feature -- Access

	digest_as_string: STRING_8
			-- String representation of digest.
		local
			l_digest: like digest
			index, l_upper: INTEGER
		do
			l_digest := digest
			create Result.make (l_digest.count // 2)
			from
				index := l_digest.lower
				l_upper := l_digest.upper
			until
				index > l_upper
			loop
				Result.append (l_digest [index].to_hex_string)
				index := index + 1
			end
		end

	digest: SPECIAL [NATURAL_8]
			-- Final digest
		deferred
		end

	digest_count: INTEGER
			-- Length in bytes of the digest
		deferred
		end

feature -- Element Change

	reset
			-- Reset current diggest for further use.
		deferred
		end

	update_from_byte (a_byte: NATURAL_8)
			-- Append a byte.
		deferred
		end

	update_from_bytes (a_bytes: SPECIAL [NATURAL_8])
			-- Append bytes.
		local
			i, l_upper: INTEGER
		do
			from
				i := 0
				l_upper := a_bytes.upper
			until
				i > l_upper
			loop
				update_from_byte (a_bytes [i])
				i := i + 1
			end
		end

	update_from_string (a_string: READABLE_STRING_8)
			-- Append bytes from `a_string'.
		local
			i, l_upper: INTEGER
		do
			from
				i := 1
				l_upper := a_string.count
			until
				i > l_upper
			loop
				update_from_byte (a_string.code (i).as_natural_8)
				i := i + 1
			end
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
