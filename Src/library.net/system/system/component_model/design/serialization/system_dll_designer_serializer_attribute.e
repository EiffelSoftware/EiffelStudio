indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_DESIGNER_SERIALIZER_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_type_id
		end

create
	make_system_dll_designer_serializer_attribute_2,
	make_system_dll_designer_serializer_attribute,
	make_system_dll_designer_serializer_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_designer_serializer_attribute_2 (serializer_type_name: SYSTEM_STRING; base_serializer_type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		end

	frozen make_system_dll_designer_serializer_attribute (serializer_type: TYPE; base_serializer_type: TYPE) is
		external
			"IL creator signature (System.Type, System.Type) use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		end

	frozen make_system_dll_designer_serializer_attribute_1 (serializer_type_name: SYSTEM_STRING; base_serializer_type: TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		end

feature -- Access

	frozen get_serializer_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		alias
			"get_SerializerTypeName"
		end

	frozen get_serializer_base_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		alias
			"get_SerializerBaseTypeName"
		end

	get_type_id: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		alias
			"get_TypeId"
		end

end -- class SYSTEM_DLL_DESIGNER_SERIALIZER_ATTRIBUTE
