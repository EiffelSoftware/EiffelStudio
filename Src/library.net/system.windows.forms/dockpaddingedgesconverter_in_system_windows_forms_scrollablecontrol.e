indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ScrollableControl+DockPaddingEdgesConverter"

external class
	DOCKPADDINGEDGESCONVERTER_IN_SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			get_properties_supported_itype_descriptor_context,
			get_properties_itype_descriptor_context_object_array_attribute
		end

create
	make_dockpaddingedgesconverter

feature {NONE} -- Initialization

	frozen make_dockpaddingedgesconverter is
		external
			"IL creator use System.Windows.Forms.ScrollableControl+DockPaddingEdgesConverter"
		end

feature -- Basic Operations

	get_properties_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.ScrollableControl+DockPaddingEdgesConverter"
		alias
			"GetPropertiesSupported"
		end

	get_properties_itype_descriptor_context_object_array_attribute (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; value: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.ScrollableControl+DockPaddingEdgesConverter"
		alias
			"GetProperties"
		end

end -- class DOCKPADDINGEDGESCONVERTER_IN_SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL
