indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Serialization.FormatterConverter"

external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERCONVERTER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Serialization.FormatterConverter"
		end

feature -- Basic Operations

	frozen to_int16 (value: ANY): INTEGER_16 is
		external
			"IL signature (System.Object): System.Int16 use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToInt16"
		end

	frozen to_date_time (value: ANY): SYSTEM_DATETIME is
		external
			"IL signature (System.Object): System.DateTime use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToDateTime"
		end

	frozen to_int32 (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToInt32"
		end

	frozen to_string_object (value: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToString"
		end

	frozen to_byte (value: ANY): INTEGER_8 is
		external
			"IL signature (System.Object): System.Byte use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToByte"
		end

	frozen to_decimal (value: ANY): SYSTEM_DECIMAL is
		external
			"IL signature (System.Object): System.Decimal use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToDecimal"
		end

	frozen to_int64 (value: ANY): INTEGER_64 is
		external
			"IL signature (System.Object): System.Int64 use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToInt64"
		end

	frozen to_single (value: ANY): REAL is
		external
			"IL signature (System.Object): System.Single use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToSingle"
		end

	frozen convert (value: ANY; type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Object, System.Type): System.Object use System.Runtime.Serialization.FormatterConverter"
		alias
			"Convert"
		end

	frozen convert_object_type_code (value: ANY; type_code: INTEGER): ANY is
			-- Valid values for `type_code' are:
			-- Empty = 0
			-- Object = 1
			-- DBNull = 2
			-- Boolean = 3
			-- Char = 4
			-- SByte = 5
			-- Byte = 6
			-- Int16 = 7
			-- UInt16 = 8
			-- Int32 = 9
			-- UInt32 = 10
			-- Int64 = 11
			-- UInt64 = 12
			-- Single = 13
			-- Double = 14
			-- Decimal = 15
			-- DateTime = 16
			-- String = 18
		require
			valid_type_code: type_code = 0 or type_code = 1 or type_code = 2 or type_code = 3 or type_code = 4 or type_code = 5 or type_code = 6 or type_code = 7 or type_code = 8 or type_code = 9 or type_code = 10 or type_code = 11 or type_code = 12 or type_code = 13 or type_code = 14 or type_code = 15 or type_code = 16 or type_code = 18
		external
			"IL signature (System.Object, enum System.TypeCode): System.Object use System.Runtime.Serialization.FormatterConverter"
		alias
			"Convert"
		end

	frozen to_char (value: ANY): CHARACTER is
		external
			"IL signature (System.Object): System.Char use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToChar"
		end

	frozen to_boolean (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToBoolean"
		end

	frozen to_double (value: ANY): DOUBLE is
		external
			"IL signature (System.Object): System.Double use System.Runtime.Serialization.FormatterConverter"
		alias
			"ToDouble"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERCONVERTER
