indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Binding"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_BINDING

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (property_name: SYSTEM_STRING; data_source: SYSTEM_OBJECT; data_member: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.Object, System.String) use System.Windows.Forms.Binding"
		end

feature -- Access

	frozen get_binding_manager_base: WINFORMS_BINDING_MANAGER_BASE is
		external
			"IL signature (): System.Windows.Forms.BindingManagerBase use System.Windows.Forms.Binding"
		alias
			"get_BindingManagerBase"
		end

	frozen get_control: WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.Binding"
		alias
			"get_Control"
		end

	frozen get_data_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.Binding"
		alias
			"get_DataSource"
		end

	frozen get_property_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Binding"
		alias
			"get_PropertyName"
		end

	frozen get_binding_member_info: WINFORMS_BINDING_MEMBER_INFO is
		external
			"IL signature (): System.Windows.Forms.BindingMemberInfo use System.Windows.Forms.Binding"
		alias
			"get_BindingMemberInfo"
		end

	frozen get_is_binding: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Binding"
		alias
			"get_IsBinding"
		end

feature -- Element Change

	frozen remove_format (value: WINFORMS_CONVERT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ConvertEventHandler): System.Void use System.Windows.Forms.Binding"
		alias
			"remove_Format"
		end

	frozen add_format (value: WINFORMS_CONVERT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ConvertEventHandler): System.Void use System.Windows.Forms.Binding"
		alias
			"add_Format"
		end

	frozen add_parse (value: WINFORMS_CONVERT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ConvertEventHandler): System.Void use System.Windows.Forms.Binding"
		alias
			"add_Parse"
		end

	frozen remove_parse (value: WINFORMS_CONVERT_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ConvertEventHandler): System.Void use System.Windows.Forms.Binding"
		alias
			"remove_Parse"
		end

feature {NONE} -- Implementation

	on_parse (cevent: WINFORMS_CONVERT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.ConvertEventArgs): System.Void use System.Windows.Forms.Binding"
		alias
			"OnParse"
		end

	on_format (cevent: WINFORMS_CONVERT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.ConvertEventArgs): System.Void use System.Windows.Forms.Binding"
		alias
			"OnFormat"
		end

end -- class WINFORMS_BINDING
