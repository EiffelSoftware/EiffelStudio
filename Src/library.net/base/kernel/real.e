indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Single"

frozen expanded external class
	REAL

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

	frozen min_value: REAL is -3.402823E+38

	frozen epsilon: REAL is 1.401298E-45

	frozen max_value: REAL is 3.402823E+38

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Single"
		alias
			"ToString"
		end

	frozen get_type_code: SYSTEM_TYPECODE is
		external
			"IL signature (): System.TypeCode use System.Single"
		alias
			"GetTypeCode"
		end

	frozen is_negative_infinity (f: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsNegativeInfinity"
		end

	frozen parse_string_iformat_provider (s: STRING; provider: SYSTEM_IFORMATPROVIDER): REAL is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Single use System.Single"
		alias
			"Parse"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Single"
		alias
			"GetHashCode"
		end

	frozen is_infinity (f: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsInfinity"
		end

	frozen to_string_iformat_provider (provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Single"
		alias
			"ToString"
		end

	frozen is_na_n (f: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsNaN"
		end

	frozen parse_string_number_styles (s: STRING; style: SYSTEM_GLOBALIZATION_NUMBERSTYLES): REAL is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen to_string_string2 (format: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Single"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Single"
		alias
			"Equals"
		end

	frozen parse_string_number_styles_iformat_provider (s: STRING; style: SYSTEM_GLOBALIZATION_NUMBERSTYLES; provider: SYSTEM_IFORMATPROVIDER): REAL is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen is_positive_infinity (f: REAL): BOOLEAN is
		external
			"IL static signature (System.Single): System.Boolean use System.Single"
		alias
			"IsPositiveInfinity"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Single"
		alias
			"CompareTo"
		end

	frozen parse (s: STRING): REAL is
		external
			"IL static signature (System.String): System.Single use System.Single"
		alias
			"Parse"
		end

	frozen to_string_string (format: STRING; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Single"
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

end -- class REAL
