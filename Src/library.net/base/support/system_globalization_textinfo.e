indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Globalization.TextInfo"

external class
	SYSTEM_GLOBALIZATION_TEXTINFO

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
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

	get_list_separator: STRING is
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

	to_string: STRING is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Globalization.TextInfo"
		alias
			"Equals"
		end

	to_upper_string (str: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Globalization.TextInfo"
		alias
			"ToUpper"
		end

	frozen to_title_case (str: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Globalization.TextInfo"
		alias
			"ToTitleCase"
		end

	to_lower_string (str: STRING): STRING is
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

	frozen system_runtime_serialization_ideserialization_callback_on_deserialization (sender: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Globalization.TextInfo"
		alias
			"System.Runtime.Serialization.IDeserializationCallback.OnDeserialization"
		end

end -- class SYSTEM_GLOBALIZATION_TEXTINFO
