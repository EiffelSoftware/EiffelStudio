indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Design.PropertyTab"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_PROPERTY_TAB

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_IEXTENDER_PROVIDER

feature -- Access

	get_components: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Windows.Forms.Design.PropertyTab"
		alias
			"get_Components"
		end

	get_tab_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Windows.Forms.Design.PropertyTab"
		alias
			"get_TabName"
		end

	get_help_keyword: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Design.PropertyTab"
		alias
			"get_HelpKeyword"
		end

	get_bitmap: DRAWING_BITMAP is
		external
			"IL signature (): System.Drawing.Bitmap use System.Windows.Forms.Design.PropertyTab"
		alias
			"get_Bitmap"
		end

feature -- Element Change

	set_components (value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use System.Windows.Forms.Design.PropertyTab"
		alias
			"set_Components"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Design.PropertyTab"
		alias
			"ToString"
		end

	get_default_property (component: SYSTEM_OBJECT): SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL signature (System.Object): System.ComponentModel.PropertyDescriptor use System.Windows.Forms.Design.PropertyTab"
		alias
			"GetDefaultProperty"
		end

	get_properties_object_array_attribute (component: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.Design.PropertyTab"
		alias
			"GetProperties"
		end

	get_properties_itype_descriptor_context (context: SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT; component: SYSTEM_OBJECT; attributes: NATIVE_ARRAY [ATTRIBUTE]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.ITypeDescriptorContext, System.Object, System.Attribute[]): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.Design.PropertyTab"
		alias
			"GetProperties"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

	can_extend (extendee: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Design.PropertyTab"
		alias
			"CanExtend"
		end

	get_properties (component: SYSTEM_OBJECT): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
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

end -- class WINFORMS_PROPERTY_TAB
