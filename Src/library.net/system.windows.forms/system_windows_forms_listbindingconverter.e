indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListBindingConverter"

external class
	SYSTEM_WINDOWS_FORMS_LISTBINDINGCONVERTER

inherit
	SYSTEM_COMPONENTMODEL_TYPECONVERTER
		redefine
			get_create_instance_supported_itype_descriptor_context,
			create_instance_itype_descriptor_context,
			convert_to_itype_descriptor_context,
			can_convert_to_itype_descriptor_context
		end

create
	make_listbindingconverter

feature {NONE} -- Initialization

	frozen make_listbindingconverter is
		external
			"IL creator use System.Windows.Forms.ListBindingConverter"
		end

feature -- Basic Operations

	convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; culture: SYSTEM_GLOBALIZATION_CULTUREINFO; value: ANY; destination_type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Globalization.CultureInfo, System.Object, System.Type): System.Object use System.Windows.Forms.ListBindingConverter"
		alias
			"ConvertTo"
		end

	create_instance_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; property_values: SYSTEM_COLLECTIONS_IDICTIONARY): ANY is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Collections.IDictionary): System.Object use System.Windows.Forms.ListBindingConverter"
		alias
			"CreateInstance"
		end

	get_create_instance_supported_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext): System.Boolean use System.Windows.Forms.ListBindingConverter"
		alias
			"GetCreateInstanceSupported"
		end

	can_convert_to_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; destination_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Type): System.Boolean use System.Windows.Forms.ListBindingConverter"
		alias
			"CanConvertTo"
		end

end -- class SYSTEM_WINDOWS_FORMS_LISTBINDINGCONVERTER
