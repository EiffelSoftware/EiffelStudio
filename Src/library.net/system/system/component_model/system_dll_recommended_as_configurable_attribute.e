indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.RecommendedAsConfigurableAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_RECOMMENDED_AS_CONFIGURABLE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_recommended_as_configurable_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_recommended_as_configurable_attribute (recommended_as_configurable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.RecommendedAsConfigurableAttribute"
		end

feature -- Access

	frozen get_recommended_as_configurable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"get_RecommendedAsConfigurable"
		end

	frozen default_: SYSTEM_DLL_RECOMMENDED_AS_CONFIGURABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RecommendedAsConfigurableAttribute use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_RECOMMENDED_AS_CONFIGURABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RecommendedAsConfigurableAttribute use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_DLL_RECOMMENDED_AS_CONFIGURABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.RecommendedAsConfigurableAttribute use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.RecommendedAsConfigurableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_RECOMMENDED_AS_CONFIGURABLE_ATTRIBUTE
