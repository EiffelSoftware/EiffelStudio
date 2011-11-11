note
	description: "An arbitrary precision integer"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "'For your own good' is a persuasive argument that will eventually make a man agree to his own destruction. -  Janet Frame, Faces In The Water, 1982"

class
	INTEGER_X

inherit
	READABLE_INTEGER_X
		export
			{ANY}
				abs,
				plus,
				minus,
				product,
				quotient,
				opposite,
				bit_complement,
				bit_and,
				bit_or,
				bit_xor,
				bit_not,
				bit_xor_left_shift,
				bit_shift_right,
				bit_shift_left,
				set_bit,
				powm,
				inverse,
				modulo,
				gcd,
				invert_gf
		end

create
	default_create,
	make_from_integer,
	make_from_integer_64,
	make_from_integer_32,
	make_from_integer_16,
	make_from_integer_8,
	make_from_natural,
	make_from_natural_64,
	make_from_natural_32,
	make_from_natural_16,
	make_from_natural_8,
	make_from_string,
	make_from_hex_string,
	make_from_string_base,
	make_random,
	make_from_bytes,
	make_random_prime,
	make_random_max,
	make_limbs,
	make_bits,
	make_set

convert
	to_integer_64: {INTEGER_64},
	to_integer_32: {INTEGER_32},
	to_integer_16: {INTEGER_16},
	to_integer_8: {INTEGER_8},
	to_natural_64: {NATURAL_64},
	to_natural_32: {NATURAL_32},
	to_natural_16: {NATURAL_16},
	to_natural_8: {NATURAL_8},
	make_from_integer_64 ({INTEGER_64}),
	make_from_integer_32 ({INTEGER_32}),
	make_from_integer_16 ({INTEGER_16}),
	make_from_integer_8 ({INTEGER_8}),
	make_from_natural_64 ({NATURAL_64}),
	make_from_natural_32 ({NATURAL_32}),
	make_from_natural_16 ({NATURAL_16}),
	make_from_natural_8 ({NATURAL_8}),
	make_set ({READABLE_INTEGER_X})

feature -- Constants
	one: like Current
		do
			create Result.make_from_integer (1)
		end

	zero: like Current
		do
			create Result
		end
end
