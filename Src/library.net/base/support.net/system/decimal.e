indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Decimal"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DECIMAL

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	IFORMATTABLE
	ICOMPARABLE

feature -- Initialization

	frozen make_decimal_4 (bits: NATIVE_ARRAY [INTEGER]) is
		external
			"IL creator signature (System.Int32[]) use System.Decimal"
		end

	frozen make_decimal_1 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.Decimal"
		end

	frozen make_decimal_3 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Decimal"
		end

	frozen make_decimal_2 (value: REAL) is
		external
			"IL creator signature (System.Single) use System.Decimal"
		end

	frozen make_decimal (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Decimal"
		end

	frozen make_decimal_5 (lo: INTEGER; mid: INTEGER; hi: INTEGER; is_negative: BOOLEAN; scale: INTEGER_8) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Boolean, System.Byte) use System.Decimal"
		end

feature -- Access

	frozen min_value: DECIMAL is
		external
			"IL static_field signature :System.Decimal use System.Decimal"
		alias
			"MinValue"
		end

	frozen zero: DECIMAL is
		external
			"IL static_field signature :System.Decimal use System.Decimal"
		alias
			"Zero"
		end

	frozen minus_one: DECIMAL is
		external
			"IL static_field signature :System.Decimal use System.Decimal"
		alias
			"MinusOne"
		end

	frozen one: DECIMAL is
		external
			"IL static_field signature :System.Decimal use System.Decimal"
		alias
			"One"
		end

	frozen max_value: DECIMAL is
		external
			"IL static_field signature :System.Decimal use System.Decimal"
		alias
			"MaxValue"
		end

