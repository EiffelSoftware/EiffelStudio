indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.DesignTimeVisibleAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_DESIGN_TIME_VISIBLE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_design_time_visible_attribute,
	make_system_dll_design_time_visible_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_design_time_visible_attribute (visible: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.DesignTimeVisibleAttribute"
		end

	frozen make_system_dll_design_time_visible_attribute_1 is
		external
			"IL creator use System.ComponentModel.DesignTimeVisibleAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_DESIGN_TIME_VISIBLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignTimeVisibleAttribute use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_DESIGN_TIME_VISIBLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignTimeVisibleAttribute use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_DLL_DESIGN_TIME_VISIBLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignTimeVisibleAttribute use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"No"
		end

	frozen get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"get_Visible"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_DESIGN_TIME_VISIBLE_ATTRIBUTE
