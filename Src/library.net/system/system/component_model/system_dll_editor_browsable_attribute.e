indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.EditorBrowsableAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_EDITOR_BROWSABLE_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_hash_code,
			equals
		end

create
	make_system_dll_editor_browsable_attribute,
	make_system_dll_editor_browsable_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_editor_browsable_attribute (state: SYSTEM_DLL_EDITOR_BROWSABLE_STATE) is
		external
			"IL creator signature (System.ComponentModel.EditorBrowsableState) use System.ComponentModel.EditorBrowsableAttribute"
		end

	frozen make_system_dll_editor_browsable_attribute_1 is
		external
			"IL creator use System.ComponentModel.EditorBrowsableAttribute"
		end

feature -- Access

	frozen get_state: SYSTEM_DLL_EDITOR_BROWSABLE_STATE is
		external
			"IL signature (): System.ComponentModel.EditorBrowsableState use System.ComponentModel.EditorBrowsableAttribute"
		alias
			"get_State"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.EditorBrowsableAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.EditorBrowsableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_EDITOR_BROWSABLE_ATTRIBUTE
