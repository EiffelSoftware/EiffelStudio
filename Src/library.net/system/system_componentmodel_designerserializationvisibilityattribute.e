indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DesignerSerializationVisibilityAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_designerserializationvisibilityattribute

feature {NONE} -- Initialization

	frozen make_designerserializationvisibilityattribute (visibility: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITY) is
		external
			"IL creator signature (System.ComponentModel.DesignerSerializationVisibility) use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		end

feature -- Access

	frozen get_visibility: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITY is
		external
			"IL signature (): System.ComponentModel.DesignerSerializationVisibility use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"get_Visibility"
		end

	frozen content: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerSerializationVisibilityAttribute use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"Content"
		end

	frozen default: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerSerializationVisibilityAttribute use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"Default"
		end

	frozen hidden: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerSerializationVisibilityAttribute use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"Hidden"
		end

	frozen visible: SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerSerializationVisibilityAttribute use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"Visible"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGNERSERIALIZATIONVISIBILITYATTRIBUTE
