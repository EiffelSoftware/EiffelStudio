indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.DesignerAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_DESIGNER_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_type_id,
			get_hash_code,
			equals
		end

create
	make_system_dll_designer_attribute,
	make_system_dll_designer_attribute_3,
	make_system_dll_designer_attribute_2,
	make_system_dll_designer_attribute_1,
	make_system_dll_designer_attribute_4

feature {NONE} -- Initialization

	frozen make_system_dll_designer_attribute (designer_type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DesignerAttribute"
		end

	frozen make_system_dll_designer_attribute_3 (designer_type_name: SYSTEM_STRING; designer_base_type: TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.ComponentModel.DesignerAttribute"
		end

	frozen make_system_dll_designer_attribute_2 (designer_type_name: SYSTEM_STRING; designer_base_type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.DesignerAttribute"
		end

	frozen make_system_dll_designer_attribute_1 (designer_type: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.DesignerAttribute"
		end

	frozen make_system_dll_designer_attribute_4 (designer_type: TYPE; designer_base_type: TYPE) is
		external
			"IL creator signature (System.Type, System.Type) use System.ComponentModel.DesignerAttribute"
		end

feature -- Access

	frozen get_designer_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DesignerAttribute"
		alias
			"get_DesignerTypeName"
		end

	frozen get_designer_base_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DesignerAttribute"
		alias
			"get_DesignerBaseTypeName"
		end

	get_type_id: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.DesignerAttribute"
		alias
			"get_TypeId"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DesignerAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DesignerAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_DESIGNER_ATTRIBUTE
