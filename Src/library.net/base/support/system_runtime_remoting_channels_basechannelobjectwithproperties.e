indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"

deferred external class
	SYSTEM_RUNTIME_REMOTING_CHANNELS_BASECHANNELOBJECTWITHPROPERTIES

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end

feature -- Access

	get_item (key: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_Item"
		end

	get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_Values"
		end

	get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_Keys"
		end

	get_sync_root: ANY is
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

	get_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"get_Properties"
		end

feature -- Element Change

	put_i_th (key: ANY; value: ANY) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"Equals"
		end

	get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
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

	remove (key: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"Remove"
		end

	has (key: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"Contains"
		end

	extend (key: ANY; value: ANY) is
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

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Runtime.Remoting.Channels.BaseChannelObjectWithProperties"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_RUNTIME_REMOTING_CHANNELS_BASECHANNELOBJECTWITHPROPERTIES
