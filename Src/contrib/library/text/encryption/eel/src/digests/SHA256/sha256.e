note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Useless laws weaken the necessary laws. - Montesquieu"

class
	SHA256

inherit
	ANY
		redefine
			is_equal
		end
	DEBUG_OUTPUT
		undefine
			is_equal
		end
	SHA_FUNCTIONS
		rename
			byte_sink as update
		export
			{SHA256}
				schedule,
				buffer,
				schedule_offset,
				byte_count,
				buffer_offset
		undefine
			is_equal
		end
	ROTATE_FACILITIES
		undefine
			is_equal
		end

create
	make,
	make_copy

feature
	make
		do
			create schedule.make_filled (0, 64)
			create buffer.make_filled (0, 4)
			reset
		end

	make_copy (other: like Current)
		do
			make
			schedule.copy_data (other.schedule, other.schedule.lower, schedule.lower, schedule.count)
			buffer.copy_data (other.buffer, other.buffer.lower, buffer.lower, buffer.count)
			byte_count := other.byte_count
			buffer_offset := other.buffer_offset
			h1 := other.h1
			h2 := other.h2
			h3 := other.h3
			h4 := other.h4
			h5 := other.h5
			h6 := other.h6
			h7 := other.h7
			h8 := other.h8
			schedule_offset := other.schedule_offset
		ensure
			Current ~ other
		end

feature
	do_final (output: SPECIAL[NATURAL_8] out_off: INTEGER)
		require
			valid_offset: out_off >= 0
			out_big_enough: out.count - out_off >= 32
		do
			finish
			from_natural_32_be (h1, output, out_off)
			from_natural_32_be (h2, output, out_off + 4)
			from_natural_32_be (h3, output, out_off + 8)
			from_natural_32_be (h4, output, out_off + 12)
			from_natural_32_be (h5, output, out_off + 16)
			from_natural_32_be (h6, output, out_off + 20)
			from_natural_32_be (h7, output, out_off + 24)
			from_natural_32_be (h8, output, out_off + 28)
			reset
		end

	reset
		do
			buffer_offset := 0
			h1 := 0x6a09e667
			h2 := 0xbb67ae85
			h3 := 0x3c6ef372
			h4 := 0xa54ff53a
			h5 := 0x510e527f
			h6 := 0x9b05688c
			h7 := 0x1f83d9ab
			h8 := 0x5be0cd19
			schedule_offset := 0
			schedule.fill_with ({NATURAL_32} 0, 0, schedule.upper)
		ensure
			buffer_reset: buffer_offset = 0
			schedule_reset: schedule_offset = 0
		end

	current_final (output: SPECIAL [NATURAL_8] offset: INTEGER_32)
		require
			valid_start: output.valid_index (offset)
			valid_end: output.valid_index (offset + 31)
		local
			current_copy: like Current
		do
			current_copy := Current.deep_twin
			current_copy.do_final (output, offset)
		end

	current_out: STRING
		local
			output: SPECIAL [NATURAL_8]
			index: INTEGER_32
		do
			Result := "0x"
			create output.make_filled (0, 32)
			current_final (output, 0)
			from
				index := 0
			until
				index = 32
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
			h5 = other.h5 and
			h6 = other.h6 and
			h7 = other.h7 and
			h8 = other.h8 and
			schedule_offset = other.schedule_offset and
			byte_count = other.byte_count and
			buffer_offset = other.buffer_offset
		end

