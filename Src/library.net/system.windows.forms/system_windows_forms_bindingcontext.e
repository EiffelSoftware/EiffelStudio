indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.BindingContext"

external class
	SYSTEM_WINDOWS_FORMS_BINDINGCONTEXT

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
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_enumerator as system_collections_ienumerable_get_enumerator,
			copy_to as system_collections_icollection_copy_to,
			get_count as system_collections_icollection_get_count
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
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

	frozen get_item_object_string (data_source: ANY; data_member: STRING): SYSTEM_WINDOWS_FORMS_BINDINGMANAGERBASE is
		external
			"IL signature (System.Object, System.String): System.Windows.Forms.BindingManagerBase use System.Windows.Forms.BindingContext"
		alias
			"get_Item"
		end

	frozen get_item (data_source: ANY): SYSTEM_WINDOWS_FORMS_BINDINGMANAGERBASE is
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

	frozen remove_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.BindingContext"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
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

	frozen contains_object_string (data_source: ANY; data_member: STRING): BOOLEAN is
		external
			"IL signature (System.Object, System.String): System.Boolean use System.Windows.Forms.BindingContext"
		alias
			"Contains"
		end

	frozen contains (data_source: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.BindingContext"
		alias
			"Contains"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.BindingContext"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.BindingContext"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen add (data_source: ANY; list_manager: SYSTEM_WINDOWS_FORMS_BINDINGMANAGERBASE) is
		external
			"IL signature (System.Object, System.Windows.Forms.BindingManagerBase): System.Void use System.Windows.Forms.BindingContext"
		alias
			"Add"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
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

	add_core (data_source: ANY; list_manager: SYSTEM_WINDOWS_FORMS_BINDINGMANAGERBASE) is
		external
			"IL signature (System.Object, System.Windows.Forms.BindingManagerBase): System.Void use System.Windows.Forms.BindingContext"
		alias
			"AddCore"
		end

	on_collection_changed (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
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

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	remove_core (data_source: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.BindingContext"
		alias
			"RemoveCore"
		end

	frozen remove (data_source: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.BindingContext"
		alias
			"Remove"
		end

end -- class SYSTEM_WINDOWS_FORMS_BINDINGCONTEXT
