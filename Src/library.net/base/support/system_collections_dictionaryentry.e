indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.DictionaryEntry"

frozen expanded external class
	SYSTEM_COLLECTIONS_DICTIONARYENTRY

inherit
	SYSTEM_VALUETYPE



feature {NONE} -- Initialization

	frozen make_dictionary_entry (key2: ANY; value2: ANY) is
		external
			"IL creator signature (System.Object, System.Object) use System.Collections.DictionaryEntry"
		end

feature -- Access

	frozen get_key: ANY is
		external
			"IL signature (): System.Object use System.Collections.DictionaryEntry"
		alias
			"get_Key"
		end

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.Collections.DictionaryEntry"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value2: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.DictionaryEntry"
		alias
			"set_Value"
		end

	frozen set_key (value2: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.DictionaryEntry"
		alias
			"set_Key"
		end

end -- class SYSTEM_COLLECTIONS_DICTIONARYENTRY
