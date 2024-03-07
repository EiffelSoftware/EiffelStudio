note
	description: "Representation of a blob data"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_BLOB_DATA

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make
			-- Allocated `item'.
		do
			create item.make (Default_size)
			current_position := 0
		end

feature -- Access

	is_empty: BOOLEAN
		do
			Result := count = 0
		end

	count: INTEGER
			-- Size of structure once emitted.
		do
			Result := current_position
		end

	item: MANAGED_POINTER
			-- C structures that holds signature.

feature -- Element change

	put_boolean (v: BOOLEAN)
			-- Insert `v' at `current_position'.
		do
			if v then
				put_integer_8 (1)
			else
				put_integer_8 (0)
			end
		end

	put_character (c: CHARACTER)
			-- Insert `c' at `current_position'.
		do
			put_integer_16 (c.code.to_integer_16)
		end

	put_real_32 (r: REAL)
			-- Insert `r' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_real_32_le (r, l_pos)
			current_position := l_pos + 4
		end

	put_real_64 (d: DOUBLE)
			-- Insert `d' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_real_64_le (d, l_pos)
			current_position := l_pos + 8
		end

	put_integer_8 (i: INTEGER_8)
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 1)
			item.put_integer_8_le (i, l_pos)
			current_position := l_pos + 1
		end

	put_integer_16 (i: INTEGER_16)
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 2)
			item.put_integer_16_le (i, l_pos)
			current_position := l_pos + 2
		end

	put_integer_32 (i: INTEGER)
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_integer_32_le (i, l_pos)
			current_position := l_pos + 4
		end

	put_integer_64 (i: INTEGER_64)
			-- Insert `i' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_integer_64_le (i, l_pos)
			current_position := l_pos + 8
		end

	put_natural_8 (n: NATURAL_8)
			-- Insert `n' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 1)
			item.put_natural_8_le (n, l_pos)
			current_position := l_pos + 1
		end

	put_natural_16 (n: NATURAL_16)
			-- Insert `n' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 2)
			item.put_natural_16_le (n, l_pos)
			current_position := l_pos + 2
		end

	put_natural_32 (n: NATURAL_32)
			-- Insert `n' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 4)
			item.put_natural_32_le (n, l_pos)
			current_position := l_pos + 4
		end

	put_natural_64 (n: NATURAL_64)
			-- Insert `n' at `current_position'.
		local
			l_pos: INTEGER
		do
			l_pos := current_position
			allocate (l_pos + 8)
			item.put_natural_64_le (n, l_pos)
			current_position := l_pos + 8
		end

feature -- Compressed data

	put_compressed_natural_32 (v: NATURAL_32)
		do
			compress_unsigned_data (v.to_integer_32)
		end

	put_compressed_signed_integer_32 (v: INTEGER_32)
		do
			compress_signed_data (v)
		end

feature -- Copy

	as_special: SPECIAL [NATURAL_8]
			-- Copy of Current as SPECIAL.
		local
			i, nb: INTEGER
		do
			from
				i := 0
				nb := current_position
				create Result.make_filled (0, nb)
			until
				i = nb
			loop
				Result.put (item.read_natural_8 (i), i)
				i := i + 1
			end
		ensure
			as_special_not_void: Result /= Void
			same_count: Result.count = current_position
		end

	as_array: ARRAY [NATURAL_8]
			-- Copy of Current as ARRAY
		do
			create Result.make_from_special (as_special)
		end

feature -- Status report

	debug_output: STRING
		local
			n: INTEGER
			n8: NATURAL_8
		do
			n := count * 2
			create Result.make (n)
			across
				as_array as ic
			loop
				n8 := ic.item
				Result.append_string (n8.to_hex_string)
				Result.append_character('-')
			end
			Result.remove_tail (1)
		end

