indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.PropertyTabAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_PROPERTY_TAB_ATTRIBUTE

inherit
	ATTRIBUTE
		rename
			equals as equals_object
		redefine
			get_hash_code,
			equals_object
		end

create
	make_system_dll_property_tab_attribute_1,
	make_system_dll_property_tab_attribute_3,
	make_system_dll_property_tab_attribute_2,
	make_system_dll_property_tab_attribute,
	make_system_dll_property_tab_attribute_4

feature {NONE} -- Initialization

	frozen make_system_dll_property_tab_attribute_1 (tab_class: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.PropertyTabAttribute"
		end

	frozen make_system_dll_property_tab_attribute_3 (tab_class: TYPE; tab_scope: SYSTEM_DLL_PROPERTY_TAB_SCOPE) is
		external
			"IL creator signature (System.Type, System.ComponentModel.PropertyTabScope) use System.ComponentModel.PropertyTabAttribute"
		end

	frozen make_system_dll_property_tab_attribute_2 (tab_class_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.PropertyTabAttribute"
		end

	frozen make_system_dll_property_tab_attribute is
		external
			"IL creator use System.ComponentModel.PropertyTabAttribute"
		end

	frozen make_system_dll_property_tab_attribute_4 (tab_class_name: SYSTEM_STRING; tab_scope: SYSTEM_DLL_PROPERTY_TAB_SCOPE) is
		external
			"IL creator signature (System.String, System.ComponentModel.PropertyTabScope) use System.ComponentModel.PropertyTabAttribute"
		end

feature -- Access

	frozen get_tab_scopes: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_TAB_SCOPE] is
		external
			"IL signature (): System.ComponentModel.PropertyTabScope[] use System.ComponentModel.PropertyTabAttribute"
		alias
			"get_TabScopes"
		end

	frozen get_tab_classes: NATIVE_ARRAY [TYPE] is
		external
			"IL signature (): System.Type[] use System.ComponentModel.PropertyTabAttribute"
		alias
			"get_TabClasses"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.PropertyTabAttribute"
		alias
			"GetHashCode"
		end

	equals_object (other: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.PropertyTabAttribute"
		alias
			"Equals"
		end

	frozen equals (other: SYSTEM_DLL_PROPERTY_TAB_ATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.PropertyTabAttribute): System.Boolean use System.ComponentModel.PropertyTabAttribute"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen initialize_arrays_array_string (tab_class_names: NATIVE_ARRAY [SYSTEM_STRING]; tab_scopes: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_TAB_SCOPE]) is
		external
			"IL signature (System.String[], System.ComponentModel.PropertyTabScope[]): System.Void use System.ComponentModel.PropertyTabAttribute"
		alias
			"InitializeArrays"
		end

	frozen get_tab_class_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.ComponentModel.PropertyTabAttribute"
		alias
			"get_TabClassNames"
		end

	frozen initialize_arrays (tab_classes: NATIVE_ARRAY [TYPE]; tab_scopes: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_TAB_SCOPE]) is
		external
			"IL signature (System.Type[], System.ComponentModel.PropertyTabScope[]): System.Void use System.ComponentModel.PropertyTabAttribute"
		alias
			"InitializeArrays"
		end

end -- class SYSTEM_DLL_PROPERTY_TAB_ATTRIBUTE
