indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.MergablePropertyAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_MERGABLE_PROPERTY_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_mergable_property_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_mergable_property_attribute (allow_merge: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.MergablePropertyAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_MERGABLE_PROPERTY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.MergablePropertyAttribute use System.ComponentModel.MergablePropertyAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_DLL_MERGABLE_PROPERTY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.MergablePropertyAttribute use System.ComponentModel.MergablePropertyAttribute"
		alias
			"Yes"
		end

	frozen get_allow_merge: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.MergablePropertyAttribute"
		alias
			"get_AllowMerge"
		end

	frozen no: SYSTEM_DLL_MERGABLE_PROPERTY_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.MergablePropertyAttribute use System.ComponentModel.MergablePropertyAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.MergablePropertyAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.MergablePropertyAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.MergablePropertyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_MERGABLE_PROPERTY_ATTRIBUTE
