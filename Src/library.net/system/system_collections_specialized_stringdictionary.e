indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Specialized.StringDictionary"

external class
	SYSTEM_COLLECTIONS_SPECIALIZED_STRINGDICTIONARY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

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

	get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
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

	get_item (key: STRING): STRING is
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

	get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Collections.Specialized.StringDictionary"
		alias
			"get_Keys"
		end

feature -- Element Change

	set_item (key: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Collections.Specialized.StringDictionary"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Collections.Specialized.StringDictionary"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Collections.Specialized.StringDictionary"
		alias
			"Equals"
		end

	add (key: STRING; value: STRING) is
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

	get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Collections.Specialized.StringDictionary"
		alias
			"GetEnumerator"
		end

	remove (key: STRING) is
		external
			"IL signature (System.String): System.Void use System.Collections.Specialized.StringDictionary"
		alias
			"Remove"
		end

	contains_value (value: STRING): BOOLEAN is
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

	contains_key (key: STRING): BOOLEAN is
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

end -- class SYSTEM_COLLECTIONS_SPECIALIZED_STRINGDICTIONARY
