indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.AttributeCollection"

external class
	SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make

feature {NONE} -- Initialization

	frozen make (attributes: ARRAY [SYSTEM_ATTRIBUTE]) is
		external
			"IL creator signature (System.Attribute[]) use System.ComponentModel.AttributeCollection"
		end

feature -- Access

	frozen empty: SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
		external
			"IL static_field signature :System.ComponentModel.AttributeCollection use System.ComponentModel.AttributeCollection"
		alias
			"Empty"
		end

	get_item (index: INTEGER): SYSTEM_ATTRIBUTE is
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

	get_item_type (attribute_type: SYSTEM_TYPE): SYSTEM_ATTRIBUTE is
		external
			"IL signature (System.Type): System.Attribute use System.ComponentModel.AttributeCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.AttributeCollection"
		alias
			"ToString"
		end

	frozen contains_attribute (attribute: SYSTEM_ATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Attribute): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"Contains"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.ComponentModel.AttributeCollection"
		alias
			"CopyTo"
		end

	frozen matches_attribute (attribute: SYSTEM_ATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.Attribute): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"Matches"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.AttributeCollection"
		alias
			"GetEnumerator"
		end

	frozen contains (attributes: ARRAY [SYSTEM_ATTRIBUTE]): BOOLEAN is
		external
			"IL signature (System.Attribute[]): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"Contains"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.AttributeCollection"
		alias
			"Equals"
		end

	frozen matches (attributes: ARRAY [SYSTEM_ATTRIBUTE]): BOOLEAN is
		external
			"IL signature (System.Attribute[]): System.Boolean use System.ComponentModel.AttributeCollection"
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

	frozen get_default_attribute (attribute_type: SYSTEM_TYPE): SYSTEM_ATTRIBUTE is
		external
			"IL signature (System.Type): System.Attribute use System.ComponentModel.AttributeCollection"
		alias
			"GetDefaultAttribute"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
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

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.AttributeCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION
