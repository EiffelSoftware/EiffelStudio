note
	description:
		"Access to decimal math constants and shared context"

class DCM_MA_DECIMAL_CONSTANTS

inherit

	DCM_MA_SHARED_DECIMAL_CONTEXT

feature -- Access

	zero: DECIMAL
			-- Neutral element for "+" and "-".
		once
			create Result.make (1)
			Result := Result.zero
		ensure
			zero_not_void: Result /= Void
		end

	negative_zero: DECIMAL
			-- Negative zero.
		once
			Result := zero.negative_zero
		ensure
			negative_zero_not_void: Result /= Void
		end

	one: DECIMAL
			-- Neutral element for "*" and "/".
		once
			Result := zero.one
		ensure
			one_not_void: Result /= Void
		end

	minus_one: DECIMAL
			-- Minus one.
		once
			Result := zero.minus_one
		ensure
			minus_not_void: Result /= Void
		end

	infinity: DECIMAL
			-- Infinity.
		once
			Result := zero.infinity
		ensure
			infinity_not_void: Result /= Void
		end

	negative_infinity: DECIMAL
			-- Negative infinity.
		once
			Result := zero.negative_infinity
		ensure
			negative_infinity_not_void: Result /= Void
		end

	not_a_number: DECIMAL
			-- Not a Number.
		once
			Result := zero.nan
		ensure
			not_a_number: Result /= Void
		end

	signaling_not_a_number: DECIMAL
			-- Signaling Not a Number.
		once
			Result := zero.snan
		ensure
			signaling_not_a_number: Result /= Void
		end

	minimum_integer: DECIMAL
			-- Minimum value convertible to integer.
		once
			create Result.make_from_string_ctx ({INTEGER}.min_value.out, create {DCM_MA_DECIMAL_CONTEXT}.make_double_extended)
		ensure
			minimum_integer_not_void: Result /= Void
		end

	maximum_integer: DECIMAL
			-- Maximum value convertible to integer.
		once
			create Result.make_from_string_ctx ({INTEGER}.max_value.out, create {DCM_MA_DECIMAL_CONTEXT}.make_double_extended)
		ensure
			maximum_integer_not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 2004, Paul G. Crismer and others."
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	copyright: "Copyright (c) 2017 Eiffel Software."
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"
	details: "[
			Originally developed by Paul G. Crismer as part of Gobo. 
			Revised by Jocelyn Fiat for void safety.
			Revised by Alexander Kogtenkov.
		]"

end
