indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.CategoryAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CATEGORY_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_category_attribute,
	make_system_dll_category_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_category_attribute is
		external
			"IL creator use System.ComponentModel.CategoryAttribute"
		end

	frozen make_system_dll_category_attribute_1 (category: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.CategoryAttribute"
		end

feature -- Access

	frozen get_focus: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Focus"
		end

	frozen get_default: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Default"
		end

	frozen get_drag_drop: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_DragDrop"
		end

	frozen get_window_style: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_WindowStyle"
		end

	frozen get_layout: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Layout"
		end

	frozen get_format: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Format"
		end

	frozen get_action: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Action"
		end

	frozen get_key: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Key"
		end

	frozen get_behavior: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Behavior"
		end

	frozen get_design: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Design"
		end

	frozen get_category: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.CategoryAttribute"
		alias
			"get_Category"
		end

	frozen get_appearance: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Appearance"
		end

	frozen get_data: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Data"
		end

	frozen get_mouse: SYSTEM_DLL_CATEGORY_ATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Mouse"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.CategoryAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.CategoryAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.CategoryAttribute"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	get_localized_string (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.ComponentModel.CategoryAttribute"
		alias
			"GetLocalizedString"
		end

end -- class SYSTEM_DLL_CATEGORY_ATTRIBUTE
