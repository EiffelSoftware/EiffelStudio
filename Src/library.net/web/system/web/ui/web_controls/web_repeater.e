indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.Repeater"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_REPEATER

inherit
	WEB_CONTROL
		redefine
			create_child_controls,
			get_controls,
			on_bubble_event,
			data_bind,
			on_data_binding
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	WEB_IDATA_BINDINGS_ACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	WEB_INAMING_CONTAINER

create
	make_web_repeater

feature {NONE} -- Initialization

	frozen make_web_repeater is
		external
			"IL creator use System.Web.UI.WebControls.Repeater"
		end

feature -- Access

	get_controls: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.Repeater"
		alias
			"get_Controls"
		end

	get_data_member: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Repeater"
		alias
			"get_DataMember"
		end

	get_data_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.Repeater"
		alias
			"get_DataSource"
		end

	get_header_template: WEB_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.Repeater"
		alias
			"get_HeaderTemplate"
		end

	get_separator_template: WEB_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.Repeater"
		alias
			"get_SeparatorTemplate"
		end

	get_items: WEB_REPEATER_ITEM_COLLECTION is
		external
			"IL signature (): System.Web.UI.WebControls.RepeaterItemCollection use System.Web.UI.WebControls.Repeater"
		alias
			"get_Items"
		end

	get_footer_template: WEB_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.Repeater"
		alias
			"get_FooterTemplate"
		end

	get_item_template: WEB_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.Repeater"
		alias
			"get_ItemTemplate"
		end

	get_alternating_item_template: WEB_ITEMPLATE is
		external
			"IL signature (): System.Web.UI.ITemplate use System.Web.UI.WebControls.Repeater"
		alias
			"get_AlternatingItemTemplate"
		end

feature -- Element Change

	frozen remove_item_command (value: WEB_REPEATER_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterCommandEventHandler): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"remove_ItemCommand"
		end

	set_item_template (value: WEB_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"set_ItemTemplate"
		end

	set_alternating_item_template (value: WEB_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"set_AlternatingItemTemplate"
		end

	frozen add_item_data_bound (value: WEB_REPEATER_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterItemEventHandler): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"add_ItemDataBound"
		end

	frozen add_item_created (value: WEB_REPEATER_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterItemEventHandler): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"add_ItemCreated"
		end

	set_footer_template (value: WEB_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"set_FooterTemplate"
		end

	set_header_template (value: WEB_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"set_HeaderTemplate"
		end

	frozen remove_item_data_bound (value: WEB_REPEATER_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterItemEventHandler): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"remove_ItemDataBound"
		end

	set_data_source (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"set_DataSource"
		end

	frozen remove_item_created (value: WEB_REPEATER_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterItemEventHandler): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"remove_ItemCreated"
		end

	set_data_member (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"set_DataMember"
		end

	frozen add_item_command (value: WEB_REPEATER_COMMAND_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterCommandEventHandler): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"add_ItemCommand"
		end

	set_separator_template (value: WEB_ITEMPLATE) is
		external
			"IL signature (System.Web.UI.ITemplate): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"set_SeparatorTemplate"
		end

feature -- Basic Operations

	data_bind is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"DataBind"
		end

feature {NONE} -- Implementation

	on_item_command (e: WEB_REPEATER_COMMAND_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterCommandEventArgs): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"OnItemCommand"
		end

	on_data_binding (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"OnDataBinding"
		end

	create_item (item_index: INTEGER; item_type: WEB_LIST_ITEM_TYPE): WEB_REPEATER_ITEM is
		external
			"IL signature (System.Int32, System.Web.UI.WebControls.ListItemType): System.Web.UI.WebControls.RepeaterItem use System.Web.UI.WebControls.Repeater"
		alias
			"CreateItem"
		end

	on_item_data_bound (e: WEB_REPEATER_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterItemEventArgs): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"OnItemDataBound"
		end

	on_bubble_event (sender: SYSTEM_OBJECT; e: EVENT_ARGS): BOOLEAN is
		external
			"IL signature (System.Object, System.EventArgs): System.Boolean use System.Web.UI.WebControls.Repeater"
		alias
			"OnBubbleEvent"
		end

	initialize_item (item: WEB_REPEATER_ITEM) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterItem): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"InitializeItem"
		end

	on_item_created (e: WEB_REPEATER_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.RepeaterItemEventArgs): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"OnItemCreated"
		end

	create_control_hierarchy (use_data_source: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"CreateControlHierarchy"
		end

	create_child_controls is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.Repeater"
		alias
			"CreateChildControls"
		end

end -- class WEB_REPEATER
