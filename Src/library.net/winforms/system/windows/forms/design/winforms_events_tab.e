indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Design.EventsTab"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_EVENTS_TAB

inherit
	WINFORMS_PROPERTY_TAB
		redefine
			can_extend,
			get_properties_itype_descriptor_context,
			get_default_property,
			get_help_keyword
		end
	SYSTEM_DLL_IEXTENDER_PROVIDER

create
	make_winforms_events_tab

feature {NONE} -- Initialization

	frozen make_winforms_events_tab (sp: ISERVICE_PROVIDER) is
		external
			"IL creator signature (System.IServiceProvider) use System.Windows.Forms.Design.EventsTab"
		end

feature -- Access

	get_tab_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Design.EventsTab"
		alias
			"get_TabName"
		end

	get_help_keyword: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Design.EventsTab"
		alias
			"get_HelpKeyword"
		end

feature -- Basic Operations

	can_extend (extendee: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Design.EventsTab"
		alias
			"CanExtend"
		end

	get_properties_object_array_attribute (component: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.Design.EventsTab"
		alias
			"GetProperties"
		end

	get_default_property (obj: SYSTEM_OBJECT): SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptor use System.Windows.Forms.Design.EventsTab"
		alias
			"GetDefaultProperty"
		end

	get_properties_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; component: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.Design.EventsTab"
		alias
			"GetProperties"
		end

end -- class WINFORMS_EVENTS_TAB
