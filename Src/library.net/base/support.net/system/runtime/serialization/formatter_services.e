indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.FormatterServices"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FORMATTER_SERVICES

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen get_serializable_members (type: TYPE): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL static signature (System.Type): System.Reflection.MemberInfo[] use System.Runtime.Serialization.FormatterServices"
		alias
			"GetSerializableMembers"
		end

	frozen get_uninitialized_object (type: TYPE): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type): System.Object use System.Runtime.Serialization.FormatterServices"
		alias
			"GetUninitializedObject"
		end

	frozen get_object_data (obj: SYSTEM_OBJECT; members: NATIVE_ARRAY [MEMBER_INFO]): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL static signature (System.Object, System.Reflection.MemberInfo[]): System.Object[] use System.Runtime.Serialization.FormatterServices"
		alias
			"GetObjectData"
		end

	frozen get_type_from_assembly (assem: ASSEMBLY; name: SYSTEM_STRING): TYPE is
		external
			"IL static signature (System.Reflection.Assembly, System.String): System.Type use System.Runtime.Serialization.FormatterServices"
		alias
			"GetTypeFromAssembly"
		end

	frozen populate_object_members (obj: SYSTEM_OBJECT; members: NATIVE_ARRAY [MEMBER_INFO]; data: NATIVE_ARRAY [SYSTEM_OBJECT]): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object, System.Reflection.MemberInfo[], System.Object[]): System.Object use System.Runtime.Serialization.FormatterServices"
		alias
			"PopulateObjectMembers"
		end

	frozen get_serializable_members_type_streaming_context (type: TYPE; context: STREAMING_CONTEXT): NATIVE_ARRAY [MEMBER_INFO] is
		external
			"IL static signature (System.Type, System.Runtime.Serialization.StreamingContext): System.Reflection.MemberInfo[] use System.Runtime.Serialization.FormatterServices"
		alias
			"GetSerializableMembers"
		end

end -- class FORMATTER_SERVICES
