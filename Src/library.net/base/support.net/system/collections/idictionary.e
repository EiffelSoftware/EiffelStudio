indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.IDictionary"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IDICTIONARY

inherit
	ICOLLECTION
	IENUMERABLE

feature -- Access

	get_is_fixed_size: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.IDictionary"
		alias
			"get_IsFixedSize"
		end

	get_values: ICOLLECTION is
		external
			"IL deferred signature (): System.Collections.ICollection use System.Collections.IDictionary"
		alias
			"get_Values"
		end

	get_keys: ICOLLECTION is
		external
			"IL deferred signature (): System.Collections.ICollection use System.Collections.IDictionary"
		alias
			"get_Keys"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Collections.IDictionary"
		alias
			"get_IsReadOnly"
		end

	get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object): System.Object use System.Collections.IDictionary"
		alias
			"get_Item"
		end

feature -- Element Change

	set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.Collections.IDictionary"
		alias
			"set_Item"
		end

feature -- Basic Operations

	contains (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Collections.IDictionary"
		alias
			"Contains"
		end

	get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL deferred signature (): System.Collections.IDictionaryEnumerator use System.Collections.IDictionary"
		alias
			"GetEnumerator"
		end

	add (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.Collections.IDictionary"
		alias
			"Add"
		end

	clear is
		external
			"IL deferred signature (): System.Void use System.Collections.IDictionary"
		alias
			"Clear"
		end

	remove (key: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Collections.IDictionary"
		alias
			"Remove"
		end

end -- class IDICTIONARY
