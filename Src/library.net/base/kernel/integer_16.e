indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Int16"

frozen expanded external class
	INTEGER_16

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end
	ICOMPARABLE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen min_value: INTEGER_16 is 0x8000

	frozen max_value: INTEGER_16 is 0x7fff

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Int16"
		alias
			"ToString"
		end

	frozen get_type_code: SYSTEM_TYPECODE is
		external
			"IL signature (): System.TypeCode use System.Int16"
		alias
			"GetTypeCode"
		end

	frozen parse_string_iformat_provider (s: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER_16 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Int16 use System.Int16"
		alias
			"Parse"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Int16"
		alias
			"GetHashCode"
		end

	frozen to_string_iformat_provider (provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Int16"
		alias
			"ToString"
		end

	frozen parse_string_number_styles (s: STRING; style: SYSTEM_GLOBALIZATION_NUMBERSTYLES): INTEGER_16 is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles): System.Int16 use System.Int16"
		alias
			"Parse"
		end

	frozen to_string_string2 (format: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Int16"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Int16"
		alias
			"Equals"
		end

	frozen parse_string_number_styles_iformat_provider (s: STRING; style: SYSTEM_GLOBALIZATION_NUMBERSTYLES; provider: SYSTEM_IFORMATPROVIDER): INTEGER_16 is
		external
			"IL static signature (System.String, System.Globalization.NumberStyles, System.IFormatProvider): System.Int16 use System.Int16"
		alias
			"Parse"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Int16"
		alias
			"CompareTo"
		end

	frozen parse (s: STRING): INTEGER_16 is
		external
			"IL static signature (System.String): System.Int16 use System.Int16"
		alias
			"Parse"
		end

	frozen to_string_string (format: STRING; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Int16"
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

	infix "\\" (other: like Current): like Current is
			-- Remainder of the integer division of Current by `other'
		do
			-- Built-in
		end

	infix "//" (other: like Current): like Current is
			-- Integer division of Current by `other'
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

	infix "&" (other: like Current): like Current is
			-- Sum with `other'
		do
			-- Built-in
		end

	infix "|" (other: like Current): like Current is
			-- Sum with `other'
		do
			-- Built-in
		end
	
end -- class INTEGER_16
