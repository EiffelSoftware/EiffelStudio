indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	BASE_CHANNEL_OBJECT_WITH_PROPERTIES

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDICTIONARY
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

feature -- Access

	get_item (key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_Item"
		end

	get_values: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_Values"
		end

	get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_Keys"
		end

	get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_Count"
		end

	get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_IsFixedSize"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_IsReadOnly"
		end

	get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_IsSynchronized"
		end

	get_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_Properties"
		end

feature -- Element Change

	set_item (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"Equals"
		end

	get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"GetEnumerator"
		end

	copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"CopyTo"
		end

	remove (key: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"Remove"
		end

	contains (key: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"Contains"
		end

	add (key: SYSTEM_OBJECT; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"Add"
		end

	clear is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"Finalize"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class BASE_CHANNEL_OBJECT_WITH_PROPERTIES
