indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.RefreshPropertiesAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_REFRESH_PROPERTIES_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_refresh_properties_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_refresh_properties_attribute (refresh: SYSTEM_DLL_REFRESH_PROPERTIES) is
		external
			"IL creator signature (System.ComponentModel.RefreshProperties) use System.ComponentModel.RefreshPropertiesAttribute"
		end

feature -- Access

	frozen all_: SYSTEM_DLL_REFRESH_PROPERTIES_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RefreshPropertiesAttribute use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"All"
		end

	frozen default_: SYSTEM_DLL_REFRESH_PROPERTIES_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RefreshPropertiesAttribute use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"Default"
		end

	frozen repaint: SYSTEM_DLL_REFRESH_PROPERTIES_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RefreshPropertiesAttribute use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"Repaint"
		end

	frozen get_refresh_properties: SYSTEM_DLL_REFRESH_PROPERTIES is
		external
			"IL signature (): System.ComponentModel.RefreshProperties use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"get_RefreshProperties"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"GetHashCode"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.RefreshPropertiesAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_REFRESH_PROPERTIES_ATTRIBUTE
