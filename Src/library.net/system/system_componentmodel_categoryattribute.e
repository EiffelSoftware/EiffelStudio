indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.CategoryAttribute"

external class
	SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_categoryattribute,
	make_categoryattribute_1

feature {NONE} -- Initialization

	frozen make_categoryattribute is
		external
			"IL creator use System.ComponentModel.CategoryAttribute"
		end

	frozen make_categoryattribute_1 (category: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.CategoryAttribute"
		end

feature -- Access

	frozen get_focus: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Focus"
		end

	frozen get_default: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Default"
		end

	frozen get_drag_drop: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_DragDrop"
		end

	frozen get_window_style: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_WindowStyle"
		end

	frozen get_layout: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Layout"
		end

	frozen get_format: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Format"
		end

	frozen get_action: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Action"
		end

	frozen get_key: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Key"
		end

	frozen get_behavior: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Behavior"
		end

	frozen get_design: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Design"
		end

	frozen get_category: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.CategoryAttribute"
		alias
			"get_Category"
		end

	frozen get_appearance: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Appearance"
		end

	frozen get_data: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
		external
			"IL static signature (): System.ComponentModel.CategoryAttribute use System.ComponentModel.CategoryAttribute"
		alias
			"get_Data"
		end

	frozen get_mouse: SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.CategoryAttribute"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	get_localized_string (value: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.ComponentModel.CategoryAttribute"
		alias
			"GetLocalizedString"
		end

end -- class SYSTEM_COMPONENTMODEL_CATEGORYATTRIBUTE
