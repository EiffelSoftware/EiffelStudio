indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.CounterCreationDataCollection"

external class
	SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATACOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
		rename
			insert as ilist_insert,
			index_of as ilist_index_of,
			remove as ilist_remove,
			extend as ilist_extend,
			has as ilist_has,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_COLLECTIONBASE
		redefine
			on_insert
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end

create
	make_countercreationdatacollection,
	make_countercreationdatacollection_2,
	make_countercreationdatacollection_1

feature {NONE} -- Initialization

	frozen make_countercreationdatacollection is
		external
			"IL creator use System.Diagnostics.CounterCreationDataCollection"
		end

	frozen make_countercreationdatacollection_2 (value: ARRAY [SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA]) is
		external
			"IL creator signature (System.Diagnostics.CounterCreationData[]) use System.Diagnostics.CounterCreationDataCollection"
		end

	frozen make_countercreationdatacollection_1 (value: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATACOLLECTION) is
		external
			"IL creator signature (System.Diagnostics.CounterCreationDataCollection) use System.Diagnostics.CounterCreationDataCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA is
		external
			"IL signature (System.Int32): System.Diagnostics.CounterCreationData use System.Diagnostics.CounterCreationDataCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen put_i_th (index: INTEGER; value: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA) is
		external
			"IL signature (System.Int32, System.Diagnostics.CounterCreationData): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range_array_counter_creation_data (value: ARRAY [SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA]) is
		external
			"IL signature (System.Diagnostics.CounterCreationData[]): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"AddRange"
		end

	frozen insert (index: INTEGER; value: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA) is
		external
			"IL signature (System.Int32, System.Diagnostics.CounterCreationData): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.CounterCreationData[], System.Int32): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA): INTEGER is
		external
			"IL signature (System.Diagnostics.CounterCreationData): System.Int32 use System.Diagnostics.CounterCreationDataCollection"
		alias
			"IndexOf"
		end

	remove (value: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA) is
		external
			"IL signature (System.Diagnostics.CounterCreationData): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"Remove"
		end

	frozen has (value: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA): BOOLEAN is
		external
			"IL signature (System.Diagnostics.CounterCreationData): System.Boolean use System.Diagnostics.CounterCreationDataCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATACOLLECTION) is
		external
			"IL signature (System.Diagnostics.CounterCreationDataCollection): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"AddRange"
		end

	frozen extend (value: SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATA): INTEGER is
		external
			"IL signature (System.Diagnostics.CounterCreationData): System.Int32 use System.Diagnostics.CounterCreationDataCollection"
		alias
			"Add"
		end

feature {NONE} -- Implementation

	on_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Diagnostics.CounterCreationDataCollection"
		alias
			"OnInsert"
		end

end -- class SYSTEM_DIAGNOSTICS_COUNTERCREATIONDATACOLLECTION
