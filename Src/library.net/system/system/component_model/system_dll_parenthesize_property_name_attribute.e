indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ParenthesizePropertyNameAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_PARENTHESIZE_PROPERTY_NAME_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_parenthesize_property_name_attribute,
	make_system_dll_parenthesize_property_name_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_parenthesize_property_name_attribute is
		external
			"IL creator use System.ComponentModel.ParenthesizePropertyNameAttribute"
		end

	frozen make_system_dll_parenthesize_property_name_attribute_1 (need_parenthesis: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ParenthesizePropertyNameAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_PARENTHESIZE_PROPERTY_NAME_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ParenthesizePropertyNameAttribute use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"Default"
		end

	frozen get_need_parenthesis: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"get_NeedParenthesis"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"GetHashCode"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_PARENTHESIZE_PROPERTY_NAME_ATTRIBUTE
