indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ListBindableAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_LIST_BINDABLE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_list_bindable_attribute,
	make_system_dll_list_bindable_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_list_bindable_attribute (list_bindable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ListBindableAttribute"
		end

	frozen make_system_dll_list_bindable_attribute_1 (flags: SYSTEM_DLL_BINDABLE_SUPPORT) is
		external
			"IL creator signature (System.ComponentModel.BindableSupport) use System.ComponentModel.ListBindableAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_LIST_BINDABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ListBindableAttribute use System.ComponentModel.ListBindableAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_LIST_BINDABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ListBindableAttribute use System.ComponentModel.ListBindableAttribute"
		alias
			"Yes"
		end

	frozen get_list_bindable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ListBindableAttribute"
		alias
			"get_ListBindable"
		end

	frozen no: SYSTEM_DLL_LIST_BINDABLE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ListBindableAttribute use System.ComponentModel.ListBindableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ListBindableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ListBindableAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ListBindableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_LIST_BINDABLE_ATTRIBUTE
