indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PropertyGridInternal.PropertiesTab"

external class
	SYSTEM_WINDOWS_FORMS_PROPERTYGRIDINTERNAL_PROPERTIESTAB

inherit
	SYSTEM_WINDOWS_FORMS_DESIGN_PROPERTYTAB
		redefine
			get_properties_itype_descriptor_context,
			get_default_property,
			get_help_keyword
		end
	SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER

create
	make_propertiestab

feature {NONE} -- Initialization

	frozen make_propertiestab is
		external
			"IL creator use System.Windows.Forms.PropertyGridInternal.PropertiesTab"
		end

feature -- Access

	get_tab_name: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PropertyGridInternal.PropertiesTab"
		alias
			"get_TabName"
		end

	get_help_keyword: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.PropertyGridInternal.PropertiesTab"
		alias
			"get_HelpKeyword"
		end

feature -- Basic Operations

	get_properties_object_array_attribute (component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.PropertyGridInternal.PropertiesTab"
		alias
			"GetProperties"
		end

	get_default_property (obj: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptor use System.Windows.Forms.PropertyGridInternal.PropertiesTab"
		alias
			"GetDefaultProperty"
		end

	get_properties_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.PropertyGridInternal.PropertiesTab"
		alias
			"GetProperties"
		end

end -- class SYSTEM_WINDOWS_FORMS_PROPERTYGRIDINTERNAL_PROPERTIESTAB
