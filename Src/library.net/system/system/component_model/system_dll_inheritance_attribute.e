indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.InheritanceAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_INHERITANCE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals,
			to_string
		end

create
	make_system_dll_inheritance_attribute,
	make_system_dll_inheritance_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_inheritance_attribute is
		external
			"IL creator use System.ComponentModel.InheritanceAttribute"
		end

	frozen make_system_dll_inheritance_attribute_1 (inheritance_level: SYSTEM_DLL_INHERITANCE_LEVEL) is
		external
			"IL creator signature (System.ComponentModel.InheritanceLevel) use System.ComponentModel.InheritanceAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_INHERITANCE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.InheritanceAttribute use System.ComponentModel.InheritanceAttribute"
		alias
			"Default"
		end

	frozen inherited_read_only: SYSTEM_DLL_INHERITANCE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.InheritanceAttribute use System.ComponentModel.InheritanceAttribute"
		alias
			"InheritedReadOnly"
		end

	frozen not_inherited: SYSTEM_DLL_INHERITANCE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.InheritanceAttribute use System.ComponentModel.InheritanceAttribute"
		alias
			"NotInherited"
		end

	frozen get_inheritance_level: SYSTEM_DLL_INHERITANCE_LEVEL is
		external
			"IL signature (): System.ComponentModel.InheritanceLevel use System.ComponentModel.InheritanceAttribute"
		alias
			"get_InheritanceLevel"
		end

	frozen inherited: SYSTEM_DLL_INHERITANCE_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.InheritanceAttribute use System.ComponentModel.InheritanceAttribute"
		alias
			"Inherited"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.InheritanceAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.InheritanceAttribute"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.InheritanceAttribute"
		alias
			"ToString"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.InheritanceAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_INHERITANCE_ATTRIBUTE
