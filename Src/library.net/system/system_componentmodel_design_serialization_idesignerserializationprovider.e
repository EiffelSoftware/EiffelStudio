indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerSerializationProvider"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERSERIALIZATIONPROVIDER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_serializer (manager: SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERSERIALIZATIONMANAGER; current_serializer: ANY; object_type: SYSTEM_TYPE; serializer_type: SYSTEM_TYPE): ANY is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.IDesignerSerializationManager, System.Object, System.Type, System.Type): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationProvider"
		alias
			"GetSerializer"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERSERIALIZATIONPROVIDER
