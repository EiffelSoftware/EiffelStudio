indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_ROOT_DESIGNER_SERIALIZER_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_type_id
		end

create
	make_system_dll_root_designer_serializer_attribute_1,
	make_system_dll_root_designer_serializer_attribute_2,
	make_system_dll_root_designer_serializer_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_root_designer_serializer_attribute_1 (serializer_type_name: SYSTEM_STRING; base_serializer_type: TYPE; reloadable: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Type, System.Boolean) use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		end

	frozen make_system_dll_root_designer_serializer_attribute_2 (serializer_type_name: SYSTEM_STRING; base_serializer_type_name: SYSTEM_STRING; reloadable: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String, System.Boolean) use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		end

	frozen make_system_dll_root_designer_serializer_attribute (serializer_type: TYPE; base_serializer_type: TYPE; reloadable: BOOLEAN) is
		external
			"IL creator signature (System.Type, System.Type, System.Boolean) use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		end

feature -- Access

	frozen get_reloadable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		alias
			"get_Reloadable"
		end

	frozen get_serializer_base_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		alias
			"get_SerializerBaseTypeName"
		end

	frozen get_serializer_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		alias
			"get_SerializerTypeName"
		end

	get_type_id: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		alias
			"get_TypeId"
		end

end -- class SYSTEM_DLL_ROOT_DESIGNER_SERIALIZER_ATTRIBUTE
