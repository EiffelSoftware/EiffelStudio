indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.BindingsCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_BINDINGS_COLLECTION

inherit
	WINFORMS_BASE_COLLECTION
		redefine
			get_count,
			get_list
		end
	ICOLLECTION
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): WINFORMS_BINDING is
		external
			"IL signature (System.Int32): System.Windows.Forms.Binding use System.Windows.Forms.BindingsCollection"
		alias
			"get_Item"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.BindingsCollection"
		alias
			"get_Count"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"add_CollectionChanged"
		end

feature {NONE} -- Implementation

	frozen remove (binding: WINFORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"Remove"
		end

	add_core (data_binding: WINFORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"AddCore"
		end

	get_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Windows.Forms.BindingsCollection"
		alias
			"get_List"
		end

	on_collection_changed (ccevent: SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventArgs): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"OnCollectionChanged"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"Clear"
		end

	frozen add (binding: WINFORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"Add"
		end

	frozen should_serialize_my_all: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.BindingsCollection"
		alias
			"ShouldSerializeMyAll"
		end

	clear_core is
		external
			"IL signature (): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"ClearCore"
		end

	remove_core (data_binding: WINFORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"RemoveCore"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"RemoveAt"
		end

end -- class WINFORMS_BINDINGS_COLLECTION
