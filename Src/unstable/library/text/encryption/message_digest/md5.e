note
	description: "[
					MD5 encryption
					
					Usage: 
						1. Call one or more update* to input source to encode.
						2. Call *digest* to get the computed result. 
						
						Note that calls of *digest* does not reset previous result.
						To start new computation, `reset' must be called.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	MD5

inherit
	MESSAGE_DIGEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize
		do
			create schedule.make_filled (0, 16)
			create buffer.make_filled (0, 64)
			reset
		end

feature -- Access

	digest: SPECIAL [NATURAL_8]
			-- <Precursor>
		local
			l_buffer_offset: like buffer_offset
			l_byte_count: like byte_count
			l_h1, l_h2, l_h3, l_h4: NATURAL_32
		do
				-- Save state
			l_buffer_offset := buffer_offset
			l_byte_count := byte_count
			l_h1 := h1
			l_h2 := h2
			l_h3 := h3
			l_h4 := h4

			finish
			create Result.make_filled (0, 16)
			from_natural_32_le (h1, Result, 0)
			from_natural_32_le (h2, Result, 4)
			from_natural_32_le (h3, Result, 8)
			from_natural_32_le (h4, Result, 12)

				-- Restore state, so that further `update_*' can be called.
			buffer_offset := l_buffer_offset
			byte_count := l_byte_count
			h1 := l_h1
			h2 := l_h2
			h3 := l_h3
			h4 := l_h4
		end

	digest_count: INTEGER = 64
			-- <Precursor>

feature -- Element Change

	reset
			-- Reset computation.
		do
			byte_count := 0
			buffer_offset := 0
			h1 := 0x67452301
			h2 := 0xefcdab89
			h3 := 0x98badcfe
			h4 := 0x10325476
		end

feature {NONE} -- Implemetation

	rotate_left_32 (in: NATURAL_32 count: INTEGER_32): NATURAL_32
			-- Left rotate operation
		require
			count_too_small: count >= 0
			count_too_big: count <= 32
		do
			result := (in |<< count) | (in |>> (32 - count))
		ensure
			rotate_definition: Result = (in |<< count) | (in |>> (32 - count))
		end

	update_from_byte (a_byte: NATURAL_8)
			-- <Precursor>
		local
			l_buffer: like buffer
		do
			l_buffer := buffer
			l_buffer [buffer_offset] := a_byte
			buffer_offset := buffer_offset + 1
			byte_count := byte_count + 1

				-- Process the block when the block is ready.
			if buffer_offset > l_buffer.upper then
				process_block
				buffer_offset := 0
			end
		ensure then
			buffer_offset_set: buffer_offset = (old buffer_offset + 1) \\ (digest_count)
		end

	process_block
			-- Process current block in buffer.
		require
			buffer_offset_reset: buffer_offset = 64
		local
			a, b, c, d, f, g, temp: NATURAL_32
			i: INTEGER
			l_sines: like integer_sines
			l_schedule: like schedule
			l_shifts: like shifts_per_round
		do
			a := h1
			b := h2
			c := h3
			d := h4

			schedule_buffer
			l_sines := integer_sines
			l_schedule := schedule
			l_shifts := shifts_per_round
			from
				i := 0
			until
				i > 63
			loop
				if (i < 16) then
					f := (b & c) | (b.bit_not & d)
					g := i.to_natural_32
				elseif (i < 32) then
					f := (d & b) | (d.bit_not & c)
					g := (5 * i.to_natural_32 + 1) \\ 16
				elseif (i < 48) then
					f := b.bit_xor (c).bit_xor (d)
					g := (3 * i.to_natural_32 + 5) \\ 16
				else
					f := c.bit_xor (b | (d.bit_not))
					g := (7 * i.to_natural_32) \\ 16
				end

				temp := d
				d := c
				c := b
				b := b + rotate_left_32 ((a + f + l_sines[i + 1] + l_schedule[g.to_integer_32]), l_shifts[i + 1])
				a := temp

				i := i + 1
			end
			h1 := h1 + a
			h2 := h2 + b
			h3 := h3 + c
			h4 := h4 + d
		end

	schedule_buffer
			-- Put raw bytes into `schedule'.
		require
			buffer_offset_reset: buffer_offset = 64
		local
			i, j, l_upper: INTEGER
			l_buffer: like buffer
			l_schedule: like schedule
		do
			l_buffer := buffer
			l_schedule := schedule
			from
				j := l_schedule.lower
				i := l_buffer.lower
				l_upper := l_buffer.upper
			until
				i > l_upper
			loop
				l_schedule [j] := as_natural_32_le (l_buffer, i)
				i := i + 4
				j := j + 1
			end
		end

	as_natural_32_le (source: SPECIAL [NATURAL_8] offset: INTEGER_32): NATURAL_32
			-- NATURAL_32 from bytes.
		require
			valid_start: source.valid_index (offset)
			valid_end: source.valid_index (offset + 3)
		do
			Result := source [offset].to_natural_32
			Result := Result | (source [offset + 1].to_natural_32 |<< 8)
			Result := Result | (source [offset + 2].to_natural_32 |<< 16)
			Result := Result | (source [offset + 3].to_natural_32 |<< 24)
		ensure
			byte_0: source [offset] = Result.to_natural_8
			byte_1: source [offset + 1] = (Result |>> 8).to_natural_8
			byte_2: source [offset + 2] = (Result |>> 16).to_natural_8
			byte_3: source [offset + 3] = (Result |>> 24).to_natural_8
		end

	from_natural_32_le (source: NATURAL_32 target: SPECIAL [NATURAL_8] offset: INTEGER_32)
			-- Put `source' into `target'.
		require
			valid_start: target.valid_index (offset)
			valid_end: target.valid_index (offset + 3)
		do
			target [offset] := source.to_natural_8
			target [offset + 1] := (source |>> 8).to_natural_8
			target [offset + 2] := (source |>> 16).to_natural_8
			target [offset + 3] := (source |>> 24).to_natural_8
		ensure
			byte_0: target [offset] = source.to_natural_8
			byte_1: target [offset + 1] = (source |>> 8).to_natural_8
			byte_2: target [offset + 2] = (source |>> 16).to_natural_8
			byte_3: target [offset + 3] = (source |>> 24).to_natural_8
		end

	finish
			-- Finish updating, get ready to process the last block.
		local
			length: NATURAL_64
		do
			length := bit_count
			pad
			process_length (length)
		end

	pad
			-- Pad with zero until 64bit is left in current block.
		local
			pad_bytes: INTEGER_32
		do
			update_from_byte (0b1000_0000)
			from
				pad_bytes := (56 - (byte_count \\ 64)).to_integer_32
				if pad_bytes < 0 then
					pad_bytes := pad_bytes + 64
				end
			until
				pad_bytes = 0
			loop
				update_from_byte (0)
				pad_bytes := pad_bytes - 1
			end
		end

	process_length (length: NATURAL_64)
			-- Update length into the buffer.
		do
			update_from_byte ((length).to_natural_8)
			update_from_byte ((length |>> 8).to_natural_8)
			update_from_byte ((length |>> 16).to_natural_8)
			update_from_byte ((length |>> 24).to_natural_8)
			update_from_byte ((length |>> 32).to_natural_8)
			update_from_byte ((length |>> 40).to_natural_8)
			update_from_byte ((length |>> 48).to_natural_8)
			update_from_byte ((length |>> 56).to_natural_8)
		end

	bit_count: NATURAL_64
			-- Bit count
		do
			result := byte_count |<< 3
		end

	buffer: SPECIAL [NATURAL_8]
			-- Buffer

	buffer_offset: INTEGER_32
			-- Buffer offset

	schedule: SPECIAL [NATURAL_32]
			-- Schedule buffer

	byte_count: NATURAL_64
			-- Byte count

