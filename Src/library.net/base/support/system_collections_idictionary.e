indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Collections.IDictionary"

deferred external class
	SYSTEM_COLLECTIONS_IDICTIONARY

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	get_is_read_only: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.IDictionary"
		alias
			"get_IsReadOnly"
		end

	get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL deferred signature (): System.Collections.ICollection use System.Collections.IDictionary"
		alias
			"get_Values"
		end

	get_is_fixed_size: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.IDictionary"
		alias
			"get_IsFixedSize"
		end

	get_item (key: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use System.Collections.IDictionary"
		alias
			"get_Item"
		end

	get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL deferred signature (): System.Collections.ICollection use System.Collections.IDictionary"
		alias
			"get_Keys"
		end

feature -- Element Change

	put_i_th (key: ANY; value: ANY) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.Collections.IDictionary"
		alias
			"set_Item"
		end

feature -- Basic Operations

	clear is
		external
			"IL deferred signature (): System.Void use System.Collections.IDictionary"
		alias
			"Clear"
		end

	get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL deferred signature (): System.Collections.IDictionaryEnumerator use System.Collections.IDictionary"
		alias
			"GetEnumerator"
		end

	extend (key: ANY; value: ANY) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.Collections.IDictionary"
		alias
			"Add"
		end

	has (key: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Collections.IDictionary"
		alias
			"Contains"
		end

	remove (key: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Collections.IDictionary"
		alias
			"Remove"
		end

end -- class SYSTEM_COLLECTIONS_IDICTIONARY
