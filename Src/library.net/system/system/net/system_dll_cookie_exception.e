indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.CookieException"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COOKIE_EXCEPTION

inherit
	FORMAT_EXCEPTION
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		redefine
			system_runtime_serialization_iserializable_get_object_data
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_system_dll_cookie_exception

feature {NONE} -- Initialization

	frozen make_system_dll_cookie_exception is
		external
			"IL creator use System.Net.CookieException"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (serialization_info: SERIALIZATION_INFO; streaming_context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Net.CookieException"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DLL_COOKIE_EXCEPTION
