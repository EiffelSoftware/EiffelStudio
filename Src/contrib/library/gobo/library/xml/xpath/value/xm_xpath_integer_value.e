note

	description:

		"XPath integer values"

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_INTEGER_VALUE

inherit

	XM_XPATH_NUMERIC_VALUE
		redefine
			three_way_comparison, hash_code, is_integer_value, as_integer_value
		end

	XM_XPATH_SHARED_DECIMAL_CONTEXTS
		export {NONE} all end

create

	make, make_from_integer, make_from_string


feature {NONE} -- Initialization

	make (a_value: MA_DECIMAL)
		do
			make_atomic_value
			create value.make_copy (a_value)
			value := value.rescale (0, shared_integer_context)
		end

	make_from_integer (a_value: INTEGER)
		do
			make_atomic_value
			create value.make_from_integer (a_value)
		ensure
			value_set: value.to_integer = a_value
		end

	make_from_string (a_value: STRING)
		require
			is_integer: STRING_.is_decimal (a_value)
		do
			make_atomic_value
			create value.make_from_string_ctx (a_value, shared_integer_context)
		end

feature -- Access

	value: MA_DECIMAL

	is_integer_value: BOOLEAN
			-- Is `Current' an integer value?
		do
			Result := True
		end

	as_integer_value: XM_XPATH_INTEGER_VALUE
			-- `Current' seen as an integer value
		do
			Result := Current
		end

	hash_code: INTEGER
			-- Hash code value
		do
			if is_double then
				Result := as_double.hash_code
			else
				Result := value.to_scientific_string.hash_code
			end
		end

	as_integer: INTEGER
			-- Value converted to an integer
		do
			Result := value.to_integer
		end

	as_double: DOUBLE
			-- Value converted to a double
		do
			Result := value.to_double
		end

	item_type: XM_XPATH_ITEM_TYPE
			-- Data type
		do
			Result := type_factory.integer_type
			if Result /= Void then
				-- Bug in SE 1.0 and 1.1: Make sure that
				-- that `Result' is not optimized away.
			end
		end

	string_value: STRING
			--Value of the item as a string
		do
			Result := value.to_scientific_string
		end

feature -- Comparison

	three_way_comparison (other: XM_XPATH_ATOMIC_VALUE; a_context: XM_XPATH_CONTEXT): INTEGER
			-- Compare `Current' to `other'
		local
			l_decimal: MA_DECIMAL
		do
			if other.is_machine_integer_value then
				create l_decimal.make_from_string (other.as_machine_integer_value.value.out)
				Result := value.compare (l_decimal, shared_integer_context).to_integer
			elseif other.is_integer_value then
				if value.is_equal (other.as_integer_value.value) then
					Result := 0
				elseif value > other.as_integer_value.value then
					Result := 1
				else
					Result := -1
				end
			else
				Result := Precursor (other, a_context)
			end
		end

feature -- Status report

	display (a_level: INTEGER)
			-- Diagnostic print of expression structure to `std.error'
		local
			a_string: STRING
		do
			a_string := STRING_.appended_string (indentation (a_level), "integer (")
			a_string := STRING_.appended_string (a_string, string_value)
			a_string := STRING_.appended_string (a_string, ")")
			std.error.put_string (a_string)
			std.error.put_new_line
		end

	is_convertible (a_required_type: XM_XPATH_ITEM_TYPE): BOOLEAN
			-- Is `Current' convertible to `a_required_type'?
		do
			if	a_required_type = any_item or
				a_required_type = type_factory.any_atomic_type or
				a_required_type = type_factory.boolean_type or
				a_required_type = type_factory.string_type or
				a_required_type = type_factory.untyped_atomic_type or
				a_required_type = type_factory.numeric_type or
				a_required_type = type_factory.integer_type or
				a_required_type = type_factory.decimal_type or
				a_required_type = type_factory.float_type or
				a_required_type = type_factory.double_type then
				Result := True
			else
				Result := False
			end
		end

	is_whole_number: BOOLEAN
			-- Is value integral?
		do
			Result := True
		end

	is_platform_integer: BOOLEAN
			-- Can value be represented by an `INTEGER'?
		do
			Result := value <= decimal.maximum_integer
				and then value >= decimal.minimum_integer
		end

	is_double: BOOLEAN
			-- Can value be converted to a `DOUBLE'?
		do
			Result := value.is_double
		end

	is_nan: BOOLEAN
			-- Is value Not-a-number?
		do
			Result := False
			check
				integer_cant_be_nan: not value.is_nan
			end
		end

	is_zero: BOOLEAN
			-- Is value zero?
		do
			Result := value.is_zero
		end

	is_negative: BOOLEAN
			-- Is value less than zero?
		do
			Result := value.is_negative
		end

	is_infinite: BOOLEAN
			-- Is value infinite?
		do
			Result := False
			check
				not_infinity: not value.is_infinity
				-- because xs:integer cannot become infinite
			end
		end


