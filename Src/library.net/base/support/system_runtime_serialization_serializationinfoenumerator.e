indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.SerializationInfoEnumerator"

frozen external class
	SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFOENUMERATOR

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERATOR
		rename
			get_current as ienumerator_get_current
		end

create {NONE}

feature -- Access

	frozen get_object_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"get_ObjectType"
		end

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"get_Value"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"get_Name"
		end

	frozen get_current: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONENTRY is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

	frozen ienumerator_get_current: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Serialization.SerializationInfoEnumerator"
		alias
			"System.Collections.IEnumerator.get_Current"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFOENUMERATOR
