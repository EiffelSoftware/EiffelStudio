indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.AttributeCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_ATTRIBUTE_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make

feature {NONE} -- Initialization

	frozen make (attributes: NATIVE_ARRAY [ATTRIBUTE]) is
		external
			"IL creator signature (System.Attribute[]) use System.ComponentModel.AttributeCollection"
		end

feature -- Access

	frozen empty: SYSTEM_DLL_ATTRIBUTE_COLLECTION is
		external
			"IL static_field signature :System.ComponentModel.AttributeCollection use System.ComponentModel.AttributeCollection"
		alias
			"Empty"
		end

	get_item (index: INTEGER): ATTRIBUTE is
		external
			"IL signature (System.Int32): System.Attribute use System.ComponentModel.AttributeCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.AttributeCollection"
		alias
			"get_Count"
		end

	get_item_type (attribute_type: TYPE): ATTRIBUTE is
		external
			"IL signature (System.Type): System.Attribute use System.ComponentModel.AttributeCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.AttributeCollection"
		alias
			"ToString"
		end

	frozen contains_array_attribute (attributes: NATIVE_ARRAY [ATTRIBUTE]): BOOLEAN is
		external
			"IL signature (System.Attribute[]): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"Contains"
		end

	frozen matches_array_attribute (attributes: NATIVE_ARRAY [ATTRIBUTE]): BOOLEAN is
		external
			"IL signature (System.Attribute[]): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"Matches"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.ComponentModel.AttributeCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.AttributeCollection"
		alias
			"GetEnumerator"
		end

	frozen contains (attribute: ATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Attribute): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"Contains"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"Equals"
		end

	frozen matches (attribute: ATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Attribute): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"Matches"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.AttributeCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen get_default_attribute (attribute_type: TYPE): ATTRIBUTE is
		external
			"IL signature (System.Type): System.Attribute use System.ComponentModel.AttributeCollection"
		alias
			"GetDefaultAttribute"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.AttributeCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.AttributeCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.AttributeCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.AttributeCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_DLL_ATTRIBUTE_COLLECTION
