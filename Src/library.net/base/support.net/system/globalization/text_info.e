indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Globalization.TextInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	TEXT_INFO

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDESERIALIZATION_CALLBACK
		rename
			on_deserialization as system_runtime_serialization_ideserialization_callback_on_deserialization
		end

create {NONE}

feature -- Access

	get_oemcode_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.TextInfo"
		alias
			"get_OEMCodePage"
		end

	get_list_separator: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.TextInfo"
		alias
			"get_ListSeparator"
		end

	get_mac_code_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.TextInfo"
		alias
			"get_MacCodePage"
		end

	get_ansicode_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.TextInfo"
		alias
			"get_ANSICodePage"
		end

	get_ebcdiccode_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.TextInfo"
		alias
			"get_EBCDICCodePage"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Globalization.TextInfo"
		alias
			"ToString"
		end

	to_upper (c: CHARACTER): CHARACTER is
		external
			"IL signature (System.Char): System.Char use System.Globalization.TextInfo"
		alias
			"ToUpper"
		end

	to_lower (c: CHARACTER): CHARACTER is
		external
			"IL signature (System.Char): System.Char use System.Globalization.TextInfo"
		alias
			"ToLower"
		end

	to_upper_string (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Globalization.TextInfo"
		alias
			"ToUpper"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.TextInfo"
		alias
			"Equals"
		end

	frozen to_title_case (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Globalization.TextInfo"
		alias
			"ToTitleCase"
		end

	to_lower_string (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Globalization.TextInfo"
		alias
			"ToLower"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Globalization.TextInfo"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Globalization.TextInfo"
		alias
			"Finalize"
		end

	frozen system_runtime_serialization_ideserialization_callback_on_deserialization (sender: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Globalization.TextInfo"
		alias
			"System.Runtime.Serialization.IDeserializationCallback.OnDeserialization"
		end

end -- class TEXT_INFO
