indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.MulticastNotSupportedException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MULTICAST_NOT_SUPPORTED_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_multicast_not_supported_exception,
	make_multicast_not_supported_exception_2,
	make_multicast_not_supported_exception_1

feature {NONE} -- Initialization

	frozen make_multicast_not_supported_exception is
		external
			"IL creator use System.MulticastNotSupportedException"
		end

	frozen make_multicast_not_supported_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MulticastNotSupportedException"
		end

	frozen make_multicast_not_supported_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.MulticastNotSupportedException"
		end

end -- class MULTICAST_NOT_SUPPORTED_EXCEPTION
