indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.SerializationEntry"

frozen expanded external class
	SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONENTRY

inherit
	VALUE_TYPE

feature -- Access

	frozen get_object_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Serialization.SerializationEntry"
		alias
			"get_ObjectType"
		end

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.SerializationEntry"
		alias
			"get_Value"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SerializationEntry"
		alias
			"get_Name"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONENTRY
