indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.SerializationInfoEnumerator"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SERIALIZATION_INFO_ENUMERATOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERATOR
		rename
			get_current as system_collections_ienumerator_get_current
		end

create {NONE}

feature -- Access

	frozen get_object_type: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"get_ObjectType"
		end

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"get_Value"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"get_Name"
		end

	frozen get_current: SERIALIZATION_ENTRY is
		external
			"IL signature (): System.Runtime.Serialization.SerializationEntry use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"get_Current"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"GetHashCode"
		end

	frozen reset is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"Reset"
		end

	frozen move_next: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"MoveNext"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"Finalize"
		end

	frozen system_collections_ienumerator_get_current: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"System.Collections.IEnumerator.get_Current"
		end

end -- class SERIALIZATION_INFO_ENUMERATOR
