indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.SerializationEntry"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	SERIALIZATION_ENTRY

inherit
	VALUE_TYPE

feature -- Access

	frozen get_object_type: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Serialization.SerializationEntry"
		alias
			"get_ObjectType"
		end

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.SerializationEntry"
		alias
			"get_Value"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SerializationEntry"
		alias
			"get_Name"
		end

end -- class SERIALIZATION_ENTRY
