indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.MemberDescriptor"

deferred external class
	SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object
		end

feature -- Access

	get_description: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.MemberDescriptor"
		alias
			"get_Description"
		end

	get_attributes: SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
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

	get_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.MemberDescriptor"
		alias
			"get_Name"
		end

	get_category: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.MemberDescriptor"
		alias
			"get_Category"
		end

	get_display_name: STRING is
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

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.MemberDescriptor"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen find_method (component_class: SYSTEM_TYPE; name: STRING; args: ARRAY [SYSTEM_TYPE]; return_type: SYSTEM_TYPE): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL static signature (System.Type, System.String, System.Type[], System.Type): System.Reflection.MethodInfo use System.ComponentModel.MemberDescriptor"
		alias
			"FindMethod"
		end

	fill_attributes (attribute_list: SYSTEM_COLLECTIONS_ILIST) is
		external
			"IL signature (System.Collections.IList): System.Void use System.ComponentModel.MemberDescriptor"
		alias
			"FillAttributes"
		end

	get_attribute_array: ARRAY [SYSTEM_ATTRIBUTE] is
		external
			"IL signature (): System.Attribute[] use System.ComponentModel.MemberDescriptor"
		alias
			"get_AttributeArray"
		end

	frozen find_method_type_string_array_type_type_boolean (component_class: SYSTEM_TYPE; name: STRING; args: ARRAY [SYSTEM_TYPE]; return_type: SYSTEM_TYPE; public_only: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL static signature (System.Type, System.String, System.Type[], System.Type, System.Boolean): System.Reflection.MethodInfo use System.ComponentModel.MemberDescriptor"
		alias
			"FindMethod"
		end

	set_attribute_array (value: ARRAY [SYSTEM_ATTRIBUTE]) is
		external
			"IL signature (System.Attribute[]): System.Void use System.ComponentModel.MemberDescriptor"
		alias
			"set_AttributeArray"
		end

	create_attribute_collection: SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
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

	frozen get_invokee (component_class: SYSTEM_TYPE; component: ANY): ANY is
		external
			"IL static signature (System.Type, System.Object): System.Object use System.ComponentModel.MemberDescriptor"
		alias
			"GetInvokee"
		end

	frozen get_site (component: ANY): SYSTEM_COMPONENTMODEL_ISITE is
		external
			"IL static signature (System.Object): System.ComponentModel.ISite use System.ComponentModel.MemberDescriptor"
		alias
			"GetSite"
		end

end -- class SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR
