indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Binding"

external class
	SYSTEM_WINDOWS_FORMS_BINDING

create
	make

feature {NONE} -- Initialization

	frozen make (property_name: STRING; data_source: ANY; data_member: STRING) is
		external
			"IL creator signature (System.String, System.Object, System.String) use System.Windows.Forms.Binding"
		end

feature -- Access

	frozen get_binding_manager_base: SYSTEM_WINDOWS_FORMS_BINDINGMANAGERBASE is
		external
			"IL signature (): System.Windows.Forms.BindingManagerBase use System.Windows.Forms.Binding"
		alias
			"get_BindingManagerBase"
		end

	frozen get_control: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.Binding"
		alias
			"get_Control"
		end

	frozen get_data_source: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.Binding"
		alias
			"get_DataSource"
		end

	frozen get_property_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Binding"
		alias
			"get_PropertyName"
		end

	frozen get_binding_member_info: SYSTEM_WINDOWS_FORMS_BINDINGMEMBERINFO is
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

	frozen remove_format (value: SYSTEM_WINDOWS_FORMS_CONVERTEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ConvertEventHandler): System.Void use System.Windows.Forms.Binding"
		alias
			"remove_Format"
		end

	frozen add_format (value: SYSTEM_WINDOWS_FORMS_CONVERTEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ConvertEventHandler): System.Void use System.Windows.Forms.Binding"
		alias
			"add_Format"
		end

	frozen add_parse (value: SYSTEM_WINDOWS_FORMS_CONVERTEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ConvertEventHandler): System.Void use System.Windows.Forms.Binding"
		alias
			"add_Parse"
		end

	frozen remove_parse (value: SYSTEM_WINDOWS_FORMS_CONVERTEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ConvertEventHandler): System.Void use System.Windows.Forms.Binding"
		alias
			"remove_Parse"
		end

feature {NONE} -- Implementation

	on_parse (cevent: SYSTEM_WINDOWS_FORMS_CONVERTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ConvertEventArgs): System.Void use System.Windows.Forms.Binding"
		alias
			"OnParse"
		end

	on_format (cevent: SYSTEM_WINDOWS_FORMS_CONVERTEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ConvertEventArgs): System.Void use System.Windows.Forms.Binding"
		alias
			"OnFormat"
		end

end -- class SYSTEM_WINDOWS_FORMS_BINDING
