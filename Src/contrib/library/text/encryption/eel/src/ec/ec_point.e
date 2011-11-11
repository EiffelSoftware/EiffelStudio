note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The government was set to protect man from criminals - and the Constitution was written to protect man from the government. - Ayn Rand"

deferred class
	EC_POINT

inherit
	ANY
		redefine
			is_equal
		end
	DEBUG_OUTPUT
		undefine
			is_equal
		end

feature
	x: EC_FIELD_ELEMENT
	y: EC_FIELD_ELEMENT
	infinity: BOOLEAN

	make_infinity
		deferred
		ensure
			infinity
		end

	set_infinity
		deferred
		ensure
			infinity
		end

	is_equal (other: like Current): BOOLEAN
			-- Is current point equal to other point
		do
			result := (infinity = other.infinity) and then (not infinity implies (x ~ other.x and y ~ other.y))
		end

	to_byte_array_compressed (curve: EC_CURVE): SPECIAL[NATURAL_8]
			-- Return the Uncompressed version of this point, regardless of the creation
		deferred
		end

	to_byte_array_uncompressed (curve: EC_CURVE): SPECIAL[NATURAL_8]
			-- Return the compressed version of this point
		deferred
		end

	plus (other: like Current curve: EC_CURVE)
		deferred
		end

	plus_value (other: like Current curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.plus (other, curve)
		ensure
			infinity implies Result ~ other
			other.infinity implies Result ~ Current
			(Current ~ other) implies (Result ~ twice_value (curve))
		end

	minus (other: like Current curve: EC_CURVE)
		deferred
		end

	minus_value (other: like Current curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.minus (other, curve)
		ensure
			infinity implies Result ~ other
			other.infinity implies Result ~ Current
		end

	twice (curve: EC_CURVE)
		deferred
		end

	twice_value (curve:EC_CURVE): like Current
		do
			Result := deep_twin
			Result.twice (curve)
		ensure
			twice_definition: Result ~ Current.plus_value (Current, curve)
		end

	product (other: INTEGER_X; curve: EC_CURVE)
		deferred
		end

	product_value (other: INTEGER_X; curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.product (other, curve)
		end

	opposite (curve: EC_CURVE)
		deferred
		end

	opposite_value (curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.opposite (curve)
		end

feature {DEBUG_OUTPUT} -- {DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := "0x" + x.debug_output + "%N0x" + y.debug_output
		end

invariant
	infinity_x: infinity implies x.x.is_zero
	infinity_y: infinity implies y.x.is_zero
end
