indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.BrowsableAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_BROWSABLE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_browsable_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_browsable_attribute (browsable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.BrowsableAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_BROWSABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BrowsableAttribute use System.ComponentModel.BrowsableAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_BROWSABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BrowsableAttribute use System.ComponentModel.BrowsableAttribute"
		alias
			"Yes"
		end

	frozen get_browsable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.BrowsableAttribute"
		alias
			"get_Browsable"
		end

	frozen no: SYSTEM_DLL_BROWSABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BrowsableAttribute use System.ComponentModel.BrowsableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.BrowsableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.BrowsableAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.BrowsableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_BROWSABLE_ATTRIBUTE