feature -- Basic Operations

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Decimal"
		alias
			"ToString"
		end

	frozen parse_string_number_styles (s: SYSTEM_STRING; style: NUMBER_STYLES): DECIMAL is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Decimal use System.Decimal"
		alias
			"Parse"
		end

	frozen negate (d: DECIMAL): DECIMAL is
		external
			"IL static signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"Negate"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Decimal"
		alias
			"Equals"
		end

	frozen to_int16 (value: DECIMAL): INTEGER_16 is
		external
			"IL static signature (System.Decimal): System.Int16 use System.Decimal"
		alias
			"ToInt16"
		end

	frozen to_byte (value: DECIMAL): INTEGER_8 is
		external
			"IL static signature (System.Decimal): System.Byte use System.Decimal"
		alias
			"ToByte"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Decimal"
		alias
			"GetHashCode"
		end

	frozen to_double (d: DECIMAL): DOUBLE is
		external
			"IL static signature (System.Decimal): System.Double use System.Decimal"
		alias
			"ToDouble"
		end

	frozen get_bits (d: DECIMAL): NATIVE_ARRAY [INTEGER] is
		external
			"IL static signature (System.Decimal): System.Int32[] use System.Decimal"
		alias
			"GetBits"
		end

	frozen to_single (d: DECIMAL): REAL is
		external
			"IL static signature (System.Decimal): System.Single use System.Decimal"
		alias
			"ToSingle"
		end

	frozen truncate (d: DECIMAL): DECIMAL is
		external
			"IL static signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"Truncate"
		end

	frozen equals_decimal (d1: DECIMAL; d2: DECIMAL): BOOLEAN is
		external
			"IL static signature (System.Decimal, System.Decimal): System.Boolean use System.Decimal"
		alias
			"Equals"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Decimal"
		alias
			"CompareTo"
		end

	frozen round (d: DECIMAL; decimals: INTEGER): DECIMAL is
		external
			"IL static signature (System.Decimal, System.Int32): System.Decimal use System.Decimal"
		alias
			"Round"
		end

	frozen subtract (d1: DECIMAL; d2: DECIMAL): DECIMAL is
		external
			"IL static signature (System.Decimal, System.Decimal): System.Decimal use System.Decimal"
		alias
			"Subtract"
		end

	frozen to_oacurrency (value: DECIMAL): INTEGER_64 is
		external
			"IL static signature (System.Decimal): System.Int64 use System.Decimal"
		alias
			"ToOACurrency"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Decimal"
		alias
			"ToString"
		end

	frozen to_int32 (d: DECIMAL): INTEGER is
		external
			"IL static signature (System.Decimal): System.Int32 use System.Decimal"
		alias
			"ToInt32"
		end

	frozen add (d1: DECIMAL; d2: DECIMAL): DECIMAL is
		external
			"IL static signature (System.Decimal, System.Decimal): System.Decimal use System.Decimal"
		alias
			"Add"
		end

	frozen to_string_string2 (format: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Decimal"
		alias
			"ToString"
		end

	frozen parse_string_number_styles_iformat_provider (s: SYSTEM_STRING; style: NUMBER_STYLES; provider: IFORMAT_PROVIDER): DECIMAL is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Decimal use System.Decimal"
		alias
			"Parse"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.Decimal"
		alias
			"GetTypeCode"
		end

	frozen remainder (d1: DECIMAL; d2: DECIMAL): DECIMAL is
		external
			"IL static signature (System.Decimal, System.Decimal): System.Decimal use System.Decimal"
		alias
			"Remainder"
		end

	frozen parse_string_iformat_provider (s: SYSTEM_STRING; provider: IFORMAT_PROVIDER): DECIMAL is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Decimal use System.Decimal"
		alias
			"Parse"
		end

	frozen compare (d1: DECIMAL; d2: DECIMAL): INTEGER is
		external
			"IL static signature (System.Decimal, System.Decimal): System.Int32 use System.Decimal"
		alias
			"Compare"
		end

	frozen from_oacurrency (cy: INTEGER_64): DECIMAL is
		external
			"IL static signature (System.Int64): System.Decimal use System.Decimal"
		alias
			"FromOACurrency"
		end

	frozen divide (d1: DECIMAL; d2: DECIMAL): DECIMAL is
		external
			"IL static signature (System.Decimal, System.Decimal): System.Decimal use System.Decimal"
		alias
			"Divide"
		end

	frozen multiply (d1: DECIMAL; d2: DECIMAL): DECIMAL is
		external
			"IL static signature (System.Decimal, System.Decimal): System.Decimal use System.Decimal"
		alias
			"Multiply"
		end

	frozen to_string_string (format: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Decimal"
		alias
			"ToString"
		end

	frozen parse (s: SYSTEM_STRING): DECIMAL is
		external
			"IL static signature (System.String): System.Decimal use System.Decimal"
		alias
			"Parse"
		end

	frozen floor (d: DECIMAL): DECIMAL is
		external
			"IL static signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"Floor"
		end

	frozen to_int64 (d: DECIMAL): INTEGER_64 is
		external
			"IL static signature (System.Decimal): System.Int64 use System.Decimal"
		alias
			"ToInt64"
		end

feature -- Unary Operators

	frozen prefix "+": DECIMAL is
		external
			"IL operator signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"op_UnaryPlus"
		end

	frozen prefix "-": DECIMAL is
		external
			"IL operator signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"op_UnaryNegation"
		end

	frozen prefix "#++": DECIMAL is
		external
			"IL operator signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"op_Increment"
		end

	frozen prefix "#--": DECIMAL is
		external
			"IL operator signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"op_Decrement"
		end

feature -- Binary Operators

	frozen infix "|=" (d2: DECIMAL): BOOLEAN is
		external
			"IL operator signature (System.Decimal): System.Boolean use System.Decimal"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (d2: DECIMAL): BOOLEAN is
		external
			"IL operator signature (System.Decimal): System.Boolean use System.Decimal"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "/" (d2: DECIMAL): DECIMAL is
		external
			"IL operator signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"op_Division"
		end

	frozen infix "#==" (d2: DECIMAL): BOOLEAN is
		external
			"IL operator signature (System.Decimal): System.Boolean use System.Decimal"
		alias
			"op_Equality"
		end

	frozen infix "-" (d2: DECIMAL): DECIMAL is
		external
			"IL operator signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (d2: DECIMAL): BOOLEAN is
		external
			"IL operator signature (System.Decimal): System.Boolean use System.Decimal"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "\\" (d2: DECIMAL): DECIMAL is
		external
			"IL operator signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"op_Modulus"
		end

	frozen infix "+" (d2: DECIMAL): DECIMAL is
		external
			"IL operator signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"op_Addition"
		end

	frozen infix ">" (d2: DECIMAL): BOOLEAN is
		external
			"IL operator signature (System.Decimal): System.Boolean use System.Decimal"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (d2: DECIMAL): BOOLEAN is
		external
			"IL operator signature (System.Decimal): System.Boolean use System.Decimal"
		alias
			"op_LessThan"
		end

	frozen infix "*" (d2: DECIMAL): DECIMAL is
		external
			"IL operator signature (System.Decimal): System.Decimal use System.Decimal"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_explicit_decimal2 (value: DECIMAL): DOUBLE is
		external
			"IL static signature (System.Decimal): System.Double use System.Decimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit (value: DECIMAL): INTEGER_64 is
		external
			"IL static signature (System.Decimal): System.Int64 use System.Decimal"
		alias
			"op_Explicit"
		end

	frozen op_implicit_char (value: CHARACTER): DECIMAL is
		external
			"IL static signature (System.Char): System.Decimal use System.Decimal"
		alias
			"op_Implicit"
		end

	frozen op_explicit_double (value: DOUBLE): DECIMAL is
		external
			"IL static signature (System.Double): System.Decimal use System.Decimal"
		alias
			"op_Explicit"
		end

	frozen op_implicit_byte (value: INTEGER_8): DECIMAL is
		external
			"IL static signature (System.Byte): System.Decimal use System.Decimal"
		alias
			"op_Implicit"
		end

	frozen op_implicit_int64 (value: INTEGER_64): DECIMAL is
		external
			"IL static signature (System.Int64): System.Decimal use System.Decimal"
		alias
			"op_Implicit"
		end

	frozen op_explicit_decimal2345 (value: DECIMAL): CHARACTER is
		external
			"IL static signature (System.Decimal): System.Char use System.Decimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_decimal (value: DECIMAL): INTEGER is
		external
			"IL static signature (System.Decimal): System.Int32 use System.Decimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_decimal23 (value: DECIMAL): REAL is
		external
			"IL static signature (System.Decimal): System.Single use System.Decimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_decimal234 (value: DECIMAL): INTEGER_16 is
		external
			"IL static signature (System.Decimal): System.Int16 use System.Decimal"
		alias
			"op_Explicit"
		end

	frozen op_implicit (value: INTEGER): DECIMAL is
		external
			"IL static signature (System.Int32): System.Decimal use System.Decimal"
		alias
			"op_Implicit"
		end

	frozen op_explicit_decimal23456 (value: DECIMAL): INTEGER_8 is
		external
			"IL static signature (System.Decimal): System.Byte use System.Decimal"
		alias
			"op_Explicit"
		end

	frozen op_explicit_single (value: REAL): DECIMAL is
		external
			"IL static signature (System.Single): System.Decimal use System.Decimal"
		alias
			"op_Explicit"
		end

	frozen op_implicit_int16 (value: INTEGER_16): DECIMAL is
		external
			"IL static signature (System.Int16): System.Decimal use System.Decimal"
		alias
			"op_Implicit"
		end

end -- class DECIMAL
