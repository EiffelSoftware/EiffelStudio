indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpUnhandledException"

frozen external class
	SYSTEM_WEB_HTTPUNHANDLEDEXCEPTION

inherit
	SYSTEM_WEB_HTTPEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_httpunhandledexception,
	make_httpunhandledexception_1

feature {NONE} -- Initialization

	frozen make_httpunhandledexception (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Web.HttpUnhandledException"
		end

	frozen make_httpunhandledexception_1 (message: STRING; post_message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.String, System.Exception) use System.Web.HttpUnhandledException"
		end

end -- class SYSTEM_WEB_HTTPUNHANDLEDEXCEPTION
