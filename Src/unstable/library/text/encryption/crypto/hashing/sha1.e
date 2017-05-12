note
	description: "[
					SHA1 encryption

					Usage:
						1. Call one or more update* to input source to encode.
						2. Call *digest* to get the computed result.

						Note that calls of *digest* does not reset previous result.
						To start new computation, `reset' must be called.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	SHA1

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
				-- SHA1 require expanding from 16 32bit to 80 32bit.
			create schedule.make_filled (0, 80)
			create buffer.make_filled (0, block_size)
			reset
		end

feature -- Access

	digest: SPECIAL [NATURAL_8]
			-- <Precursor>
		local
			l_buffer_offset: like buffer_offset
			l_byte_count: like byte_count
			l_h1, l_h2, l_h3, l_h4, l_h5: NATURAL_32
		do
				-- Save state
			l_buffer_offset := buffer_offset
			l_byte_count := byte_count
			l_h1 := h1
			l_h2 := h2
			l_h3 := h3
			l_h4 := h4
			l_h5 := h5

			finish
			create Result.make_filled (0, digest_count)
			from_natural_32_be (h1, Result, 0)
			from_natural_32_be (h2, Result, 4)
			from_natural_32_be (h3, Result, 8)
			from_natural_32_be (h4, Result, 12)
			from_natural_32_be (h5, Result, 16)

				-- Restore state, so that further `update_*' can be called.
			buffer_offset := l_buffer_offset
			byte_count := l_byte_count
			h1 := l_h1
			h2 := l_h2
			h3 := l_h3
			h4 := l_h4
			h5 := l_h5
		end

	digest_count: INTEGER = 20
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
			a := 0
			b := 0
			c := 0
			d := 0
			e := 0

			h1 := 0x67452301
			h2 := 0xefcdab89
			h3 := 0x98badcfe
			h4 := 0x10325476
			h5 := 0xc3d2e1f0
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

	A: NATURAL_32
	B: NATURAL_32
	C: NATURAL_32
	D: NATURAL_32
	E: NATURAL_32

	process_block
		do
			schedule_buffer
			expand_word_block
			A := h1
			B := h2
			C := h3
			D := h4
			E := h5
			do_round_1
			do_round_2
			do_round_3
			do_round_4
			h1 := h1 + a
			h2 := h2 + b
			h3 := h3 + c
			h4 := h4 + d
			h5 := h5 + e
		end

	do_round_4
		local
			j: INTEGER
			idx: INTEGER
		do
			idx := 60
			from
				j := 0
			until
				j = 4
			loop
				e := e + rotate_left_32 (a, 5) + parity (b, c, d) + schedule [idx] + k4
				idx := idx + 1
				b := rotate_left_32 (b, 30)
				d := d + rotate_left_32 (e, 5) + parity (a, b, c) + schedule [idx] + k4
				idx := idx + 1
				a := rotate_left_32 (a, 30)
				c := c + rotate_left_32 (d, 5) + parity (e, a, b) + schedule [idx] + k4
				idx := idx + 1
				e := rotate_left_32 (e, 30)
				b := b + rotate_left_32 (c, 5) + parity (d, e, a) + schedule [idx] + k4
				idx := idx + 1
				d := rotate_left_32 (d, 30)
				a := a + rotate_left_32 (b, 5) + parity (c, d, e) + schedule [idx] + k4
				idx := idx + 1
				c := rotate_left_32 (c, 30)
				j := j + 1
			end
		end

	do_round_3
		local
			j: INTEGER
			idx: INTEGER
		do
			idx := 40
			from
				j := 0
			until
				j = 4
			loop
				E := E + rotate_left_32 (a, 5) + maj (B, C, D) + schedule [idx] + k3
				idx := idx + 1
				B := rotate_left_32 (b, 30)
				D := d + rotate_left_32 (e, 5) + maj (a, b, c) + schedule [idx] + k3
				idx := idx + 1
				A := rotate_left_32 (a, 30)
				C := C + rotate_left_32 (d, 5) + maj (e, a, b) + schedule [idx] + k3
				idx := idx + 1
				e := rotate_left_32 (e, 30)
				b := b + rotate_left_32 (c, 5) + maj (d, e, a) + schedule [idx] + k3
				idx := idx + 1
				d := rotate_left_32 (d, 30)
				a := a + rotate_left_32 (b, 5) + maj (c, d, e) + schedule [idx] + k3
				idx := idx + 1
				c := rotate_left_32 (c, 30)
				j := j + 1
			end
		end

	do_round_2
		local
			j: INTEGER
			idx: INTEGER
		do
			idx := 20
			from
				j := 0
			until
				j = 4
			loop
				E := E + rotate_left_32 (a, 5) + parity(B, C, D) + schedule [idx] + k2
				idx := idx + 1
				B := rotate_left_32 (b, 30)
				D := d + rotate_left_32 (e, 5) + parity(a, b, c) + schedule [idx] + k2
				idx := idx + 1
				A := rotate_left_32 (a, 30)
				C := C + rotate_left_32 (d, 5) + parity(e, a, b) + schedule [idx] + k2
				idx := idx + 1
				e := rotate_left_32 (e, 30)
				b := b + rotate_left_32 (c, 5) + parity(d, e, a) + schedule [idx] + k2
				idx := idx + 1
				d := rotate_left_32 (d, 30)
				a := a + rotate_left_32 (b, 5) + parity(c, d, e) + schedule [idx] + k2
				idx := idx + 1
				c := rotate_left_32 (c, 30)
				j := j + 1
			end
		end

	do_round_1
		local
			j: INTEGER
			idx: INTEGER
		do
			idx := 0
			from
				j := 0
			until
				j = 4
			loop
				E := E + rotate_left_32 (a, 5) + ch (B, C, D) + schedule [idx] + k1
				idx := idx + 1
				B := rotate_left_32 (b, 30)
				D := d + rotate_left_32 (e, 5) + ch (a, b, c) + schedule [idx] + k1
				idx := idx + 1
				A := rotate_left_32 (a, 30)
				C := C + rotate_left_32 (d, 5) + ch (e, a, b) + schedule [idx] + k1
				idx := idx + 1
				e := rotate_left_32 (e, 30)
				b := b + rotate_left_32 (c, 5) + ch (d, e, a) + schedule [idx] + k1
				idx := idx + 1
				d := rotate_left_32 (d, 30)
				a := a + rotate_left_32 (b, 5) + ch (c, d, e) + schedule [idx] + k1
				idx := idx + 1
				c := rotate_left_32 (c, 30)
				j := j + 1
			end
		end

	expand_word_block
			-- Expand 16 word block in to 80 word block
		local
			i: INTEGER
			temp: NATURAL_32
		do
			from
				i := 16
			until
				i = 80
			loop
				temp := schedule [i - 3].bit_xor (schedule [i - 8]).bit_xor (schedule [i - 14]).bit_xor (schedule [i - 16])
				schedule [i] := rotate_left_32 (temp, 1)
				i := i + 1
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

	k1: NATURAL_32 = 0x5a827999
	k2: NATURAL_32 = 0x6ed9eba1
	k3: NATURAL_32 = 0x8f1bbcdc
	k4: NATURAL_32 = 0xca62c1d6

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
