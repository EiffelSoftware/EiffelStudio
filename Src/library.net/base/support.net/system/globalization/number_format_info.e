indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.NumberFormatInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	NUMBER_FORMAT_INFO

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
	IFORMAT_PROVIDER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Globalization.NumberFormatInfo"
		end

feature -- Access

	frozen get_number_group_separator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_NumberGroupSeparator"
		end

	frozen get_currency_group_separator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_CurrencyGroupSeparator"
		end

	frozen get_number_decimal_separator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_NumberDecimalSeparator"
		end

	frozen get_percent_symbol: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_PercentSymbol"
		end

	frozen get_percent_group_sizes: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Globalization.NumberFormatInfo"
		alias
			"get_PercentGroupSizes"
		end

	frozen get_currency_positive_pattern: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.NumberFormatInfo"
		alias
			"get_CurrencyPositivePattern"
		end

	frozen get_currency_group_sizes: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Globalization.NumberFormatInfo"
		alias
			"get_CurrencyGroupSizes"
		end

	frozen get_percent_positive_pattern: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.NumberFormatInfo"
		alias
			"get_PercentPositivePattern"
		end

	frozen get_currency_decimal_digits: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.NumberFormatInfo"
		alias
			"get_CurrencyDecimalDigits"
		end

	frozen get_percent_decimal_digits: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.NumberFormatInfo"
		alias
			"get_PercentDecimalDigits"
		end

	frozen get_na_nsymbol: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_NaNSymbol"
		end

	frozen get_positive_infinity_symbol: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_PositiveInfinitySymbol"
		end

	frozen get_percent_group_separator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_PercentGroupSeparator"
		end

	frozen get_positive_sign: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_PositiveSign"
		end

	frozen get_percent_decimal_separator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_PercentDecimalSeparator"
		end

	frozen get_currency_decimal_separator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_CurrencyDecimalSeparator"
		end

	frozen get_currency_negative_pattern: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.NumberFormatInfo"
		alias
			"get_CurrencyNegativePattern"
		end

	frozen get_number_negative_pattern: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.NumberFormatInfo"
		alias
			"get_NumberNegativePattern"
		end

	frozen get_negative_sign: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_NegativeSign"
		end

	frozen get_number_group_sizes: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Globalization.NumberFormatInfo"
		alias
			"get_NumberGroupSizes"
		end

	frozen get_per_mille_symbol: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_PerMilleSymbol"
		end

	frozen get_current_info: NUMBER_FORMAT_INFO is
		external
			"IL static signature (): System.Globalization.NumberFormatInfo use System.Globalization.NumberFormatInfo"
		alias
			"get_CurrentInfo"
		end

	frozen get_percent_negative_pattern: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.NumberFormatInfo"
		alias
			"get_PercentNegativePattern"
		end

	frozen get_negative_infinity_symbol: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_NegativeInfinitySymbol"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Globalization.NumberFormatInfo"
		alias
			"get_IsReadOnly"
		end

	frozen get_number_decimal_digits: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.NumberFormatInfo"
		alias
			"get_NumberDecimalDigits"
		end

	frozen get_currency_symbol: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"get_CurrencySymbol"
		end

	frozen get_invariant_info: NUMBER_FORMAT_INFO is
		external
			"IL static signature (): System.Globalization.NumberFormatInfo use System.Globalization.NumberFormatInfo"
		alias
			"get_InvariantInfo"
		end

feature -- Element Change

	frozen set_positive_infinity_symbol (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PositiveInfinitySymbol"
		end

	frozen set_currency_positive_pattern (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_CurrencyPositivePattern"
		end

	frozen set_currency_group_sizes (value: NATIVE_ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_CurrencyGroupSizes"
		end

	frozen set_percent_group_sizes (value: NATIVE_ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PercentGroupSizes"
		end

	frozen set_number_group_separator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_NumberGroupSeparator"
		end

	frozen set_per_mille_symbol (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PerMilleSymbol"
		end

	frozen set_currency_negative_pattern (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_CurrencyNegativePattern"
		end

	frozen set_number_group_sizes (value: NATIVE_ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_NumberGroupSizes"
		end

	frozen set_percent_negative_pattern (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PercentNegativePattern"
		end

	frozen set_na_nsymbol (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_NaNSymbol"
		end

	frozen set_percent_positive_pattern (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PercentPositivePattern"
		end

	frozen set_currency_decimal_digits (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_CurrencyDecimalDigits"
		end

	frozen set_negative_sign (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_NegativeSign"
		end

	frozen set_percent_symbol (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PercentSymbol"
		end

	frozen set_currency_decimal_separator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_CurrencyDecimalSeparator"
		end

	frozen set_currency_group_separator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_CurrencyGroupSeparator"
		end

	frozen set_number_negative_pattern (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_NumberNegativePattern"
		end

	frozen set_percent_decimal_digits (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PercentDecimalDigits"
		end

	frozen set_number_decimal_digits (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_NumberDecimalDigits"
		end

	frozen set_positive_sign (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PositiveSign"
		end

	frozen set_percent_decimal_separator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PercentDecimalSeparator"
		end

	frozen set_number_decimal_separator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_NumberDecimalSeparator"
		end

	frozen set_currency_symbol (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_CurrencySymbol"
		end

	frozen set_negative_infinity_symbol (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_NegativeInfinitySymbol"
		end

	frozen set_percent_group_separator (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"set_PercentGroupSeparator"
		end

feature -- Basic Operations

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.NumberFormatInfo"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.NumberFormatInfo"
		alias
			"GetHashCode"
		end

	frozen read_only (nfi: NUMBER_FORMAT_INFO): NUMBER_FORMAT_INFO is
		external
			"IL static signature (System.Globalization.NumberFormatInfo): System.Globalization.NumberFormatInfo use System.Globalization.NumberFormatInfo"
		alias
			"ReadOnly"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.NumberFormatInfo"
		alias
			"ToString"
		end

	frozen get_instance (format_provider: IFORMAT_PROVIDER): NUMBER_FORMAT_INFO is
		external
			"IL static signature (System.IFormatProvider): System.Globalization.NumberFormatInfo use System.Globalization.NumberFormatInfo"
		alias
			"GetInstance"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Globalization.NumberFormatInfo"
		alias
			"Clone"
		end

	frozen get_format (format_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Type): System.Object use System.Globalization.NumberFormatInfo"
		alias
			"GetFormat"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Globalization.NumberFormatInfo"
		alias
			"Finalize"
		end

end -- class NUMBER_FORMAT_INFO
