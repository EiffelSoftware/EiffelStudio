indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.PlatformNotSupportedException"

external class
	SYSTEM_PLATFORMNOTSUPPORTEDEXCEPTION

inherit
	SYSTEM_NOTSUPPORTEDEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_platformnotsupportedexception,
	make_platformnotsupportedexception_2,
	make_platformnotsupportedexception_1

feature {NONE} -- Initialization

	frozen make_platformnotsupportedexception is
		external
			"IL creator use System.PlatformNotSupportedException"
		end

	frozen make_platformnotsupportedexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.PlatformNotSupportedException"
		end

	frozen make_platformnotsupportedexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.PlatformNotSupportedException"
		end

end -- class SYSTEM_PLATFORMNOTSUPPORTEDEXCEPTION
