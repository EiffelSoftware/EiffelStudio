indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Double"

frozen expanded external class
	DOUBLE

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen min_value: DOUBLE is -1.79769313486232E+308

	frozen max_value: DOUBLE is 1.79769313486232E+308

	frozen epsilon: DOUBLE is 4.94065645841247E-324

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Double"
		alias
			"ToString"
		end

	frozen get_type_code: SYSTEM_TYPECODE is
		external
			"IL signature (): System.TypeCode use System.Double"
		alias
			"GetTypeCode"
		end

	frozen is_negative_infinity (d: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsNegativeInfinity"
		end

	frozen parse_string_iformat_provider (s: STRING; provider: SYSTEM_IFORMATPROVIDER): DOUBLE is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Double use System.Double"
		alias
			"Parse"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Double"
		alias
			"GetHashCode"
		end

	frozen is_infinity (d: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsInfinity"
		end

	frozen to_string_iformat_provider (provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Double"
		alias
			"ToString"
		end

	frozen is_na_n (d: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsNaN"
		end

	frozen parse_string_number_styles (s: STRING; style: SYSTEM_GLOBALIZATION_NUMBERSTYLES): DOUBLE is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen to_string_string2 (format: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Double"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Double"
		alias
			"Equals"
		end

	frozen parse_string_number_styles_iformat_provider (s: STRING; style: SYSTEM_GLOBALIZATION_NUMBERSTYLES; provider: SYSTEM_IFORMATPROVIDER): DOUBLE is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen is_positive_infinity (d: DOUBLE): BOOLEAN is
		external
			"IL static signature (System.Double): System.Boolean use System.Double"
		alias
			"IsPositiveInfinity"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Double"
		alias
			"CompareTo"
		end

	frozen parse (s: STRING): DOUBLE is
		external
			"IL static signature (System.String): System.Double use System.Double"
		alias
			"Parse"
		end

	frozen to_string_string (format: STRING; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Double"
		alias
			"ToString"
		end

feature -- Eiffel Basic Operations

	infix "<" (other: like Current): BOOLEAN is
			-- Is current integer less than `other'?
		do
			-- Built-in
		end

	infix ">" (other: like Current): BOOLEAN is
			-- Is current object greater than `other'?
		do
			-- Built-in
		end

	infix ">=" (other: like Current): BOOLEAN is
			-- Is current object greater than or equal to `other'?
		do
			-- Built-in
		end

	infix "<=" (other: like Current): BOOLEAN is
			-- Is current object less than or equal to `other'?
		do
			-- Built-in
		end

	infix "+" (other: like Current): like Current is
			-- Sum with `other'
		do
			-- Built-in
		end

	infix "-" (other: like Current): like Current is
			-- Result of subtracting `other'
		do
			-- Built-in
		end

	infix "*" (other: like Current): like Current is
			-- Product by `other'
		do
			-- Built-in
		end

	infix "/" (other: like Current): DOUBLE is
			-- Division by `other'
		do
			-- Built-in
		end

	prefix "+": like Current is
			-- Unary plus
		do
			-- Built-in
		end

	prefix "-": like Current is
			-- Unary minus
		do
			-- Built-in
		end

end -- class DOUBLE
