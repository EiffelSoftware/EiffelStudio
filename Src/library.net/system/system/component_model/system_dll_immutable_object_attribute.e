indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ImmutableObjectAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_IMMUTABLE_OBJECT_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_immutable_object_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_immutable_object_attribute (immutable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ImmutableObjectAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_IMMUTABLE_OBJECT_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ImmutableObjectAttribute use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_IMMUTABLE_OBJECT_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ImmutableObjectAttribute use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"Yes"
		end

	frozen get_immutable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"get_Immutable"
		end

	frozen no: SYSTEM_DLL_IMMUTABLE_OBJECT_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ImmutableObjectAttribute use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_IMMUTABLE_OBJECT_ATTRIBUTE
