indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.IDictionaryEnumerator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IDICTIONARY_ENUMERATOR

inherit
	IENUMERATOR

feature -- Access

	get_entry: DICTIONARY_ENTRY is
		external
			"IL deferred signature (): System.Collections.DictionaryEntry use System.Collections.IDictionaryEnumerator"
		alias
			"get_Entry"
		end

	get_key: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Collections.IDictionaryEnumerator"
		alias
			"get_Key"
		end

	get_value: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Collections.IDictionaryEnumerator"
		alias
			"get_Value"
		end

end -- class IDICTIONARY_ENUMERATOR
