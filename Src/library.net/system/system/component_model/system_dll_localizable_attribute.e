indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.LocalizableAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_LOCALIZABLE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_localizable_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_localizable_attribute (is_localizable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.LocalizableAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_LOCALIZABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.LocalizableAttribute use System.ComponentModel.LocalizableAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_LOCALIZABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.LocalizableAttribute use System.ComponentModel.LocalizableAttribute"
		alias
			"Yes"
		end

	frozen get_is_localizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.LocalizableAttribute"
		alias
			"get_IsLocalizable"
		end

	frozen no: SYSTEM_DLL_LOCALIZABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.LocalizableAttribute use System.ComponentModel.LocalizableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.LocalizableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.LocalizableAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.LocalizableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_LOCALIZABLE_ATTRIBUTE
