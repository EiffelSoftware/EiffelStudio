note
	description: "[
					SHA256 encryption

					Usage:
						1. Call one or more update* to input source to encode.
						2. Call *digest* to get the computed Result.

						Note that calls of *digest* does not reset previous Result.
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
			buffer.replace_all (0)
			schedule.replace_all (0)
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
			buffer_offset_set: buffer_offset = (old buffer_offset + 1) \\ block_size
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
			Result := rotate_right_32 (x1, 2)
			Result := Result.bit_xor (rotate_right_32 (x1, 13))
			Result := Result.bit_xor (rotate_right_32 (x1, 22))
		end

	sigma1 (x1: NATURAL_32): NATURAL_32
		do
			Result := rotate_right_32 (x1, 6)
			Result := Result.bit_xor (rotate_right_32 (x1, 11))
			Result := Result.bit_xor (rotate_right_32 (x1, 25))
		end

	lsigma0(x1: NATURAL_32): NATURAL_32
		do
			Result := (rotate_right_32 (x1, 7)).bit_xor (rotate_right_32 (x1, 18)).bit_xor (x1 |>> 3)
		end

	lsigma1(x1: NATURAL_32): NATURAL_32
		do
			Result := (rotate_right_32 (x1, 17)).bit_xor (rotate_right_32 (x1, 19)).bit_xor (x1 |>> 10)
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
			create Result.make_filled (0, 64)
			Result [0] := 0x428a2f98
			Result [1] := 0x71374491
			Result [2] := 0xb5c0fbcf
			Result [3] := 0xe9b5dba5
			Result [4] := 0x3956c25b
			Result [5] := 0x59f111f1
			Result [6] := 0x923f82a4
			Result [7] := 0xab1c5ed5
			Result [8] := 0xd807aa98
			Result [9] := 0x12835b01
			Result [10] := 0x243185be
			Result [11] := 0x550c7dc3
			Result [12] := 0x72be5d74
			Result [13] := 0x80deb1fe
			Result [14] := 0x9bdc06a7
			Result [15] := 0xc19bf174
			Result [16] := 0xe49b69c1
			Result [17] := 0xefbe4786
			Result [18] := 0x0fc19dc6
			Result [19] := 0x240ca1cc
			Result [20] := 0x2de92c6f
			Result [21] := 0x4a7484aa
			Result [22] := 0x5cb0a9dc
			Result [23] := 0x76f988da
			Result [24] := 0x983e5152
			Result [25] := 0xa831c66d
			Result [26] := 0xb00327c8
			Result [27] := 0xbf597fc7
			Result [28] := 0xc6e00bf3
			Result [29] := 0xd5a79147
			Result [30] := 0x06ca6351
			Result [31] := 0x14292967
			Result [32] := 0x27b70a85
			Result [33] := 0x2e1b2138
			Result [34] := 0x4d2c6dfc
			Result [35] := 0x53380d13
			Result [36] := 0x650a7354
			Result [37] := 0x766a0abb
			Result [38] := 0x81c2c92e
			Result [39] := 0x92722c85
			Result [40] := 0xa2bfe8a1
			Result [41] := 0xa81a664b
			Result [42] := 0xc24b8b70
			Result [43] := 0xc76c51a3
			Result [44] := 0xd192e819
			Result [45] := 0xd6990624
			Result [46] := 0xf40e3585
			Result [47] := 0x106aa070
			Result [48] := 0x19a4c116
			Result [49] := 0x1e376c08
			Result [50] := 0x2748774c
			Result [51] := 0x34b0bcb5
			Result [52] := 0x391c0cb3
			Result [53] := 0x4ed8aa4a
			Result [54] := 0x5b9cca4f
			Result [55] := 0x682e6ff3
			Result [56] := 0x748f82ee
			Result [57] := 0x78a5636f
			Result [58] := 0x84c87814
			Result [59] := 0x8cc70208
			Result [60] := 0x90befffa
			Result [61] := 0xa4506ceb
			Result [62] := 0xbef9a3f7
			Result [63] := 0xc67178f2
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
