indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerSerializationProvider"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER_SERIALIZATION_PROVIDER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_serializer (manager: SYSTEM_DLL_IDESIGNER_SERIALIZATION_MANAGER; current_serializer: SYSTEM_OBJECT; object_type: TYPE; serializer_type: TYPE): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.IDesignerSerializationManager, System.Object, System.Type, System.Type): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationProvider"
		alias
			"GetSerializer"
		end

end -- class SYSTEM_DLL_IDESIGNER_SERIALIZATION_PROVIDER
