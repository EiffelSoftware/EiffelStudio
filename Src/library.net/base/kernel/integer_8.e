indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Byte"

frozen expanded external class
	INTEGER_8

inherit
	SYSTEM_VALUETYPE
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

	frozen min_value: INTEGER_8 is
		external
			"IL static_field signature :System.Byte use System.Byte"
		alias
			"MinValue"
		end

	frozen max_value: INTEGER_8 is
		external
			"IL static_field signature :System.Byte use System.Byte"
		alias
			"MaxValue"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Byte"
		alias
			"ToString"
		end

	frozen get_type_code: INTEGER is
		external
			"IL signature (): enum System.TypeCode use System.Byte"
		alias
			"GetTypeCode"
		ensure
			valid_type_code: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 13 or Result = 14 or Result = 15 or Result = 16 or Result = 18
		end

	frozen to_string_with_format (format: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Byte"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Byte"
		alias
			"GetHashCode"
		end

	frozen to_string_with_provider (provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Byte"
		alias
			"ToString"
		end

	frozen parse_string_number_styles (s: STRING; style: INTEGER): INTEGER_8 is
			-- Valid values for `style' are a combination of the following values:
			-- None = 0
			-- AllowLeadingWhite = 1
			-- AllowTrailingWhite = 2
			-- AllowLeadingSign = 4
			-- AllowTrailingSign = 8
			-- AllowParentheses = 16
			-- AllowDecimalPoint = 32
			-- AllowThousands = 64
			-- AllowExponent = 128
			-- AllowCurrencySymbol = 256
			-- AllowHexSpecifier = 512
			-- Integer = 7
			-- HexNumber = 515
			-- Number = 111
			-- Float = 167
			-- Currency = 383
			-- Any = 511
		require
			valid_number_styles: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 7 + 515 + 111 + 167 + 383 + 511) & style = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 7 + 515 + 111 + 167 + 383 + 511
		external
			"IL static signature (System.String, enum System.Globalization.NumberStyles): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen parse_string_iformat_provider (s: STRING; provider: SYSTEM_IFORMATPROVIDER): INTEGER_8 is
		external
			"IL static signature (System.String, System.IFormatProvider): System.Byte use System.Byte"
		alias
			"Parse"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Byte"
		alias
			"Equals"
		end

	frozen parse_string_number_styles_iformat_provider (s: STRING; style: INTEGER; provider: SYSTEM_IFORMATPROVIDER): INTEGER_8 is
			-- Valid values for `style' are a combination of the following values:
			-- None = 0
			-- AllowLeadingWhite = 1
			-- AllowTrailingWhite = 2
			-- AllowLeadingSign = 4
			-- AllowTrailingSign = 8
			-- AllowParentheses = 16
			-- AllowDecimalPoint = 32
			-- AllowThousands = 64
			-- AllowExponent = 128
			-- AllowCurrencySymbol = 256
			-- AllowHexSpecifier = 512
			-- Integer = 7
			-- HexNumber = 515
			-- Number = 111
			-- Float = 167
			-- Currency = 383
			-- Any = 511
		require
			valid_number_styles: (0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 7 + 515 + 111 + 167 + 383 + 511) & style = 0 + 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 7 + 515 + 111 + 167 + 383 + 511
		external
			"IL static signature (System.String, enum System.Globalization.NumberStyles, System.IFormatProvider): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Byte"
		alias
			"CompareTo"
		end

	frozen parse (s: STRING): INTEGER_8 is
		external
			"IL static signature (System.String): System.Byte use System.Byte"
		alias
			"Parse"
		end

	frozen to_string_with_format_and_provider (format: STRING; provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Byte"
		alias
			"ToString"
		end

feature -- Eiffel Basic Operations

	infix "<" (other: like Current): BOOLEAN is
			-- Is current integer less than `other'?
		do
		end

	infix ">" (other: like Current): BOOLEAN is
			-- Is current object greater than `other'?
		do
		end

	infix ">=" (other: like Current): BOOLEAN is
			-- Is current object greater than or equal to `other'?
		do
		end

	infix "<=" (other: like Current): BOOLEAN is
			-- Is current object less than or equal to `other'?
		do
		end

end -- class INTEGER_8
