note
	description: "Objects that ..."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Liberty is not a means to a political end. It is itself the highest political end. - Lord Acton"

deferred class
	EC_FIELD_ELEMENT

inherit
	ANY
		redefine
			is_equal,
			copy
		end
	DEBUG_OUTPUT
		undefine
			is_equal,
			copy
		end
	EC_CONSTANTS
		undefine
			is_equal,
			copy
		end

feature

	x: INTEGER_X

	copy (other: like Current)
		do
			x.copy (other.x)
		end

	encoded_field_size (curve: EC_CURVE): INTEGER_32
			-- Return the size of this ecfieldelement in bytes when encoded according to x9.62
			-- This was added as a deviation from the lcrypto origional and seems to be cleaner
			-- Replacement for class X9IntegerConverter
		deferred
		end

	plus (other: like Current; curve: EC_CURVE)
		deferred
		end

	plus_value (other: like Current; curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.plus (other, curve)
		end

	minus (other: like Current; curve: EC_CURVE)
		deferred
		end

	minus_value (other: like Current; curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.minus (other, curve)
		end

	product (other: like Current; curve: EC_CURVE)
		deferred
		end

	product_value (other: like Current; curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.product (other, curve)
		end

	quotient (other: like Current; curve: EC_CURVE)
		deferred
		end

	quotient_value (other: like Current; curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.quotient (other, curve)
		end

	opposite (curve: EC_CURVE)
		deferred
		end

	opposite_value (curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.opposite (curve)
		end

	square (curve: EC_CURVE)
		deferred
		end

	square_value (curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.square (curve)
		end

	inverse (curve: EC_CURVE)
		deferred
		end

	inverse_value (curve: EC_CURVE): like Current
		do
			Result := deep_twin
			Result.inverse (curve)
		end

	sqrt (curve: EC_CURVE): like Current
			-- Return a new ECFIELDELEMENT that is sqrt(current)
		deferred
		end

	is_equal (other: like Current): BOOLEAN
		do
			Result := x ~ other.x
		ensure then
			Result = (x ~ other.x)
		end

feature {DEBUG_OUTPUT} -- {DEBUG_OUTPUT}
	debug_output: STRING
		do
			result := x.out_hex
		end

invariant
	negative: not x.is_negative
end
