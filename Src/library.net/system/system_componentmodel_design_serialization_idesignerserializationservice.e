indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerSerializationService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERSERIALIZATIONSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	deserialize (serialization_data: ANY): SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL deferred signature (System.Object): System.Collections.ICollection use System.ComponentModel.Design.Serialization.IDesignerSerializationService"
		alias
			"Deserialize"
		end

	serialize (objects: SYSTEM_COLLECTIONS_ICOLLECTION): ANY is
		external
			"IL deferred signature (System.Collections.ICollection): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationService"
		alias
			"Serialize"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERSERIALIZATIONSERVICE
