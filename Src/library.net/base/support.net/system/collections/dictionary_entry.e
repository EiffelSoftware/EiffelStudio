indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.DictionaryEntry"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DICTIONARY_ENTRY

inherit
	VALUE_TYPE

feature -- Initialization

	frozen make_dictionary_entry (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object, System.Object) use System.Collections.DictionaryEntry"
		end

feature -- Access

	frozen get_key: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.DictionaryEntry"
		alias
			"get_Key"
		end

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Collections.DictionaryEntry"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.DictionaryEntry"
		alias
			"set_Value"
		end

	frozen set_key (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Collections.DictionaryEntry"
		alias
			"set_Key"
		end

end -- class DICTIONARY_ENTRY
