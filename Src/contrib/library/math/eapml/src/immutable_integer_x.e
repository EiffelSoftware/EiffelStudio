note
	description: "An INTEGER_X whos value cannot change"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Freedom is the emancipation from the arbitrary rule of other men. -  Mortimer Adler (1902-2001)"

class
	IMMUTABLE_INTEGER_X

inherit
	READABLE_INTEGER_X

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

feature
	one: like Current
		do
			create Result.make_from_integer (1)
		end

	zero: like Current
		do
			create Result
		end
end
