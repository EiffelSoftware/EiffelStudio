indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerSerializationService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER_SERIALIZATION_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	deserialize (serialization_data: SYSTEM_OBJECT): ICOLLECTION is
		external
			"IL deferred signature (System.Object): System.Collections.ICollection use System.ComponentModel.Design.Serialization.IDesignerSerializationService"
		alias
			"Deserialize"
		end

	serialize (objects: ICOLLECTION): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Collections.ICollection): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationService"
		alias
			"Serialize"
		end

end -- class SYSTEM_DLL_IDESIGNER_SERIALIZATION_SERVICE
