indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Math"

frozen external class
	SYSTEM_MATH

create {NONE}

feature -- Access

	frozen pi: DOUBLE is 3.14159265358979

	frozen e: DOUBLE is 2.71828182845905

feature -- Basic Operations

	frozen abs_decimal (value: SYSTEM_DECIMAL): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Decimal): System.Decimal use System.Math"
		alias
			"Abs"
		end

	frozen min_int32 (val1: INTEGER; val2: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32, System.Int32): System.Int32 use System.Math"
		alias
			"Min"
		end

	frozen log10 (d: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Log10"
		end

	frozen max_int16 (val1: INTEGER_16; val2: INTEGER_16): INTEGER_16 is
		external
			"IL static signature (System.Int16, System.Int16): System.Int16 use System.Math"
		alias
			"Max"
		end

	frozen sign (value: REAL): INTEGER is
		external
			"IL static signature (System.Single): System.Int32 use System.Math"
		alias
			"Sign"
		end

	frozen log_double_double (a: DOUBLE; new_base: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double, System.Double): System.Double use System.Math"
		alias
			"Log"
		end

	frozen abs_int16 (value: INTEGER_16): INTEGER_16 is
		external
			"IL static signature (System.Int16): System.Int16 use System.Math"
		alias
			"Abs"
		end

	frozen atan (d: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Atan"
		end

	frozen min_int64 (val1: INTEGER_64; val2: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64, System.Int64): System.Int64 use System.Math"
		alias
			"Min"
		end

	frozen round_decimal_int32 (d: SYSTEM_DECIMAL; decimals: INTEGER): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Decimal, System.Int32): System.Decimal use System.Math"
		alias
			"Round"
		end

	frozen sqrt (d: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Sqrt"
		end

	frozen ceiling (a: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Ceiling"
		end

	frozen min_decimal (val1: SYSTEM_DECIMAL; val2: SYSTEM_DECIMAL): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Decimal, System.Decimal): System.Decimal use System.Math"
		alias
			"Min"
		end

	frozen min_byte (val1: INTEGER_8; val2: INTEGER_8): INTEGER_8 is
		external
			"IL static signature (System.Byte, System.Byte): System.Byte use System.Math"
		alias
			"Min"
		end

	frozen abs_double (value: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Abs"
		end

	frozen pow (x: DOUBLE; y: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double, System.Double): System.Double use System.Math"
		alias
			"Pow"
		end

	frozen round_double (a: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Round"
		end

	frozen min (val1: REAL; val2: REAL): REAL is
		external
			"IL static signature (System.Single, System.Single): System.Single use System.Math"
		alias
			"Min"
		end

	frozen atan2 (y: DOUBLE; x: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double, System.Double): System.Double use System.Math"
		alias
			"Atan2"
		end

	frozen max_byte (val1: INTEGER_8; val2: INTEGER_8): INTEGER_8 is
		external
			"IL static signature (System.Byte, System.Byte): System.Byte use System.Math"
		alias
			"Max"
		end

	frozen asin (d: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Asin"
		end

	frozen tan (a: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Tan"
		end

	frozen round (d: SYSTEM_DECIMAL): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Decimal): System.Decimal use System.Math"
		alias
			"Round"
		end

	frozen sign_decimal (value: SYSTEM_DECIMAL): INTEGER is
		external
			"IL static signature (System.Decimal): System.Int32 use System.Math"
		alias
			"Sign"
		end

	frozen sign_int64 (value: INTEGER_64): INTEGER is
		external
			"IL static signature (System.Int64): System.Int32 use System.Math"
		alias
			"Sign"
		end

	frozen max_int32 (val1: INTEGER; val2: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32, System.Int32): System.Int32 use System.Math"
		alias
			"Max"
		end

	frozen min_double (val1: DOUBLE; val2: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double, System.Double): System.Double use System.Math"
		alias
			"Min"
		end

	frozen sign_int32 (value: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32): System.Int32 use System.Math"
		alias
			"Sign"
		end

	frozen abs_int32 (value: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32): System.Int32 use System.Math"
		alias
			"Abs"
		end

	frozen max_double (val1: DOUBLE; val2: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double, System.Double): System.Double use System.Math"
		alias
			"Max"
		end

	frozen min_int16 (val1: INTEGER_16; val2: INTEGER_16): INTEGER_16 is
		external
			"IL static signature (System.Int16, System.Int16): System.Int16 use System.Math"
		alias
			"Min"
		end

	frozen cosh (value: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Cosh"
		end

	frozen sin (a: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Sin"
		end

	frozen max_int64 (val1: INTEGER_64; val2: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64, System.Int64): System.Int64 use System.Math"
		alias
			"Max"
		end

	frozen ieeeremainder (x: DOUBLE; y: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double, System.Double): System.Double use System.Math"
		alias
			"IEEERemainder"
		end

	frozen round_double_int32 (value: DOUBLE; digits: INTEGER): DOUBLE is
		external
			"IL static signature (System.Double, System.Int32): System.Double use System.Math"
		alias
			"Round"
		end

	frozen max_decimal (val1: SYSTEM_DECIMAL; val2: SYSTEM_DECIMAL): SYSTEM_DECIMAL is
		external
			"IL static signature (System.Decimal, System.Decimal): System.Decimal use System.Math"
		alias
			"Max"
		end

	frozen log (d: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Log"
		end

	frozen abs (value: REAL): REAL is
		external
			"IL static signature (System.Single): System.Single use System.Math"
		alias
			"Abs"
		end

	frozen exp (d: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Exp"
		end

	frozen sinh (value: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Sinh"
		end

	frozen sign_double (value: DOUBLE): INTEGER is
		external
			"IL static signature (System.Double): System.Int32 use System.Math"
		alias
			"Sign"
		end

	frozen cos (d: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Cos"
		end

	frozen max (val1: REAL; val2: REAL): REAL is
		external
			"IL static signature (System.Single, System.Single): System.Single use System.Math"
		alias
			"Max"
		end

	frozen tanh (value: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Tanh"
		end

	frozen sign_int16 (value: INTEGER_16): INTEGER is
		external
			"IL static signature (System.Int16): System.Int32 use System.Math"
		alias
			"Sign"
		end

	frozen abs_int64 (value: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64): System.Int64 use System.Math"
		alias
			"Abs"
		end

	frozen acos (d: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Acos"
		end

	frozen floor (d: DOUBLE): DOUBLE is
		external
			"IL static signature (System.Double): System.Double use System.Math"
		alias
			"Floor"
		end

end -- class SYSTEM_MATH
