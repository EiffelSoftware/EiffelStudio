indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Win32Exception"

external class
	SYSTEM_COMPONENTMODEL_WIN32EXCEPTION

inherit
	SYSTEM_RUNTIME_INTEROPSERVICES_EXTERNALEXCEPTION
		redefine
			get_object_data
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_win32exception_1,
	make_win32exception,
	make_win32exception_2

feature {NONE} -- Initialization

	frozen make_win32exception_1 (error: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.ComponentModel.Win32Exception"
		end

	frozen make_win32exception is
		external
			"IL creator use System.ComponentModel.Win32Exception"
		end

	frozen make_win32exception_2 (error: INTEGER; message: STRING) is
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

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.ComponentModel.Win32Exception"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_COMPONENTMODEL_WIN32EXCEPTION
