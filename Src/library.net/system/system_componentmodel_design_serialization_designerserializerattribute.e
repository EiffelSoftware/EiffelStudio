indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_DESIGNERSERIALIZERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_type_id
		end

create
	make_designerserializerattribute_1,
	make_designerserializerattribute_2,
	make_designerserializerattribute

feature {NONE} -- Initialization

	frozen make_designerserializerattribute_1 (serializer_type_name: STRING; base_serializer_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		end

	frozen make_designerserializerattribute_2 (serializer_type_name: STRING; base_serializer_type_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		end

	frozen make_designerserializerattribute (serializer_type: SYSTEM_TYPE; base_serializer_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type, System.Type) use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		end

feature -- Access

	frozen get_serializer_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		alias
			"get_SerializerTypeName"
		end

	frozen get_serializer_base_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		alias
			"get_SerializerBaseTypeName"
		end

	get_type_id: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.DesignerSerializerAttribute"
		alias
			"get_TypeId"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_DESIGNERSERIALIZERATTRIBUTE
