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

	HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize
		do
			create schedule.make_filled (0, block_size // 4)
			create buffer.make_filled (0, block_size)
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
			create Result.make_filled (0, digest_count)
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

	digest_count: INTEGER = 16
			-- <Precursor>

	block_size: INTEGER = 64
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
			buffer_offset_set: buffer_offset = (old buffer_offset + 1) \\ block_size
		end

feature {NONE} -- Implemetation

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
				if i < 16 then
					f := (b & c) | (b.bit_not & d)
					g := i.to_natural_32
				elseif i < 32 then
					f := (d & b) | (d.bit_not & c)
					g := (5 * i.to_natural_32 + 1) \\ 16
				elseif i < 48 then
					f := b.bit_xor (c).bit_xor (d)
					g := (3 * i.to_natural_32 + 5) \\ 16
				else
					f := c.bit_xor (b | d.bit_not)
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

	buffer: SPECIAL [NATURAL_8]
			-- Buffer

	buffer_offset: INTEGER_32
			-- Buffer offset

	schedule: SPECIAL [NATURAL_32]
			-- Schedule buffer

feature {NONE} -- Access

	integer_sines: ARRAY [NATURAL_32]
			-- Constants are the integer part of the sines of integers (in radians) * 2^32.
		once
			Result :=
				{ARRAY [NATURAL_32]} <<
					0xd76aa478, 0xe8c7b756, 0x242070db, 0xc1bdceee,
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
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
