indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_ROOTDESIGNERSERIALIZERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_type_id
		end

create
	make_rootdesignerserializerattribute_2,
	make_rootdesignerserializerattribute,
	make_rootdesignerserializerattribute_1

feature {NONE} -- Initialization

	frozen make_rootdesignerserializerattribute_2 (serializer_type_name: STRING; base_serializer_type_name: STRING; reloadable: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String, System.Boolean) use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		end

	frozen make_rootdesignerserializerattribute (serializer_type: SYSTEM_TYPE; base_serializer_type: SYSTEM_TYPE; reloadable: BOOLEAN) is
		external
			"IL creator signature (System.Type, System.Type, System.Boolean) use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		end

	frozen make_rootdesignerserializerattribute_1 (serializer_type_name: STRING; base_serializer_type: SYSTEM_TYPE; reloadable: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Type, System.Boolean) use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		end

feature -- Access

	frozen get_reloadable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		alias
			"get_Reloadable"
		end

	frozen get_serializer_base_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		alias
			"get_SerializerBaseTypeName"
		end

	frozen get_serializer_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		alias
			"get_SerializerTypeName"
		end

	get_type_id: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.RootDesignerSerializerAttribute"
		alias
			"get_TypeId"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_ROOTDESIGNERSERIALIZERATTRIBUTE
