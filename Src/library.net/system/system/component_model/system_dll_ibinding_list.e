indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.IBindingList"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IBINDING_LIST

inherit
	ILIST
	ICOLLECTION
	IENUMERABLE

feature -- Access

	get_supports_change_notification: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.IBindingList"
		alias
			"get_SupportsChangeNotification"
		end

	get_allow_new: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.IBindingList"
		alias
			"get_AllowNew"
		end

	get_sort_property: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptor use System.ComponentModel.IBindingList"
		alias
			"get_SortProperty"
		end

	get_allow_edit: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.IBindingList"
		alias
			"get_AllowEdit"
		end

	get_allow_remove: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.IBindingList"
		alias
			"get_AllowRemove"
		end

	get_sort_direction: SYSTEM_DLL_LIST_SORT_DIRECTION is
		external
			"IL deferred signature (): System.ComponentModel.ListSortDirection use System.ComponentModel.IBindingList"
		alias
			"get_SortDirection"
		end

	get_supports_searching: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.IBindingList"
		alias
			"get_SupportsSearching"
		end

	get_is_sorted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.IBindingList"
		alias
			"get_IsSorted"
		end

	get_supports_sorting: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.IBindingList"
		alias
			"get_SupportsSorting"
		end

feature -- Element Change

	add_list_changed (value: SYSTEM_DLL_LIST_CHANGED_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.ListChangedEventHandler): System.Void use System.ComponentModel.IBindingList"
		alias
			"add_ListChanged"
		end

	remove_list_changed (value: SYSTEM_DLL_LIST_CHANGED_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.ListChangedEventHandler): System.Void use System.ComponentModel.IBindingList"
		alias
			"remove_ListChanged"
		end

feature -- Basic Operations

	apply_sort (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR; direction: SYSTEM_DLL_LIST_SORT_DIRECTION) is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor, System.ComponentModel.ListSortDirection): System.Void use System.ComponentModel.IBindingList"
		alias
			"ApplySort"
		end

	add_index (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor): System.Void use System.ComponentModel.IBindingList"
		alias
			"AddIndex"
		end

	add_new: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.ComponentModel.IBindingList"
		alias
			"AddNew"
		end

	find (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR; key: SYSTEM_OBJECT): INTEGER is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor, System.Object): System.Int32 use System.ComponentModel.IBindingList"
		alias
			"Find"
		end

	remove_index (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor): System.Void use System.ComponentModel.IBindingList"
		alias
			"RemoveIndex"
		end

	remove_sort is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.IBindingList"
		alias
			"RemoveSort"
		end

end -- class SYSTEM_DLL_IBINDING_LIST
