indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Design.PropertyTab"

deferred external class
	SYSTEM_WINDOWS_FORMS_DESIGN_PROPERTYTAB

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER

feature -- Access

	get_components: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Windows.Forms.Design.PropertyTab"
		alias
			"get_Components"
		end

	get_tab_name: STRING is
		external
			"IL deferred signature (): System.String use System.Windows.Forms.Design.PropertyTab"
		alias
			"get_TabName"
		end

	get_help_keyword: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Design.PropertyTab"
		alias
			"get_HelpKeyword"
		end

	get_bitmap: SYSTEM_DRAWING_BITMAP is
		external
			"IL signature (): System.Drawing.Bitmap use System.Windows.Forms.Design.PropertyTab"
		alias
			"get_Bitmap"
		end

feature -- Element Change

	set_components (value: ARRAY [ANY]) is
		external
			"IL signature (System.Object[]): System.Void use System.Windows.Forms.Design.PropertyTab"
		alias
			"set_Components"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Design.PropertyTab"
		alias
			"ToString"
		end

	get_default_property (component: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptor use System.Windows.Forms.Design.PropertyTab"
		alias
			"GetDefaultProperty"
		end

	get_properties_object_array_attribute (component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.Design.PropertyTab"
		alias
			"GetProperties"
		end

	get_properties_itype_descriptor_context (context: SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT; component: ANY; attributes: ARRAY [SYSTEM_ATTRIBUTE]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.Design.PropertyTab"
		alias
			"GetProperties"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Design.PropertyTab"
		alias
			"Equals"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.PropertyTab"
		alias
			"Dispose"
		end

	can_extend (extendee: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Design.PropertyTab"
		alias
			"CanExtend"
		end

	get_properties (component: ANY): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.Design.PropertyTab"
		alias
			"GetProperties"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Design.PropertyTab"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Design.PropertyTab"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.Design.PropertyTab"
		alias
			"Finalize"
		end

end -- class SYSTEM_WINDOWS_FORMS_DESIGN_PROPERTYTAB
