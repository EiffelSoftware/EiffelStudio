indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.DictionaryEntry"

frozen expanded external class
	SYSTEM_COLLECTIONS_DICTIONARYENTRY

inherit
	VALUE_TYPE

feature -- Initialization

	frozen make_dictionaryentry (key: ANY; value: ANY) is
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

	frozen set_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.DictionaryEntry"
		alias
			"set_Value"
		end

	frozen set_key (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Collections.DictionaryEntry"
		alias
			"set_Key"
		end

end -- class SYSTEM_COLLECTIONS_DICTIONARYENTRY
