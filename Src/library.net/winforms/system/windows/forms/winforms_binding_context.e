indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.BindingContext"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_BINDING_CONTEXT

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
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_enumerator as system_collections_ienumerable_get_enumerator,
			copy_to as system_collections_icollection_copy_to,
			get_count as system_collections_icollection_get_count
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Windows.Forms.BindingContext"
		end

feature -- Access

	frozen get_item_object_string (data_source: SYSTEM_OBJECT; data_member: SYSTEM_STRING): WINFORMS_BINDING_MANAGER_BASE is
		external
			"IL signature (System.Object, System.String): System.Windows.Forms.BindingManagerBase use System.Windows.Forms.BindingContext"
		alias
			"get_Item"
		end

	frozen get_item (data_source: SYSTEM_OBJECT): WINFORMS_BINDING_MANAGER_BASE is
		external
			"IL signature (System.Object): System.Windows.Forms.BindingManagerBase use System.Windows.Forms.BindingContext"
		alias
			"get_Item"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.BindingContext"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.BindingContext"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.BindingContext"
		alias
			"add_CollectionChanged"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.BindingContext"
		alias
			"GetHashCode"
		end

	frozen contains_object_string (data_source: SYSTEM_OBJECT; data_member: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.Object, System.String): System.Boolean use System.Windows.Forms.BindingContext"
		alias
			"Contains"
		end

	frozen contains (data_source: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.BindingContext"
		alias
			"Contains"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.BindingContext"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.BindingContext"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen add (data_source: SYSTEM_OBJECT; list_manager: WINFORMS_BINDING_MANAGER_BASE) is
		external
			"IL signature (System.Object, System.Windows.Forms.BindingManagerBase): System.Void use System.Windows.Forms.BindingContext"
		alias
			"Add"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.BindingContext"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_icollection_copy_to (ar: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.BindingContext"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	add_core (data_source: SYSTEM_OBJECT; list_manager: WINFORMS_BINDING_MANAGER_BASE) is
		external
			"IL signature (System.Object, System.Windows.Forms.BindingManagerBase): System.Void use System.Windows.Forms.BindingContext"
		alias
			"AddCore"
		end

	on_collection_changed (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Windows.Forms.BindingContext"
		alias
			"OnCollectionChanged"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.BindingContext"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.BindingContext"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.BindingContext"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.BindingContext"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.BindingContext"
		alias
			"Clear"
		end

	clear_core is
		external
			"IL signature (): System.Void use System.Windows.Forms.BindingContext"
		alias
			"ClearCore"
		end

	remove_core (data_source: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.BindingContext"
		alias
			"RemoveCore"
		end

	frozen remove (data_source: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.BindingContext"
		alias
			"Remove"
		end

end -- class WINFORMS_BINDING_CONTEXT