feature {NONE} -- Access

	integer_sines: ARRAY [NATURAL_32]
			-- Constants are the integer part of the sines of integers (in radians) * 2^32.
		once
			Result :=
			<<  0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee,
				0xf57c0faf, 0x4787c62a, 0xa8304613, 0xfd469501,
				0x698098d8, 0x8b44f7af, 0xffff5bb1, 0x895cd7be,
				0x6b901122, 0xfd987193, 0xa679438e, 0x49b40821,
				0xf61e2562, 0xc040b340, 0x265e5a51, 0xe9b6c7aa,
				0xd62f105d, 0x02441453, 0xd8a1e681, 0xe7d3fbc8,
				0x21e1cde6, 0xc33707d6, 0xf4d50d87, 0x455a14ed,
				0xa9e3e905, 0xfcefa3f8, 0x676f02d9, 0x8d2a4c8a,
				0xfffa3942, 0x8771f681, 0x6d9d6122, 0xfde5380c,
				0xa4beea44, 0x4bdecfa9, 0xf6bb4b60, 0xbebfbc70,
				0x289b7ec6, 0xeaa127fa, 0xd4ef3085, 0x04881d05,
				0xd9d4d039, 0xe6db99e5, 0x1fa27cf8, 0xc4ac5665,
				0xf4292244, 0x432aff97, 0xab9423a7, 0xfc93a039,
				0x655b59c3, 0x8f0ccc92, 0xffeff47d, 0x85845dd1,
				0x6fa87e4f, 0xfe2ce6e0, 0xa3014314, 0x4e0811a1,
				0xf7537e82, 0xbd3af235, 0x2ad7d2bb, 0xeb86d391
			>>
		end

	shifts_per_round: ARRAY [INTEGER]
			-- Per-round shift amounts
		once
			Result := <<7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
						5,  9, 14, 20, 5,  9, 14, 20, 5,  9, 14, 20, 5,  9, 14, 20,
						4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
						6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21
					>>
		end

	h1: NATURAL_32
	h2: NATURAL_32
	h3: NATURAL_32
	h4: NATURAL_32;

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
