indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.EditorAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_EDITOR_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_type_id,
			get_hash_code,
			equals
		end

create
	make_system_dll_editor_attribute_1,
	make_system_dll_editor_attribute,
	make_system_dll_editor_attribute_3,
	make_system_dll_editor_attribute_2

feature {NONE} -- Initialization

	frozen make_system_dll_editor_attribute_1 (type_name: SYSTEM_STRING; base_type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.EditorAttribute"
		end

	frozen make_system_dll_editor_attribute is
		external
			"IL creator use System.ComponentModel.EditorAttribute"
		end

	frozen make_system_dll_editor_attribute_3 (type: TYPE; base_type: TYPE) is
		external
			"IL creator signature (System.Type, System.Type) use System.ComponentModel.EditorAttribute"
		end

	frozen make_system_dll_editor_attribute_2 (type_name: SYSTEM_STRING; base_type: TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.ComponentModel.EditorAttribute"
		end

feature -- Access

	frozen get_editor_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.EditorAttribute"
		alias
			"get_EditorTypeName"
		end

	frozen get_editor_base_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.EditorAttribute"
		alias
			"get_EditorBaseTypeName"
		end

	get_type_id: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.EditorAttribute"
		alias
			"get_TypeId"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.EditorAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.EditorAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_EDITOR_ATTRIBUTE
