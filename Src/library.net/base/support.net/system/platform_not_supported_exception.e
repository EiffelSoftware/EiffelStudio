indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.PlatformNotSupportedException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	PLATFORM_NOT_SUPPORTED_EXCEPTION

inherit
	NOT_SUPPORTED_EXCEPTION
	ISERIALIZABLE

create
	make_platform_not_supported_exception,
	make_platform_not_supported_exception_1,
	make_platform_not_supported_exception_2

feature {NONE} -- Initialization

	frozen make_platform_not_supported_exception is
		external
			"IL creator use System.PlatformNotSupportedException"
		end

	frozen make_platform_not_supported_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.PlatformNotSupportedException"
		end

	frozen make_platform_not_supported_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.PlatformNotSupportedException"
		end

end -- class PLATFORM_NOT_SUPPORTED_EXCEPTION
