indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.MulticastNotSupportedException"

frozen external class
	SYSTEM_MULTICASTNOTSUPPORTEDEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_multicastnotsupportedexception,
	make_multicastnotsupportedexception_1,
	make_multicastnotsupportedexception_2

feature {NONE} -- Initialization

	frozen make_multicastnotsupportedexception is
		external
			"IL creator use System.MulticastNotSupportedException"
		end

	frozen make_multicastnotsupportedexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.MulticastNotSupportedException"
		end

	frozen make_multicastnotsupportedexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.MulticastNotSupportedException"
		end

end -- class SYSTEM_MULTICASTNOTSUPPORTEDEXCEPTION
