indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.AppDomainUnloadedException"

external class
	SYSTEM_APPDOMAINUNLOADEDEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_appdomain_unloaded_exception_1,
	make_appdomain_unloaded_exception,
	make_appdomain_unloaded_exception_2

feature {NONE} -- Initialization

	frozen make_appdomain_unloaded_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.AppDomainUnloadedException"
		end

	frozen make_appdomain_unloaded_exception is
		external
			"IL creator use System.AppDomainUnloadedException"
		end

	frozen make_appdomain_unloaded_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.AppDomainUnloadedException"
		end

end -- class SYSTEM_APPDOMAINUNLOADEDEXCEPTION
