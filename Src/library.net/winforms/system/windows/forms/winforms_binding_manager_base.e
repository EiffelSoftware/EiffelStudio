indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.BindingManagerBase"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_BINDING_MANAGER_BASE

inherit
	SYSTEM_OBJECT

feature -- Access

	get_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Windows.Forms.BindingManagerBase"
		alias
			"get_Count"
		end

	get_position: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Windows.Forms.BindingManagerBase"
		alias
			"get_Position"
		end

	get_current: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Windows.Forms.BindingManagerBase"
		alias
			"get_Current"
		end

	frozen get_bindings: WINFORMS_BINDINGS_COLLECTION is
		external
			"IL signature (): System.Windows.Forms.BindingsCollection use System.Windows.Forms.BindingManagerBase"
		alias
			"get_Bindings"
		end

feature -- Element Change

	frozen add_current_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"add_CurrentChanged"
		end

	frozen add_position_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"add_PositionChanged"
		end

	set_position (value: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"set_Position"
		end

	frozen remove_current_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"remove_CurrentChanged"
		end

	frozen remove_position_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"remove_PositionChanged"
		end

feature -- Basic Operations

	resume_binding is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"ResumeBinding"
		end

	add_new is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"AddNew"
		end

	end_current_edit is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"EndCurrentEdit"
		end

	suspend_binding is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"SuspendBinding"
		end

	remove_at (index: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"RemoveAt"
		end

	get_item_properties: SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.BindingManagerBase"
		alias
			"GetItemProperties"
		end

	cancel_current_edit is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"CancelCurrentEdit"
		end

feature {NONE} -- Implementation

	get_list_name (list_accessors: ARRAY_LIST): SYSTEM_STRING is
		external
			"IL deferred signature (System.Collections.ArrayList): System.String use System.Windows.Forms.BindingManagerBase"
		alias
			"GetListName"
		end

	get_item_properties_type (list_type: TYPE; offset: INTEGER; data_sources: ARRAY_LIST; list_accessors: ARRAY_LIST): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Type, System.Int32, System.Collections.ArrayList, System.Collections.ArrayList): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.BindingManagerBase"
		alias
			"GetItemProperties"
		end

	frozen push_data is
		external
			"IL signature (): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"PushData"
		end

	frozen pull_data is
		external
			"IL signature (): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"PullData"
		end

	on_current_changed (e: EVENT_ARGS) is
		external
			"IL deferred signature (System.EventArgs): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"OnCurrentChanged"
		end

	update_is_binding is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.BindingManagerBase"
		alias
			"UpdateIsBinding"
		end

	get_item_properties_array_list (data_sources: ARRAY_LIST; list_accessors: ARRAY_LIST): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Collections.ArrayList, System.Collections.ArrayList): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.BindingManagerBase"
		alias
			"GetItemProperties"
		end

end -- class WINFORMS_BINDING_MANAGER_BASE
