indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.FormatterServices"

frozen external class
	SYSTEM_RUNTIME_SERIALIZATION_FORMATTERSERVICES

create {NONE}

feature -- Basic Operations

	frozen get_serializable_members (type: SYSTEM_TYPE): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL static signature (System.Type): System.Reflection.MemberInfo[] use System.Runtime.Serialization.FormatterServices"
		alias
			"GetSerializableMembers"
		end

	frozen get_uninitialized_object (type: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.Type): System.Object use System.Runtime.Serialization.FormatterServices"
		alias
			"GetUninitializedObject"
		end

	frozen get_object_data (obj: ANY; members: ARRAY [SYSTEM_REFLECTION_MEMBERINFO]): ARRAY [ANY] is
		external
			"IL static signature (System.Object, System.Reflection.MemberInfo[]): System.Object[] use System.Runtime.Serialization.FormatterServices"
		alias
			"GetObjectData"
		end

	frozen get_type_from_assembly (assem: SYSTEM_REFLECTION_ASSEMBLY; name: STRING): SYSTEM_TYPE is
		external
			"IL static signature (System.Reflection.Assembly, System.String): System.Type use System.Runtime.Serialization.FormatterServices"
		alias
			"GetTypeFromAssembly"
		end

	frozen populate_object_members (obj: ANY; members: ARRAY [SYSTEM_REFLECTION_MEMBERINFO]; data: ARRAY [ANY]): ANY is
		external
			"IL static signature (System.Object, System.Reflection.MemberInfo[], System.Object[]): System.Object use System.Runtime.Serialization.FormatterServices"
		alias
			"PopulateObjectMembers"
		end

	frozen get_serializable_members_type_streaming_context (type: SYSTEM_TYPE; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT): ARRAY [SYSTEM_REFLECTION_MEMBERINFO] is
		external
			"IL static signature (System.Type, System.Runtime.Serialization.StreamingContext): System.Reflection.MemberInfo[] use System.Runtime.Serialization.FormatterServices"
		alias
			"GetSerializableMembers"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_FORMATTERSERVICES