feature{NONE}
	process_block
		local
			a: NATURAL_32
			b: NATURAL_32
			c: NATURAL_32
			d: NATURAL_32
			e: NATURAL_32
			f: NATURAL_32
			g: NATURAL_32
			h: NATURAL_32
			t: INTEGER
			i: INTEGER
		do
			expand_blocks
			a := h1
			b := h2
			c := h3
			d := h4
			e := h5
			f := h6
			g := h7
			h := h8
			t := 0
			from
				i := 0
			until
				i = 8
			loop
				h := h + sigma1 (e) + ch (e, f, g) + k [t] + schedule [t]
				t := t + 1
				d := d + h
				h := h + sigma0 (a) + maj (a, b, c)

				g := g + sigma1 (d) + ch (d, e, f) + k [t] + schedule [t]
				t := t + 1
				c := c + g
				g := g + sigma0 (h) + maj (h, a, b)

				f := f + sigma1 (c) + ch (c, d, e) + k [t] + schedule [t]
				t := t + 1
				b := b + f
				f := f + sigma0 (g) + maj (g, h, a)

				e := e + sigma1 (b) + ch (b, c, d) + k [t] + schedule [t]
				t := t + 1
				a := a + e
				e := e + sigma0 (f) + maj (f, g, h)

				d := d + sigma1 (a) + ch (a, b, c) + k [t] + schedule [t]
				t := t + 1
				h := h + d
				d := d + sigma0 (e) + maj (e, f, g)

				c := c + sigma1 (h) + ch (h, a, b) + k [t] + schedule [t]
				t := t + 1
				g := g + c
				c := c + sigma0 (d) + maj (d, e, f)

				b := b + sigma1 (g) + ch (g, h, a) + k [t] + schedule [t]
				t := t + 1
				f := f + b
				b := b + sigma0 (c) + maj (c, d, e)

				a := a + sigma1 (f) + ch (f, g, h) + k [t] + schedule [t]
				t := t + 1
				e := e + a
				a := a + sigma0 (b) + maj (b, c, d)

				i := i + 1
			end

			h1 := h1 + a
			h2 := h2 + b
			h3 := h3 + c
			h4 := h4 + d
			h5 := h5 + e
			h6 := h6 + f
			h7 := h7 + g
			h8 := h8 + h
		end

	sigma0 (x1: NATURAL_32): NATURAL_32
		do
			result := rotate_right_32 (x1, 2)
			result := result.bit_xor (rotate_right_32 (x1, 13))
			result := result.bit_xor (rotate_right_32 (x1, 22))
		end

	sigma1 (x1: NATURAL_32): NATURAL_32
		do
			result := rotate_right_32 (x1, 6)
			result := result.bit_xor (rotate_right_32 (x1, 11))
			result := result.bit_xor (rotate_right_32 (x1, 25))
		end

	lsigma0(x1: NATURAL_32): NATURAL_32
		do
			result := (rotate_right_32 (x1, 7)).bit_xor (rotate_right_32 (x1, 18)).bit_xor (x1 |>> 3)
		end

	lsigma1(x1: NATURAL_32): NATURAL_32
		do
			result := (rotate_right_32 (x1, 17)).bit_xor (rotate_right_32 (x1, 19)).bit_xor (x1 |>> 10)
		end

	expand_blocks
		local
			t: INTEGER
		do
			from
				t := 16
			until
				t = 64
			loop
				schedule[t] := lsigma1 (schedule [t - 2]) + schedule [t - 7] + lsigma0 (schedule [t - 15]) + schedule [t - 16]
				t := t + 1
			end
		end

	k: SPECIAL[NATURAL_32]
		once
			create result.make_filled (0, 64)
			result[0] := 0x428a2f98
			result[1] := 0x71374491
			result[2] := 0xb5c0fbcf
			result[3] := 0xe9b5dba5
			result[4] := 0x3956c25b
			result[5] := 0x59f111f1
			result[6] := 0x923f82a4
			result[7] := 0xab1c5ed5
			result[8] := 0xd807aa98
			result[9] := 0x12835b01
			result[10] := 0x243185be
			result[11] := 0x550c7dc3
			result[12] := 0x72be5d74
			result[13] := 0x80deb1fe
			result[14] := 0x9bdc06a7
			result[15] := 0xc19bf174
			result[16] := 0xe49b69c1
			result[17] := 0xefbe4786
			result[18] := 0x0fc19dc6
			result[19] := 0x240ca1cc
			result[20] := 0x2de92c6f
			result[21] := 0x4a7484aa
			result[22] := 0x5cb0a9dc
			result[23] := 0x76f988da
			result[24] := 0x983e5152
			result[25] := 0xa831c66d
			result[26] := 0xb00327c8
			result[27] := 0xbf597fc7
			result[28] := 0xc6e00bf3
			result[29] := 0xd5a79147
			result[30] := 0x06ca6351
			result[31] := 0x14292967
			result[32] := 0x27b70a85
			result[33] := 0x2e1b2138
			result[34] := 0x4d2c6dfc
			result[35] := 0x53380d13
			result[36] := 0x650a7354
			result[37] := 0x766a0abb
			result[38] := 0x81c2c92e
			result[39] := 0x92722c85
			result[40] := 0xa2bfe8a1
			result[41] := 0xa81a664b
			result[42] := 0xc24b8b70
			result[43] := 0xc76c51a3
			result[44] := 0xd192e819
			result[45] := 0xd6990624
			result[46] := 0xf40e3585
			result[47] := 0x106aa070
			result[48] := 0x19a4c116
			result[49] := 0x1e376c08
			result[50] := 0x2748774c
			result[51] := 0x34b0bcb5
			result[52] := 0x391c0cb3
			result[53] := 0x4ed8aa4a
			result[54] := 0x5b9cca4f
			result[55] := 0x682e6ff3
			result[56] := 0x748f82ee
			result[57] := 0x78a5636f
			result[58] := 0x84c87814
			result[59] := 0x8cc70208
			result[60] := 0x90befffa
			result[61] := 0xa4506ceb
			result[62] := 0xbef9a3f7
			result[63] := 0xc67178f2
		end

feature {SHA256}
	h1: NATURAL_32
	h2: NATURAL_32
	h3: NATURAL_32
	h4: NATURAL_32
	h5: NATURAL_32
	h6: NATURAL_32
	h7: NATURAL_32
	h8: NATURAL_32

feature {NONE} -- {DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := current_out
		end

invariant
	buffer_size: buffer.count = 4
	valid_buffer_offset: buffer.valid_index (buffer_offset)
	schedule_size: schedule.count = 64
	valid_schedule_offset: schedule.valid_index (schedule_offset)
end