feature {NONE} -- Implementation

	compress_unsigned_data (i: INTEGER)
			-- Compress `i' using Partition II 23.2 specification
			-- and store it at currrent_position in current.
		note
			eis: "name=Unsigned Integers", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=237&zoom=100,116,848", "protocol=uri"
		require
			valid_i: i <= 0x20000000
		local
			l_pos, l_incr: INTEGER
			n16: NATURAL_16
			n32: NATURAL_32
		do
			l_pos := current_position

			if i <= 0x7F then
					-- Simply copy first byte.
				internal_put (i.to_integer_8, l_pos)
				l_incr := 1;
			elseif i <= 0x3FFF then
					-- Copy two bytes added with 0x00008000.
				n16 := i.to_natural_16 + 0x00008000
				internal_put (((n16 & 0x0000FF00) |>> 8).to_integer_8, l_pos)
				internal_put ((n16 & 0x000000FF).to_integer_8, l_pos + 1)
				l_incr := 2
			else
					-- Copy four bytes added with 0xC0000000
				n32 := i.to_natural_32 + 0xC0000000
				internal_put (((n32 & 0xFF000000) |>> 24).to_integer_8, l_pos)
				internal_put (((n32 & 0x00FF0000) |>> 16).to_integer_8, l_pos + 1)
				internal_put (((n32 & 0x0000FF00) |>> 8).to_integer_8, l_pos + 2)
				internal_put ((n32 & 0x000000FF).to_integer_8, l_pos + 3)
				l_incr := 4
			end
			current_position := l_pos + l_incr
		end

	compress_signed_data (i: INTEGER)
			-- Compress `i' using using Partition II 23.2 specification for
			-- signed integers and store it at currrent_position in current.
		note
			eis: "name=Signed Integers", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=237&zoom=100,116,848", "protocol=uri"
		require
			valid_i:  i >= -0x10000000 and i <= 0x0FFFFFFF
				--checks if the input integer i lies between -2^28 and 2^28 - 1 inclusive
		local
			l_pos, l_incr: INTEGER
			n8: NATURAL_8
			n16: NATURAL_16
			n32: NATURAL_32
		do
			l_pos := current_position

			if -0x40 <= i and i <= 0x3F then -- 2^6 and 2^6 -1 inclusive	
					--	Represent the value as a 7-bit 2’s complement number, giving 0x40 (-2^6) to 0x3F (2^6-1);
				n8 := i.to_natural_8

					--	Rotate this value 1 bit left, giving 0x01 (-2^6) to 0x7E (2^6-1);
				n8 := (n8 |<< 1 + (n8 & 0b1000_0000) |>> 7) & 0b0111_1111

					--	Encode as a one-byte integer, bit 7 clear, rotated value in bits 6 through 0, giving 0x01 (-2^6) to 0x7E (2^6-1).
				n8 := n8 & 0x7F

				internal_put (n8.to_integer_8, l_pos)
				l_incr := 1

			elseif -0x2000 <= i and i <= 0x1FFF then -- 2^13 and 2^13 -1 inclusive
				n16 := i.to_natural_16
					-- Represent the value as a 14-bit 2’s complement number, giving 0x2000 (-2^13) to 0x1FFF (2^13-1)
				n16 := n16 & 0b0011_1111_1111_1111
					-- Rotate this value 1 bit left, giving 0x0001 (-2^13) to 0x3FFE (2^13-1);
				n16 := (n16 |<< 1 + (n16 & 0b0010_0000_0000_0000) |>> 13) & 0b0011_1111_1111_1111

					-- Encode as a two-byte integer: bit 15 set, bit 14 clear, rotated value
					-- in bits 13 through 0, giving 0x8001 (-2^13) to 0xBFFE (2^13-1).
				n16 := (n16 + 0b1000_0000_0000_0000) & 0b1011_1111_1111_1111

				internal_put (((n16 & 0b1111_1111_0000_0000) |>> 8).to_integer_8, l_pos)
				internal_put ( (n16 & 0b0000_0000_1111_1111).to_integer_8, l_pos + 1)
				l_incr := 2
			else
				n32 := i.to_natural_32
					-- Represent the value as a 29-bit 2’s complement representation,
					-- giving 0x10000000 (-2^28) to 0xFFFFFFF (2^28-1);
				n32 := n32 & 0b0011_1111_1111_1111_1111_1111_1111_1111

					-- Rotate this value 1-bit left, giving 0x00000001 (-2^28) to 0x1FFFFFFE (2^28-1)
				n32 := (n32 |<< 1 + (n32 & 0b0010_0000_0000_0000_0000_0000_0000_0000) |>> 29) & 0b0011_1111_1111_1111_1111_1111_1111_1111

					-- Encode as a four-byte integer: bit 31 set, bit 30 set, bit 29 clear,
					-- rotated value in bits 28 through 0
				n32 := (n32 + 0b1100_0000_0000_0000_0000_0000_0000_0000) & 0b1101_1111_1111_1111_1111_1111_1111_1111


				internal_put (((n32 & 0xFF000000) |>> 24).to_integer_8, l_pos)
				internal_put (((n32 & 0x00FF0000) |>> 16).to_integer_8, l_pos + 1)
				internal_put (((n32 & 0x0000FF00) |>> 8).to_integer_8, l_pos + 2)
				internal_put ( (n32 & 0x000000FF).to_integer_8, l_pos + 3)
				l_incr := 4
			end
			current_position := l_pos + l_incr
		end

	internal_put (val: INTEGER_8; pos: INTEGER)
			-- Safe insertion that will resize `internal_body' if needed.
		require
			valid_pos: pos >= 0
		do
			allocate (pos + 1)
			item.put_integer_8_le (val, pos)
		end

feature -- Uncompressing

	uncompressed_unsigned_data (v: MANAGED_POINTER; pos: INTEGER; nb_bytes: detachable CELL [INTEGER_32]): INTEGER_32
		local
			i1, i2, i3, i4: NATURAL_8
			res: NATURAL_32
			l_bytes_count: INTEGER
		do
			--| See II.23.2 Blobs and signatures (https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf)
			i1 := v.read_natural_8 (pos + 0)
			if i1 & 0x80 = 0 then --<= 0x7F then
				res := i1
				l_bytes_count := 1
			else
				i2 := v.read_natural_8 (pos + 1)
				if i1 & 0x40 = 0 then
					l_bytes_count := 2
					res := ((i1 & 0x3F).to_natural_32 |<< 8) | i2.to_natural_32
				else
					i3 := v.read_natural_8 (pos + 2)
					i4 := v.read_natural_8 (pos + 3)
					if i1 & 0x20 = 0 then
						l_bytes_count := 4
						res := ((i1.to_natural_32 & 0x1F) |<< 24).to_natural_32
							| ( i2.to_natural_32 |<< 16).to_natural_32
							| ( i3.to_natural_32 |<< 8).to_natural_32
							| ( i4).to_natural_32
					end
				end
			end
			if nb_bytes /= Void then
				nb_bytes.replace (l_bytes_count)
			end
			Result := res.to_integer_32
		ensure
			class
		end

	uncompressed_signed_data (v: MANAGED_POINTER; pos: INTEGER; nb_bytes: detachable CELL [INTEGER_32]): INTEGER_32
		local
			l_bytes_count: INTEGER
			l_sign_extend: BOOLEAN
			val: INTEGER_32
			l_nb_bytes: CELL [INTEGER_32]
		do
			l_nb_bytes := nb_bytes
			if l_nb_bytes = Void then
				create l_nb_bytes.put (0)
			end
			val := uncompressed_unsigned_data (v, pos, l_nb_bytes)
			l_bytes_count := l_nb_bytes.item

			l_sign_extend := (val & 0x1) /= 0
            val := val |>> 1

			if l_sign_extend then
				inspect l_bytes_count
				when 1 then
					val := val | 0xFFFF_FFC0
				when 2 then
					val := val | 0xFFFF_E000
				else
					val := val | 0xF000_0000
				end
			end
			Result := val
			if nb_bytes /= Void then
				nb_bytes.replace (l_bytes_count)
			end
		ensure
			class
		end

feature {NONE} -- Internal signature

	current_position: INTEGER
			-- Current position in `internal_body' for next insertion.

	default_size: INTEGER = 20
			-- Default allocated size for a signature.

feature {NONE} -- Stack depth management

	allocate (new_size: INTEGER)
			-- Resize `item' if needed so that it can accomdate `new_size'.
		local
			l_capacity: INTEGER
		do
			l_capacity := item.count
			if new_size > l_capacity then
				item.resize (new_size.max (l_capacity + Default_size))
			end
		ensure
			enough_size: item.count >= new_size
		end

invariant
	item_not_void: item /= Void

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
