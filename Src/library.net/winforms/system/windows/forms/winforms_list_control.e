indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ListControl"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_LIST_CONTROL

inherit
	WINFORMS_CONTROL
		redefine
			on_binding_context_changed,
			is_input_key
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW

feature -- Access

	get_selected_index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Windows.Forms.ListControl"
		alias
			"get_SelectedIndex"
		end

	frozen get_data_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListControl"
		alias
			"get_DataSource"
		end

	frozen get_value_member: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListControl"
		alias
			"get_ValueMember"
		end

	frozen get_display_member: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListControl"
		alias
			"get_DisplayMember"
		end

	frozen get_selected_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListControl"
		alias
			"get_SelectedValue"
		end

feature -- Element Change

	frozen add_data_source_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"add_DataSourceChanged"
		end

	frozen set_display_member (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ListControl"
		alias
			"set_DisplayMember"
		end

	frozen remove_value_member_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"remove_ValueMemberChanged"
		end

	frozen add_value_member_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"add_ValueMemberChanged"
		end

	frozen set_value_member (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ListControl"
		alias
			"set_ValueMember"
		end

	frozen remove_data_source_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"remove_DataSourceChanged"
		end

	set_selected_index (value: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Windows.Forms.ListControl"
		alias
			"set_SelectedIndex"
		end

	frozen remove_display_member_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"remove_DisplayMemberChanged"
		end

	frozen set_selected_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListControl"
		alias
			"set_SelectedValue"
		end

	frozen add_selected_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"add_SelectedValueChanged"
		end

	frozen set_data_source (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListControl"
		alias
			"set_DataSource"
		end

	frozen add_display_member_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"add_DisplayMemberChanged"
		end

	frozen remove_selected_value_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"remove_SelectedValueChanged"
		end

feature -- Basic Operations

	frozen get_item_text (item: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.ListControl"
		alias
			"GetItemText"
		end

feature {NONE} -- Implementation

	frozen filter_item_on_property_object_string (item: SYSTEM_OBJECT; field: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.Object, System.String): System.Object use System.Windows.Forms.ListControl"
		alias
			"FilterItemOnProperty"
		end

	set_items_core (items: ILIST) is
		external
			"IL deferred signature (System.Collections.IList): System.Void use System.Windows.Forms.ListControl"
		alias
			"SetItemsCore"
		end

	on_data_source_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnDataSourceChanged"
		end

	on_binding_context_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnBindingContextChanged"
		end

	frozen get_data_manager: WINFORMS_CURRENCY_MANAGER is
		external
			"IL signature (): System.Windows.Forms.CurrencyManager use System.Windows.Forms.ListControl"
		alias
			"get_DataManager"
		end

	set_item_core (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListControl"
		alias
			"SetItemCore"
		end

	on_selected_index_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnSelectedIndexChanged"
		end

	is_input_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.ListControl"
		alias
			"IsInputKey"
		end

	on_display_member_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnDisplayMemberChanged"
		end

	refresh_item (index: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Windows.Forms.ListControl"
		alias
			"RefreshItem"
		end

	frozen filter_item_on_property (item: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL signature (System.Object): System.Object use System.Windows.Forms.ListControl"
		alias
			"FilterItemOnProperty"
		end

	on_selected_value_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnSelectedValueChanged"
		end

	on_value_member_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnValueMemberChanged"
		end

end -- class WINFORMS_LIST_CONTROL