feature -- Conversion

	convert_to_type (a_required_type: XM_XPATH_ITEM_TYPE)
			-- Convert `Current' to `a_required_type'
		do
			if a_required_type = type_factory.boolean_type  then
				create {XM_XPATH_BOOLEAN_VALUE} converted_value.make (not value.is_zero)
			elseif a_required_type = type_factory.any_atomic_type  then
				converted_value := Current
			elseif a_required_type = any_item  then
				converted_value := Current
			elseif  a_required_type = type_factory.integer_type then
				converted_value := Current
			elseif  a_required_type = type_factory.numeric_type then
				converted_value := Current
			elseif  a_required_type = type_factory.double_type then
				create {XM_XPATH_DOUBLE_VALUE} converted_value.make (as_double)
			elseif  a_required_type = type_factory.float_type then
				create {XM_XPATH_FLOAT_VALUE} converted_value.make (as_double)
			elseif  a_required_type = type_factory.decimal_type then
				create {XM_XPATH_DECIMAL_VALUE} converted_value.make (value)
			elseif  a_required_type = type_factory.string_type then
				create {XM_XPATH_STRING_VALUE} converted_value.make (string_value)
			elseif a_required_type = type_factory.untyped_atomic_type then
				create {XM_XPATH_STRING_VALUE} converted_value.make_untyped_atomic (string_value)
			end
		end

	rounded_value: like Current
			-- `a_numeric_value' rounded towards the nearest whole number (0.5 rounded up)
		do
			Result := Current
		end

	rounded_half_even (a_scale: INTEGER): like Current
			-- `a_numeric_value' rounded towards the nearest even number;
		local
			a_decimal: MA_DECIMAL
		do
			if a_scale >= 0 then
				Result := Current
			else
				a_decimal := value.rescale (0 - a_scale, shared_half_even_context)
				create Result.make (a_decimal)
			end
		end

	floor: like Current
			-- Value rounded towards minus infinity
		do
			Result := Current
		end

	ceiling: like Current
			-- Value rounded towards plus infinity
		do
			Result := Current
		end

	negated_value: like Current
			-- Same abaolute value but opposite sign
		do
			create Result.make (-value)
		end

feature -- Basic operations

	arithmetic (a_operator: INTEGER; other: XM_XPATH_NUMERIC_VALUE): XM_XPATH_NUMERIC_VALUE
			-- Arithmetic calculation
		local
			l_integer_value: XM_XPATH_INTEGER_VALUE
			l_numeric_value: XM_XPATH_NUMERIC_VALUE
			l_integer, l_decimal: MA_DECIMAL
		do
			if other.is_integer_value then
				l_integer_value := other.as_integer_value
				inspect
					a_operator
				when Plus_token then
					create {XM_XPATH_INTEGER_VALUE} Result.make (value.add(l_integer_value.value, shared_integer_context))
				when Minus_token then
					create {XM_XPATH_INTEGER_VALUE} Result.make (value.subtract (l_integer_value.value, shared_integer_context))
				when Multiply_token then
					create {XM_XPATH_INTEGER_VALUE} Result.make (value.multiply (l_integer_value.value, shared_integer_context))
				when Integer_division_token then
					if l_integer_value.is_zero then
						create {XM_XPATH_INTEGER_VALUE} Result.make_from_integer (0)
						Result.set_last_error_from_string ("Division by zero", Xpath_errors_uri, "FOAR0001", Dynamic_error)
					else
						l_integer := value.divide_integer (l_integer_value.value, shared_integer_context)
						l_integer := l_integer.rescale (0, shared_integer_context)
						create {XM_XPATH_INTEGER_VALUE} Result.make (l_integer)
					end
				when Division_token then

					-- The result of dividing two integers is a decimal

					if l_integer_value.is_zero then
						create {XM_XPATH_DECIMAL_VALUE} Result.make_error ("Division by Zero", Xpath_errors_uri, "FOAR0001", Dynamic_error)
					else
						l_decimal := value / l_integer_value.value
						create {XM_XPATH_DECIMAL_VALUE} Result.make (l_decimal)
					end
				when Modulus_token then
					debug ("XPath Integer values")
						std.error.put_string ("Dividend is ")
						std.error.put_string (string_value)
						std.error.put_new_line
						std.error.put_string ("Divisor is ")
						std.error.put_string (l_integer_value.string_value)
						std.error.put_new_line
					end
					create {XM_XPATH_INTEGER_VALUE} Result.make (value.remainder (l_integer_value.value, shared_integer_context))
					debug ("XPath Integer values")
						std.error.put_string ("Result is ")
						std.error.put_string (Result.string_value)
						std.error.put_new_line
					end
				end
			elseif other.is_machine_integer_value then
				create l_integer_value.make_from_string (other.as_machine_integer_value.value.out)
				Result := arithmetic (a_operator, l_integer_value)
			else
				convert_to_type (other.item_type)
				l_numeric_value := converted_value.as_numeric_value
				Result := l_numeric_value.arithmetic (a_operator, other)
			end
		end

invariant

	is_integer: value.is_integer

end
