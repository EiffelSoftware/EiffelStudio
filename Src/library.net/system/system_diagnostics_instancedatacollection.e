indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.InstanceDataCollection"

external class
	SYSTEM_DIAGNOSTICS_INSTANCEDATACOLLECTION

inherit
	SYSTEM_COLLECTIONS_DICTIONARYBASE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_IDICTIONARY
		rename
			get_enumerator as ienumerable_get_enumerator,
			remove as idictionary_remove,
			extend as idictionary_extend,
			has as idictionary_has,
			put_i_th as idictionary_put_i_th,
			get_item as idictionary_get_item,
			get_values as idictionary_get_values,
			get_sync_root as icollection_get_sync_root,
			get_keys as idictionary_get_keys,
			get_is_synchronized as icollection_get_is_synchronized,
			get_is_fixed_size as idictionary_get_is_fixed_size,
			get_is_read_only as idictionary_get_is_read_only
		end

create
	make_instancedatacollection

feature {NONE} -- Initialization

	frozen make_instancedatacollection (counter_name: STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.InstanceDataCollection"
		end

feature -- Access

	frozen get_counter_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.InstanceDataCollection"
		alias
			"get_CounterName"
		end

	frozen get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Diagnostics.InstanceDataCollection"
		alias
			"get_Keys"
		end

	frozen get_values: SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Diagnostics.InstanceDataCollection"
		alias
			"get_Values"
		end

	frozen get_item (instance_name: STRING): SYSTEM_DIAGNOSTICS_INSTANCEDATA is
		external
			"IL signature (System.String): System.Diagnostics.InstanceData use System.Diagnostics.InstanceDataCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen copy_to_array_instance_data (instances: ARRAY [SYSTEM_DIAGNOSTICS_INSTANCEDATA]; index: INTEGER) is
		external
			"IL signature (System.Diagnostics.InstanceData[], System.Int32): System.Void use System.Diagnostics.InstanceDataCollection"
		alias
			"CopyTo"
		end

	frozen has (instance_name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Diagnostics.InstanceDataCollection"
		alias
			"Contains"
		end

end -- class SYSTEM_DIAGNOSTICS_INSTANCEDATACOLLECTION
