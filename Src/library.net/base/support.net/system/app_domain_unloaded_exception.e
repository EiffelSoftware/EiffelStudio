indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.AppDomainUnloadedException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	APP_DOMAIN_UNLOADED_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_app_domain_unloaded_exception_1,
	make_app_domain_unloaded_exception_2,
	make_app_domain_unloaded_exception

feature {NONE} -- Initialization

	frozen make_app_domain_unloaded_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.AppDomainUnloadedException"
		end

	frozen make_app_domain_unloaded_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.AppDomainUnloadedException"
		end

	frozen make_app_domain_unloaded_exception is
		external
			"IL creator use System.AppDomainUnloadedException"
		end

end -- class APP_DOMAIN_UNLOADED_EXCEPTION
