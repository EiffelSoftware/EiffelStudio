indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.DesignerCategoryAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_DESIGNER_CATEGORY_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_type_id,
			get_hash_code,
			equals
		end

create
	make_system_dll_designer_category_attribute,
	make_system_dll_designer_category_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_designer_category_attribute is
		external
			"IL creator use System.ComponentModel.DesignerCategoryAttribute"
		end

	frozen make_system_dll_designer_category_attribute_1 (category: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DesignerCategoryAttribute"
		end

feature -- Access

	frozen component: SYSTEM_DLL_DESIGNER_CATEGORY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerCategoryAttribute use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"Component"
		end

	frozen default_: SYSTEM_DLL_DESIGNER_CATEGORY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerCategoryAttribute use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"Default"
		end

	frozen form: SYSTEM_DLL_DESIGNER_CATEGORY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerCategoryAttribute use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"Form"
		end

	get_type_id: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"get_TypeId"
		end

	frozen get_category: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"get_Category"
		end

	frozen generic: SYSTEM_DLL_DESIGNER_CATEGORY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerCategoryAttribute use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"Generic"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_DESIGNER_CATEGORY_ATTRIBUTE
