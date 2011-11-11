note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Blessed are the young, for they shall inherit the national debt. - Herbert Hoover"

class
	MD5

inherit
	ANY
		redefine
			is_equal
		end
	SHA_FUNCTIONS
		rename
			ch as f,
			parity as h,
			byte_sink as update
		export
			{MD5}
				schedule,
				buffer,
				byte_count,
				schedule_offset,
				buffer_offset
		undefine
			is_equal
		redefine
			process_length,
			process_word,
			update_word
		end
	ROTATE_FACILITIES
		undefine
			is_equal
		end
	DEBUG_OUTPUT
		undefine
			is_equal
		end

create
	make,
	make_copy

feature
	make
		do
			create schedule.make_filled (0, 16)
			create buffer.make_filled (0, 4)
			reset
		end

	make_copy (other: like Current)
		do
			make
			schedule.copy_data (other.schedule, other.schedule.lower, schedule.lower, schedule.count)
			buffer.copy_data (other.buffer, other.buffer.lower, buffer.lower, buffer.count)
			h1 := other.h1
			h2 := other.h2
			h3 := other.h3
			h4 := other.h4
			schedule_offset := other.schedule_offset
			byte_count := other.byte_count
			buffer_offset := other.buffer_offset
		ensure
			Current ~ other
		end

feature
	reset
		do
			byte_count := 0
			schedule_offset := 0
			buffer_offset := 0
			h1 := 0x67452301
			h2 := 0xefcdab89
			h3 := 0x98badcfe
			h4 := 0x10325476
		ensure
			byte_count = 0
			schedule_offset = 0
			buffer_offset = 0
			h1 = 0x67452301
			h2 = 0xefcdab89
			h3 = 0x98badcfe
			h4 = 0x10325476
		end

	do_final (output: SPECIAL [NATURAL_8] offset: INTEGER_32)
		require
			valid_start: output.valid_index (offset)
			valid_end: output.valid_index (offset + 15)
		do
			finish
			from_natural_32_le (h1, output, offset)
			from_natural_32_le (h2, output, offset + 4)
			from_natural_32_le (h3, output, offset + 8)
			from_natural_32_le (h4, output, offset + 12)
			reset
		end

	current_final (output: SPECIAL [NATURAL_8] offset: INTEGER_32)
		require
			valid_start: output.valid_index (offset)
			valid_end: output.valid_index (offset + 15)
		local
			current_copy: like Current
		do
			create current_copy.make_copy (Current)
			current_copy.do_final (output, offset)
		end

	current_out: STRING
		local
			output: SPECIAL [NATURAL_8]
			index: INTEGER_32
		do
			Result := "0x"
			create output.make_filled (0, 16)
			current_final (output, 0)
			from
				index := 0
			until
				index = 16
			loop
				Result.append (output [index].to_hex_string)
				index := index + 1
			end
		end

	is_equal (other: like Current): BOOLEAN
		do
			Result :=
			schedule.same_items (other.schedule, other.schedule.lower, schedule.lower, schedule.count) and
			buffer.same_items (other.buffer, other.buffer.lower, buffer.lower, buffer.count) and
			h1 = other.h1 and
			h2 = other.h2 and
			h3 = other.h3 and
			h4 = other.h4 and
			schedule_offset = other.schedule_offset and
			byte_count = other.byte_count and
			buffer_offset = other.buffer_offset
		end

feature {NONE}
	g (u: NATURAL_32 v: NATURAL_32 w: NATURAL_32): NATURAL_32
		do
			result := (u & w) | (v & w.bit_not)
		end

	k (u: NATURAL_32 v: NATURAL_32 w: NATURAL_32): NATURAL_32
		do
			result := v.bit_xor (u | w.bit_not)
		end

	process_length (length: NATURAL_64)
		do
			update_word (length.to_natural_32)
			update_word ((length |>> 32).to_natural_32)
		end

