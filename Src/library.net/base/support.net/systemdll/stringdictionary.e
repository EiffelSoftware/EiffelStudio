indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Collections.Specialized.StringDictionary"
	assembly: "System", "1.0.3200.0", "neutral", "b77a5c561934e089"

external class
	STRINGDICTIONARY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.Specialized.StringDictionary"
		end

feature -- Access

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Collections.Specialized.StringDictionary"
		alias
			"get_IsSynchronized"
		end

	get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Specialized.StringDictionary"
		alias
			"get_Values"
		end

	get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Collections.Specialized.StringDictionary"
		alias
			"get_SyncRoot"
		end

	get_item (key: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Collections.Specialized.StringDictionary"
		alias
			"get_Item"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.StringDictionary"
		alias
			"get_Count"
		end

	get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Specialized.StringDictionary"
		alias
			"get_Keys"
		end

feature -- Element Change

	set_item (key: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Collections.Specialized.StringDictionary"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.StringDictionary"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.StringDictionary"
		alias
			"Equals"
		end

	add (key: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Collections.Specialized.StringDictionary"
		alias
			"Add"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Collections.Specialized.StringDictionary"
		alias
			"GetHashCode"
		end

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Collections.Specialized.StringDictionary"
		alias
			"CopyTo"
		end

	get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.StringDictionary"
		alias
			"GetEnumerator"
		end

	remove (key: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Collections.Specialized.StringDictionary"
		alias
			"Remove"
		end

	contains_value (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Collections.Specialized.StringDictionary"
		alias
			"ContainsValue"
		end

	clear is
		external
			"IL signature (): System.Void use System.Collections.Specialized.StringDictionary"
		alias
			"Clear"
		end

	contains_key (key: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Collections.Specialized.StringDictionary"
		alias
			"ContainsKey"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Collections.Specialized.StringDictionary"
		alias
			"Finalize"
		end

end -- class STRINGDICTIONARY
