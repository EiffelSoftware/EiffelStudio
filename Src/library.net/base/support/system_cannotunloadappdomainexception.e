indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.CannotUnloadAppDomainException"

external class
	SYSTEM_CANNOTUNLOADAPPDOMAINEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_cannot_unload_appdomain_exception_2,
	make_cannot_unload_appdomain_exception_1,
	make_cannot_unload_appdomain_exception

feature {NONE} -- Initialization

	frozen make_cannot_unload_appdomain_exception_2 (message2: STRING; innerException2: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.CannotUnloadAppDomainException"
		end

	frozen make_cannot_unload_appdomain_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.CannotUnloadAppDomainException"
		end

	frozen make_cannot_unload_appdomain_exception is
		external
			"IL creator use System.CannotUnloadAppDomainException"
		end

end -- class SYSTEM_CANNOTUNLOADAPPDOMAINEXCEPTION
