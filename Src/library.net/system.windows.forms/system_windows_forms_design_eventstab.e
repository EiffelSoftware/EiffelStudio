indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Design.EventsTab"

external class
	SYSTEM_WINDOWS_FORMS_DESIGN_EVENTSTAB

inherit
	SYSTEM_WINDOWS_FORMS_DESIGN_PROPERTYTAB
		redefine
			can_extend,
			get_properties_itype_descriptor_context,
			get_default_property,
			get_help_keyword
		end
	SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER

create
	make_eventstab

feature {NONE} -- Initialization

	frozen make_eventstab (sp: SYSTEM_ISERVICEPROVIDER) is
		external
			"IL creator signature (System.IServiceProvider) use System.Windows.Forms.Design.EventsTab"
		end

feature -- Access

	get_tab_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Design.EventsTab"
		alias
			"get_TabName"
		end

	get_help_keyword: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Design.EventsTab"
		alias
			"get_HelpKeyword"
		end

feature -- Basic Operations

	can_extend (extendee: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Design.EventsTab"
		alias
			"CanExtend"
		end

	get_properties_object_array_attribute (component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.Design.EventsTab"
		alias
			"GetProperties"
		end

	get_default_property (obj: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptor use System.Windows.Forms.Design.EventsTab"
		alias
			"GetDefaultProperty"
		end

	get_properties_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.Design.EventsTab"
		alias
			"GetProperties"
		end

end -- class SYSTEM_WINDOWS_FORMS_DESIGN_EVENTSTAB
