indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.MemberDescriptor"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_MEMBER_DESCRIPTOR

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals
		end

feature -- Access

	get_description: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.MemberDescriptor"
		alias
			"get_Description"
		end

	get_attributes: SYSTEM_DLL_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.ComponentModel.AttributeCollection use System.ComponentModel.MemberDescriptor"
		alias
			"get_Attributes"
		end

	get_design_time_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.MemberDescriptor"
		alias
			"get_DesignTimeOnly"
		end

	get_is_browsable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.MemberDescriptor"
		alias
			"get_IsBrowsable"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.MemberDescriptor"
		alias
			"get_Name"
		end

	get_category: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.MemberDescriptor"
		alias
			"get_Category"
		end

	get_display_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.MemberDescriptor"
		alias
			"get_DisplayName"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.MemberDescriptor"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.MemberDescriptor"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen find_method (component_class: TYPE; name: SYSTEM_STRING; args: NATIVE_ARRAY [TYPE]; return_type: TYPE): METHOD_INFO is
		external
			"IL static signature (System.Type, System.String, System.Type[], System.Type): System.Reflection.MethodInfo use System.ComponentModel.MemberDescriptor"
		alias
			"FindMethod"
		end

	fill_attributes (attribute_list: ILIST) is
		external
			"IL signature (System.Collections.IList): System.Void use System.ComponentModel.MemberDescriptor"
		alias
			"FillAttributes"
		end

	get_attribute_array: NATIVE_ARRAY [ATTRIBUTE] is
		external
			"IL signature (): System.Attribute[] use System.ComponentModel.MemberDescriptor"
		alias
			"get_AttributeArray"
		end

	frozen find_method_type_string_array_type_type_boolean (component_class: TYPE; name: SYSTEM_STRING; args: NATIVE_ARRAY [TYPE]; return_type: TYPE; public_only: BOOLEAN): METHOD_INFO is
		external
			"IL static signature (System.Type, System.String, System.Type[], System.Type, System.Boolean): System.Reflection.MethodInfo use System.ComponentModel.MemberDescriptor"
		alias
			"FindMethod"
		end

	set_attribute_array (value: NATIVE_ARRAY [ATTRIBUTE]) is
		external
			"IL signature (System.Attribute[]): System.Void use System.ComponentModel.MemberDescriptor"
		alias
			"set_AttributeArray"
		end

	create_attribute_collection: SYSTEM_DLL_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.ComponentModel.AttributeCollection use System.ComponentModel.MemberDescriptor"
		alias
			"CreateAttributeCollection"
		end

	get_name_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.MemberDescriptor"
		alias
			"get_NameHashCode"
		end

	frozen get_invokee (component_class: TYPE; component: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Object): System.Object use System.ComponentModel.MemberDescriptor"
		alias
			"GetInvokee"
		end

	frozen get_site (component: SYSTEM_OBJECT): SYSTEM_DLL_ISITE is
		external
			"IL static signature (System.Object): System.ComponentModel.ISite use System.ComponentModel.MemberDescriptor"
		alias
			"GetSite"
		end

end -- class SYSTEM_DLL_MEMBER_DESCRIPTOR
