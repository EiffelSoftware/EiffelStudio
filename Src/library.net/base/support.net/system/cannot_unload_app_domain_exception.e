indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CannotUnloadAppDomainException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CANNOT_UNLOAD_APP_DOMAIN_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_cannot_unload_app_domain_exception,
	make_cannot_unload_app_domain_exception_2,
	make_cannot_unload_app_domain_exception_1

feature {NONE} -- Initialization

	frozen make_cannot_unload_app_domain_exception is
		external
			"IL creator use System.CannotUnloadAppDomainException"
		end

	frozen make_cannot_unload_app_domain_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.CannotUnloadAppDomainException"
		end

	frozen make_cannot_unload_app_domain_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CannotUnloadAppDomainException"
		end

end -- class CANNOT_UNLOAD_APP_DOMAIN_EXCEPTION
