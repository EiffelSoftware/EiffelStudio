indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListControl"

deferred external class
	SYSTEM_WINDOWS_FORMS_LISTCONTROL

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_CONTROL
		redefine
			on_binding_context_changed,
			is_input_key
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

feature -- Access

	get_selected_index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Windows.Forms.ListControl"
		alias
			"get_SelectedIndex"
		end

	frozen get_data_source: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListControl"
		alias
			"get_DataSource"
		end

	frozen get_value_member: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListControl"
		alias
			"get_ValueMember"
		end

	frozen get_display_member: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListControl"
		alias
			"get_DisplayMember"
		end

	frozen get_selected_value: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListControl"
		alias
			"get_SelectedValue"
		end

feature -- Element Change

	frozen add_data_source_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"add_DataSourceChanged"
		end

	frozen set_display_member (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ListControl"
		alias
			"set_DisplayMember"
		end

	frozen remove_value_member_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"remove_ValueMemberChanged"
		end

	frozen add_value_member_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"add_ValueMemberChanged"
		end

	frozen set_value_member (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ListControl"
		alias
			"set_ValueMember"
		end

	frozen remove_data_source_changed (value: SYSTEM_EVENTHANDLER) is
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

	frozen remove_display_member_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"remove_DisplayMemberChanged"
		end

	frozen set_selected_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListControl"
		alias
			"set_SelectedValue"
		end

	frozen add_selected_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"add_SelectedValueChanged"
		end

	frozen set_data_source (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListControl"
		alias
			"set_DataSource"
		end

	frozen add_display_member_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"add_DisplayMemberChanged"
		end

	frozen remove_selected_value_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListControl"
		alias
			"remove_SelectedValueChanged"
		end

feature -- Basic Operations

	frozen get_item_text (item: ANY): STRING is
		external
			"IL signature (System.Object): System.String use System.Windows.Forms.ListControl"
		alias
			"GetItemText"
		end

feature {NONE} -- Implementation

	frozen filter_item_on_property_object_string (item: ANY; field: STRING): ANY is
		external
			"IL signature (System.Object, System.String): System.Object use System.Windows.Forms.ListControl"
		alias
			"FilterItemOnProperty"
		end

	set_items_core (items: ARRAY [ANY]) is
		external
			"IL deferred signature (System.Object[]): System.Void use System.Windows.Forms.ListControl"
		alias
			"SetItemsCore"
		end

	on_data_source_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnDataSourceChanged"
		end

	on_binding_context_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnBindingContextChanged"
		end

	frozen get_data_manager: SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER is
		external
			"IL signature (): System.Windows.Forms.CurrencyManager use System.Windows.Forms.ListControl"
		alias
			"get_DataManager"
		end

	set_item_core (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Windows.Forms.ListControl"
		alias
			"SetItemCore"
		end

	on_selected_index_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnSelectedIndexChanged"
		end

	is_input_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.ListControl"
		alias
			"IsInputKey"
		end

	on_display_member_changed (e: SYSTEM_EVENTARGS) is
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

	frozen filter_item_on_property (item: ANY): ANY is
		external
			"IL signature (System.Object): System.Object use System.Windows.Forms.ListControl"
		alias
			"FilterItemOnProperty"
		end

	on_selected_value_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnSelectedValueChanged"
		end

	on_value_member_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListControl"
		alias
			"OnValueMemberChanged"
		end

end -- class SYSTEM_WINDOWS_FORMS_LISTCONTROL
