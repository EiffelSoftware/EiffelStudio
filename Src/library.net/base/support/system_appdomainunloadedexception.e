indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.AppDomainUnloadedException"

external class
	SYSTEM_APPDOMAINUNLOADEDEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_appdomainunloadedexception_1,
	make_appdomainunloadedexception,
	make_appdomainunloadedexception_2

feature {NONE} -- Initialization

	frozen make_appdomainunloadedexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.AppDomainUnloadedException"
		end

	frozen make_appdomainunloadedexception is
		external
			"IL creator use System.AppDomainUnloadedException"
		end

	frozen make_appdomainunloadedexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.AppDomainUnloadedException"
		end

end -- class SYSTEM_APPDOMAINUNLOADEDEXCEPTION
