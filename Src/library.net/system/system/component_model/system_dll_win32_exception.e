indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Win32Exception"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_WIN32_EXCEPTION

inherit
	EXTERNAL_EXCEPTION
		redefine
			get_object_data
		end
	ISERIALIZABLE

create
	make_system_dll_win32_exception,
	make_system_dll_win32_exception_1,
	make_system_dll_win32_exception_2

feature {NONE} -- Initialization

	frozen make_system_dll_win32_exception is
		external
			"IL creator use System.ComponentModel.Win32Exception"
		end

	frozen make_system_dll_win32_exception_1 (error: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.ComponentModel.Win32Exception"
		end

	frozen make_system_dll_win32_exception_2 (error: INTEGER; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.Int32, System.String) use System.ComponentModel.Win32Exception"
		end

feature -- Access

	frozen get_native_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Win32Exception"
		alias
			"get_NativeErrorCode"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.ComponentModel.Win32Exception"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_DLL_WIN32_EXCEPTION
