indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.VersionNotFoundException"

external class
	SYSTEM_DATA_VERSIONNOTFOUNDEXCEPTION

inherit
	SYSTEM_DATA_DATAEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_versionnotfoundexception_2,
	make_versionnotfoundexception,
	make_versionnotfoundexception_1

feature {NONE} -- Initialization

	frozen make_versionnotfoundexception_2 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.VersionNotFoundException"
		end

	frozen make_versionnotfoundexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Data.VersionNotFoundException"
		end

	frozen make_versionnotfoundexception_1 is
		external
			"IL creator use System.Data.VersionNotFoundException"
		end

end -- class SYSTEM_DATA_VERSIONNOTFOUNDEXCEPTION
