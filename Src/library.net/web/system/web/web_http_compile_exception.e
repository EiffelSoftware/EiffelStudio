indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpCompileException"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_COMPILE_EXCEPTION

inherit
	WEB_HTTP_EXCEPTION
	ISERIALIZABLE

create {NONE}

feature -- Access

	frozen get_results: SYSTEM_DLL_COMPILER_RESULTS is
		external
			"IL signature (): System.CodeDom.Compiler.CompilerResults use System.Web.HttpCompileException"
		alias
			"get_Results"
		end

	frozen get_source_code: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpCompileException"
		alias
			"get_SourceCode"
		end

end -- class WEB_HTTP_COMPILE_EXCEPTION
