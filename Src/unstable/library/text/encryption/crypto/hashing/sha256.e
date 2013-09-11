note
	description: "[
					SHA256 encryption

					Usage:
						1. Call one or more update* to input source to encode.
						2. Call *digest* to get the computed result.

						Note that calls of *digest* does not reset previous result.
						To start new computation, `reset' must be called.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	SHA256

inherit
	MESSAGE_DIGEST
		redefine
			process_length
		end

	HELPER

create
	make

feature -- Creation

	make
			-- Initialize
		do
				-- SHA256 require expanding from 16 32bit to 64 32bit.
			create schedule.make_filled (0, 64)
			create buffer.make_filled (0, block_size)
			reset
		end

feature -- Access

	digest: SPECIAL [NATURAL_8]
			-- <Precursor>
		local
			l_buffer_offset: like buffer_offset
			l_byte_count: like byte_count
			l_h1, l_h2, l_h3, l_h4, l_h5, l_h6, l_h7, l_h8: NATURAL_32
		do
				-- Save state
			l_buffer_offset := buffer_offset
			l_byte_count := byte_count
			l_h1 := h1
			l_h2 := h2
			l_h3 := h3
			l_h4 := h4
			l_h5 := h5
			l_h6 := h6
			l_h7 := h7
			l_h8 := h8

			finish
			create Result.make_filled (0, digest_count)
			from_natural_32_be (h1, Result, 0)
			from_natural_32_be (h2, Result, 4)
			from_natural_32_be (h3, Result, 8)
			from_natural_32_be (h4, Result, 12)
			from_natural_32_be (h5, Result, 16)
			from_natural_32_be (h6, Result, 20)
			from_natural_32_be (h7, Result, 24)
			from_natural_32_be (h8, Result, 28)

				-- Restore state, so that further `update_*' can be called.
			buffer_offset := l_buffer_offset
			byte_count := l_byte_count
			h1 := l_h1
			h2 := l_h2
			h3 := l_h3
			h4 := l_h4
			h5 := l_h5
			h6 := l_h6
			h7 := l_h7
			h8 := l_h8
		end

	digest_count: INTEGER = 32
			-- <Precursor>

	block_size: INTEGER = 64
			-- <Precursor>

feature -- Element Change

	reset
			-- Reset computation.
		do
			byte_count := 0
			buffer_offset := 0
			h1 := 0x6a09e667
			h2 := 0xbb67ae85
			h3 := 0x3c6ef372
			h4 := 0xa54ff53a
			h5 := 0x510e527f
			h6 := 0x9b05688c
			h7 := 0x1f83d9ab
			h8 := 0x5be0cd19
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
			buffer_offset_set: buffer_offset = (old buffer_offset + 1) \\ (block_size)
		end
		
feature {NONE} -- Implementation

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
				l_schedule [j] := as_natural_32_be (l_buffer, i)
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

feature {NONE}

	process_block
			-- Process current block in buffer.
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
			schedule_buffer
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
			-- Expand bloks from 16 32bits to 64 32bits.
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

	process_length (length: NATURAL_64)
			-- Update length into the buffer.
		do
			update_from_byte ((length |>> 56).to_natural_8)
			update_from_byte ((length |>> 48).to_natural_8)
			update_from_byte ((length |>> 40).to_natural_8)
			update_from_byte ((length |>> 32).to_natural_8)
			update_from_byte ((length |>> 24).to_natural_8)
			update_from_byte ((length |>> 16).to_natural_8)
			update_from_byte ((length |>> 8).to_natural_8)
			update_from_byte ((length).to_natural_8)
		end

feature {NONE} -- Access

	h1: NATURAL_32
	h2: NATURAL_32
	h3: NATURAL_32
	h4: NATURAL_32
	h5: NATURAL_32
	h6: NATURAL_32
	h7: NATURAL_32
	h8: NATURAL_32

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
