indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.TemplateControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_TEMPLATE_CONTROL

inherit
	WEB_CONTROL
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

feature -- Element Change

	frozen remove_error (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.TemplateControl"
		alias
			"remove_Error"
		end

	frozen remove_commit_transaction (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.TemplateControl"
		alias
			"remove_CommitTransaction"
		end

	frozen add_error (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.TemplateControl"
		alias
			"add_Error"
		end

	frozen remove_abort_transaction (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.TemplateControl"
		alias
			"remove_AbortTransaction"
		end

	frozen add_abort_transaction (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.TemplateControl"
		alias
			"add_AbortTransaction"
		end

	frozen add_commit_transaction (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.TemplateControl"
		alias
			"add_CommitTransaction"
		end

feature -- Basic Operations

	frozen load_template (virtual_path: SYSTEM_STRING): WEB_ITEMPLATE is
		external
			"IL signature (System.String): System.Web.UI.ITemplate use System.Web.UI.TemplateControl"
		alias
			"LoadTemplate"
		end

	frozen read_string_resource (t: TYPE): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type): System.Object use System.Web.UI.TemplateControl"
		alias
			"ReadStringResource"
		end

	frozen load_control (virtual_path: SYSTEM_STRING): WEB_CONTROL is
		external
			"IL signature (System.String): System.Web.UI.Control use System.Web.UI.TemplateControl"
		alias
			"LoadControl"
		end

	frozen parse_control (content: SYSTEM_STRING): WEB_CONTROL is
		external
			"IL signature (System.String): System.Web.UI.Control use System.Web.UI.TemplateControl"
		alias
			"ParseControl"
		end

feature {NONE} -- Implementation

	construct is
		external
			"IL signature (): System.Void use System.Web.UI.TemplateControl"
		alias
			"Construct"
		end

	get_support_auto_events: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.TemplateControl"
		alias
			"get_SupportAutoEvents"
		end

	on_abort_transaction (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.TemplateControl"
		alias
			"OnAbortTransaction"
		end

	frozen write_utf8_resource_string (output: WEB_HTML_TEXT_WRITER; offset: INTEGER; size: INTEGER; f_ascii_only: BOOLEAN) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Int32, System.Int32, System.Boolean): System.Void use System.Web.UI.TemplateControl"
		alias
			"WriteUTF8ResourceString"
		end

	on_error (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.TemplateControl"
		alias
			"OnError"
		end

	frozen create_resource_based_literal_control (offset: INTEGER; size: INTEGER; f_ascii_only: BOOLEAN): WEB_LITERAL_CONTROL is
		external
			"IL signature (System.Int32, System.Int32, System.Boolean): System.Web.UI.LiteralControl use System.Web.UI.TemplateControl"
		alias
			"CreateResourceBasedLiteralControl"
		end

	get_auto_handlers: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.TemplateControl"
		alias
			"get_AutoHandlers"
		end

	set_auto_handlers (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.TemplateControl"
		alias
			"set_AutoHandlers"
		end

	frozen set_string_resource_pointer (string_resource_pointer: SYSTEM_OBJECT; max_resource_offset: INTEGER) is
		external
			"IL signature (System.Object, System.Int32): System.Void use System.Web.UI.TemplateControl"
		alias
			"SetStringResourcePointer"
		end

	framework_initialize is
		external
			"IL signature (): System.Void use System.Web.UI.TemplateControl"
		alias
			"FrameworkInitialize"
		end

	on_commit_transaction (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.TemplateControl"
		alias
			"OnCommitTransaction"
		end

end -- class WEB_TEMPLATE_CONTROL
