indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ReadOnlyAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_READ_ONLY_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_read_only_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_read_only_attribute (is_read_only: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ReadOnlyAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_READ_ONLY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ReadOnlyAttribute use System.ComponentModel.ReadOnlyAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_READ_ONLY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ReadOnlyAttribute use System.ComponentModel.ReadOnlyAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_DLL_READ_ONLY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ReadOnlyAttribute use System.ComponentModel.ReadOnlyAttribute"
		alias
			"No"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ReadOnlyAttribute"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ReadOnlyAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ReadOnlyAttribute"
		alias
			"GetHashCode"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ReadOnlyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_READ_ONLY_ATTRIBUTE
