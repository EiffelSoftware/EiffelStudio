indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DesignerCategoryAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGNERCATEGORYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_type_id,
			get_hash_code,
			is_equal
		end

create
	make_designercategoryattribute_1,
	make_designercategoryattribute

feature {NONE} -- Initialization

	frozen make_designercategoryattribute_1 (category: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DesignerCategoryAttribute"
		end

	frozen make_designercategoryattribute is
		external
			"IL creator use System.ComponentModel.DesignerCategoryAttribute"
		end

feature -- Access

	frozen component: SYSTEM_COMPONENTMODEL_DESIGNERCATEGORYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerCategoryAttribute use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"Component"
		end

	frozen form: SYSTEM_COMPONENTMODEL_DESIGNERCATEGORYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerCategoryAttribute use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"Form"
		end

	frozen default: SYSTEM_COMPONENTMODEL_DESIGNERCATEGORYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerCategoryAttribute use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"Default"
		end

	get_type_id: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"get_TypeId"
		end

	frozen get_category: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"get_Category"
		end

	frozen generic: SYSTEM_COMPONENTMODEL_DESIGNERCATEGORYATTRIBUTE is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DesignerCategoryAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGNERCATEGORYATTRIBUTE
