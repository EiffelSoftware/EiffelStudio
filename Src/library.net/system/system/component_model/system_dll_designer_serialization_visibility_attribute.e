indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.DesignerSerializationVisibilityAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_DESIGNER_SERIALIZATION_VISIBILITY_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_designer_serialization_visibility_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_designer_serialization_visibility_attribute (visibility: SYSTEM_DLL_DESIGNER_SERIALIZATION_VISIBILITY) is
		external
			"IL creator signature (System.ComponentModel.DesignerSerializationVisibility) use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		end

feature -- Access

	frozen get_visibility: SYSTEM_DLL_DESIGNER_SERIALIZATION_VISIBILITY is
		external
			"IL signature (): System.ComponentModel.DesignerSerializationVisibility use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"get_Visibility"
		end

	frozen content: SYSTEM_DLL_DESIGNER_SERIALIZATION_VISIBILITY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerSerializationVisibilityAttribute use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"Content"
		end

	frozen default_: SYSTEM_DLL_DESIGNER_SERIALIZATION_VISIBILITY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerSerializationVisibilityAttribute use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"Default"
		end

	frozen hidden: SYSTEM_DLL_DESIGNER_SERIALIZATION_VISIBILITY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignerSerializationVisibilityAttribute use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"Hidden"
		end

	frozen visible: SYSTEM_DLL_DESIGNER_SERIALIZATION_VISIBILITY_ATTRIBUTE is
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

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DesignerSerializationVisibilityAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_DESIGNER_SERIALIZATION_VISIBILITY_ATTRIBUTE
