note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "There's never been a good government. - Emma Goldman"

class
	SHA1

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
			{SHA1}
				schedule,
				buffer,
				byte_count,
				schedule_offset,
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

feature -- Creation
	make
		do
			create schedule.make_filled (0, 80)
			create buffer.make_filled (0, 4)
			buffer_offset := 0
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
			schedule_offset := other.schedule_offset
		ensure
			Current ~ other
		end

feature -- Implementing DIGEST
	reset
		do
			byte_count := 0
			buffer_offset := 0
			h1 := 0x67452301
			h2 := 0xefcdab89
			h3 := 0x98badcfe
			h4 := 0x10325476
			h5 := 0xc3d2e1f0
			schedule_offset := 0
		ensure
			byte_count = 0
			buffer_offset = 0
			schedule_offset = 0
			h1 = 0x67452301
			h2 = 0xefcdab89
			h3 = 0x98badcfe
			h4 = 0x10325476
			h5 = 0xc3d2e1f0
		end

	do_final (output: SPECIAL [NATURAL_8] offset: INTEGER)
		require
			valid_start: output.valid_index (offset)
			valid_end: output.valid_index (offset + 19)
		do
			finish

			unpack_word (h1, output, offset)
			unpack_word (h2, output, offset + 4)
			unpack_word (h3, output, offset + 8)
			unpack_word (h4, output, offset + 12)
			unpack_word (h5, output, offset + 16)

			reset
		end

	current_final (output: SPECIAL [NATURAL_8] offset: INTEGER_32)
		require
			valid_start: output.valid_index (offset)
			valid_end: output.valid_index (offset + 19)
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
			create output.make_filled (0, 20)
			current_final (output, 0)
			from
				index := 0
			until
				index = 20
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
			schedule_offset = other.schedule_offset and
			byte_count = other.byte_count and
			buffer_offset = other.buffer_offset
		end

feature {NONE}
	unpack_word (word: NATURAL_32 output: SPECIAL [NATURAL_8] offset: INTEGER)
		require
			valid_start: output.valid_index (offset)
			valid_end: output.valid_index (offset + 3)
		do
			output [offset] := (word |>> 24).to_natural_8
			output [offset + 1] := (word |>> 16).to_natural_8
			output [offset + 2] := (word |>> 8).to_natural_8
			output [offset + 3] := word.to_natural_8
		end

	A: NATURAL_32
	B: NATURAL_32
	C: NATURAL_32
	D: NATURAL_32
	E: NATURAL_32

	process_block
		do
			expand_word_block
			A := H1
			B := H2
			C := H3
			D := H4
			E := H5
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

feature {SHA1}
	H1: NATURAL_32
	H2: NATURAL_32
	H3: NATURAL_32
	H4: NATURAL_32
	H5: NATURAL_32

feature {NONE}
	k1: NATURAL_32 = 0x5a827999
	k2: NATURAL_32 = 0x6ed9eba1
	k3: NATURAL_32 = 0x8f1bbcdc
	k4: NATURAL_32 = 0xca62c1d6

feature {DEBUG_OUTPUT} -- {DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := current_out
		end

invariant
	schedule_lower:schedule.lower = 0
	schedule_upper:schedule.upper = 79
end
