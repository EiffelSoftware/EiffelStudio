indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.BindableAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_BINDABLE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_bindable_attribute,
	make_system_dll_bindable_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_bindable_attribute (bindable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.BindableAttribute"
		end

	frozen make_system_dll_bindable_attribute_1 (flags: SYSTEM_DLL_BINDABLE_SUPPORT) is
		external
			"IL creator signature (System.ComponentModel.BindableSupport) use System.ComponentModel.BindableAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_BINDABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BindableAttribute use System.ComponentModel.BindableAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_BINDABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BindableAttribute use System.ComponentModel.BindableAttribute"
		alias
			"Yes"
		end

	frozen get_bindable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.BindableAttribute"
		alias
			"get_Bindable"
		end

	frozen no: SYSTEM_DLL_BINDABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BindableAttribute use System.ComponentModel.BindableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.BindableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.BindableAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.BindableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_BINDABLE_ATTRIBUTE
