indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.BindingsCollection"

external class
	SYSTEM_WINDOWS_FORMS_BINDINGSCOLLECTION

inherit
	SYSTEM_WINDOWS_FORMS_BASECOLLECTION
		redefine
			get_list
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_WINDOWS_FORMS_BINDING is
		external
			"IL signature (System.Int32): System.Windows.Forms.Binding use System.Windows.Forms.BindingsCollection"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen remove_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"remove_CollectionChanged"
		end

	frozen add_collection_changed (value: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTHANDLER) is
		external
			"IL signature (System.ComponentModel.CollectionChangeEventHandler): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"add_CollectionChanged"
		end

feature {NONE} -- Implementation

	frozen remove (binding: SYSTEM_WINDOWS_FORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"Remove"
		end

	add_core (data_binding: SYSTEM_WINDOWS_FORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.BindingsCollection"
		alias
			"AddCore"
		end

	get_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Windows.Forms.BindingsCollection"
		alias
			"get_List"
		end

	on_collection_changed (ccevent: SYSTEM_COMPONENTMODEL_COLLECTIONCHANGEEVENTARGS) is
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

	frozen add (binding: SYSTEM_WINDOWS_FORMS_BINDING) is
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

	remove_core (data_binding: SYSTEM_WINDOWS_FORMS_BINDING) is
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

end -- class SYSTEM_WINDOWS_FORMS_BINDINGSCOLLECTION
