indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.IDictionaryEnumerator"

deferred external class
	SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR

inherit
	SYSTEM_COLLECTIONS_IENUMERATOR

feature -- Access

	get_entry: SYSTEM_COLLECTIONS_DICTIONARYENTRY is
		external
			"IL deferred signature (): System.Collections.DictionaryEntry use System.Collections.IDictionaryEnumerator"
		alias
			"get_Entry"
		end

	get_key: ANY is
		external
			"IL deferred signature (): System.Object use System.Collections.IDictionaryEnumerator"
		alias
			"get_Key"
		end

	get_value: ANY is
		external
			"IL deferred signature (): System.Object use System.Collections.IDictionaryEnumerator"
		alias
			"get_Value"
		end

end -- class SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR
