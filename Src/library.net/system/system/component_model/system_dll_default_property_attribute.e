indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.DefaultPropertyAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_DEFAULT_PROPERTY_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_hash_code,
			equals
		end

create
	make_system_dll_default_property_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_default_property_attribute (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DefaultPropertyAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_DEFAULT_PROPERTY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DefaultPropertyAttribute use System.ComponentModel.DefaultPropertyAttribute"
		alias
			"Default"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DefaultPropertyAttribute"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DefaultPropertyAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DefaultPropertyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_DEFAULT_PROPERTY_ATTRIBUTE