feature {NONE}
	process_word (in: SPECIAL [NATURAL_8] offset: INTEGER_32)
		do
			schedule [schedule_offset] := as_natural_32_le (in, offset)
			schedule_offset := schedule_offset + 1
			if
				schedule_offset = 16
			then
				schedule_offset := 0
				process_block
			end
		end

	update_word (in: NATURAL_32)
		do
			update (in.to_natural_8)
			update ((in |>> 8).to_natural_8)
			update ((in |>> 16).to_natural_8)
			update ((in |>> 24).to_natural_8)
		end

	process_block
		do
			a := h1
			b := h2
			c := h3
			d := h4

			a := rotate_left_32 (a + f (b, c, d) + schedule [0] + 0xd76aa478, 7) + b
			d := rotate_left_32 (d + f (a, b, c) + schedule [1] + 0xe8c7b756, 12) + a
			c := rotate_left_32 (c + f (d, a, b) + schedule [2] + 0x242070db, 17) + d
	        b := rotate_left_32 (b + f (c, d, a) + schedule [3] + 0xc1bdceee, 22) + c
	        a := rotate_left_32 (a + f (b, c, d) + schedule [4] + 0xf57c0faf, 7) + b
	        d := rotate_left_32 (d + f (a, b, c) + schedule [5] + 0x4787c62a, 12) + a
	        c := rotate_left_32 (c + f (d, a, b) + schedule [6] + 0xa8304613, 17) + d
	        b := rotate_left_32 (b + f (c, d, a) + schedule [7] + 0xfd469501, 22) + c
	        a := rotate_left_32 (a + f (b, c, d) + schedule [8] + 0x698098d8, 7) + b
	        d := rotate_left_32 (d + f (a, b, c) + schedule [9] + 0x8b44f7af, 12) + a
	        c := rotate_left_32 (c + f (d, a, b) + schedule [10] + 0xffff5bb1, 17) + d
	        b := rotate_left_32 (b + f (c, d, a) + schedule [11] + 0x895cd7be, 22) + c
	        a := rotate_left_32 (a + f (b, c, d) + schedule [12] + 0x6b901122, 7) + b
	        d := rotate_left_32 (d + f (a, b, c) + schedule [13] + 0xfd987193, 12) + a
	        c := rotate_left_32 (c + f (d, a, b) + schedule [14] + 0xa679438e, 17) + d
	        b := rotate_left_32 (b + f (c, d, a) + schedule [15] + 0x49b40821, 22) + c

	        a := rotate_left_32 (a + g (b, c, d) + schedule [1] + 0xf61e2562, 5) + b
	        d := rotate_left_32 (d + g (a, b, c) + schedule [6] + 0xc040b340, 9) + a
	        c := rotate_left_32 (c + g (d, a, b) + schedule [11] + 0x265e5a51, 14) + d
	        b := rotate_left_32 (b + g (c, d, a) + schedule [0] + 0xe9b6c7aa, 20) + c
	        a := rotate_left_32 (a + g (b, c, d) + schedule [5] + 0xd62f105d, 5) + b
	        d := rotate_left_32 (d + g (a, b, c) + schedule [10] + 0x02441453, 9) + a
	        c := rotate_left_32 (c + g (d, a, b) + schedule [15] + 0xd8a1e681, 14) + d
	        b := rotate_left_32 (b + g (c, d, a) + schedule [4] + 0xe7d3fbc8, 20) + c
	        a := rotate_left_32 (a + g (b, c, d) + schedule [9] + 0x21e1cde6, 5) + b
	        d := rotate_left_32 (d + g (a, b, c) + schedule [14] + 0xc33707d6, 9) + a
	        c := rotate_left_32 (c + g (d, a, b) + schedule [3] + 0xf4d50d87, 14) + d
	        b := rotate_left_32 (b + g (c, d, a) + schedule [8] + 0x455a14ed, 20) + c
	        a := rotate_left_32 (a + g (b, c, d) + schedule [13] + 0xa9e3e905, 5) + b
	        d := rotate_left_32 (d + g (a, b, c) + schedule [2] + 0xfcefa3f8, 9) + a
	        c := rotate_left_32 (c + g (d, a, b) + schedule [7] + 0x676f02d9, 14) + d
	        b := rotate_left_32 (b + g (c, d, a) + schedule [12] + 0x8d2a4c8a, 20) + c

	        a := rotate_left_32 (a + h (b, c, d) + schedule [5] + 0xfffa3942, 4) + b
	        d := rotate_left_32 (d + h (a, b, c) + schedule [8] + 0x8771f681, 11) + a
	        c := rotate_left_32 (c + h (d, a, b) + schedule [11] + 0x6d9d6122, 16) + d
	        b := rotate_left_32 (b + h (c, d, a) + schedule [14] + 0xfde5380c, 23) + c
	        a := rotate_left_32 (a + h (b, c, d) + schedule [1] + 0xa4beea44, 4) + b
	        d := rotate_left_32 (d + h (a, b, c) + schedule [4] + 0x4bdecfa9, 11) + a
	        c := rotate_left_32 (c + h (d, a, b) + schedule [7] + 0xf6bb4b60, 16) + d
	        b := rotate_left_32 (b + h (c, d, a) + schedule [10] + 0xbebfbc70, 23) + c
	        a := rotate_left_32 (a + h (b, c, d) + schedule [13] + 0x289b7ec6, 4) + b
	        d := rotate_left_32 (d + h (a, b, c) + schedule [0] + 0xeaa127fa, 11) + a
	        c := rotate_left_32 (c + h (d, a, b) + schedule [3] + 0xd4ef3085, 16) + d
	        b := rotate_left_32 (b + h (c, d, a) + schedule [6] + 0x04881d05, 23) + c
	        a := rotate_left_32 (a + h (b, c, d) + schedule [9] + 0xd9d4d039, 4) + b
	        d := rotate_left_32 (d + h (a, b, c) + schedule [12] + 0xe6db99e5, 11) + a
	        c := rotate_left_32 (c + h (d, a, b) + schedule [15] + 0x1fa27cf8, 16) + d
	        b := rotate_left_32 (b + h (c, d, a) + schedule [2] + 0xc4ac5665, 23) + c

	        a := rotate_left_32 (a + k (b, c, d) + schedule [0] + 0xf4292244, 6) + b
	        d := rotate_left_32 (d + k (a, b, c) + schedule [7] + 0x432aff97, 10) + a
	        c := rotate_left_32 (c + k (d, a, b) + schedule [14] + 0xab9423a7, 15) + d
	        b := rotate_left_32 (b + k (c, d, a) + schedule [5] + 0xfc93a039, 21) + c
	        a := rotate_left_32 (a + k (b, c, d) + schedule [12] + 0x655b59c3, 6) + b
	        d := rotate_left_32 (d + k (a, b, c) + schedule [3] + 0x8f0ccc92, 10) + a
	        c := rotate_left_32 (c + k (d, a, b) + schedule [10] + 0xffeff47d, 15) + d
	        b := rotate_left_32 (b + k (c, d, a) + schedule [1] + 0x85845dd1, 21) + c
	        a := rotate_left_32 (a + k (b, c, d) + schedule [8] + 0x6fa87e4f, 6) + b
	        d := rotate_left_32 (d + k (a, b, c) + schedule [15] + 0xfe2ce6e0, 10) + a
	        c := rotate_left_32 (c + k (d, a, b) + schedule [6] + 0xa3014314, 15) + d
	        b := rotate_left_32 (b + k (c, d, a) + schedule [13] + 0x4e0811a1, 21) + c
	        a := rotate_left_32 (a + k (b, c, d) + schedule [4] + 0xf7537e82, 6) + b
	        d := rotate_left_32 (d + k (a, b, c) + schedule [11] + 0xbd3af235, 10) + a
	        c := rotate_left_32 (c + k (d, a, b) + schedule [2] + 0x2ad7d2bb, 15) + d
	        b := rotate_left_32 (b + k (c, d, a) + schedule [9] + 0xeb86d391, 21) + c

	        h1 := h1 + a
	        h2 := h2 + b
	        h3 := h3 + c
	        h4 := h4 + d
		end

	a: NATURAL_32
	b: NATURAL_32
	c: NATURAL_32
	d: NATURAL_32

feature -- {DEBUG_OUTPUT}
	debug_output: STRING
		do
			Result := current_out
		end

feature {MD5}
	h1: NATURAL_32
	h2: NATURAL_32
	h3: NATURAL_32
	h4: NATURAL_32
end
