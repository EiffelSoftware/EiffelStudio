indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpCompileException"

frozen external class
	SYSTEM_WEB_HTTPCOMPILEEXCEPTION

inherit
	SYSTEM_WEB_HTTPEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_httpcompileexception

feature {NONE} -- Initialization

	frozen make_httpcompileexception (results: SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS; source_code: STRING) is
		external
			"IL creator signature (System.CodeDom.Compiler.CompilerResults, System.String) use System.Web.HttpCompileException"
		end

feature -- Access

	frozen get_results: SYSTEM_CODEDOM_COMPILER_COMPILERRESULTS is
		external
			"IL signature (): System.CodeDom.Compiler.CompilerResults use System.Web.HttpCompileException"
		alias
			"get_Results"
		end

	frozen get_source_code: STRING is
		external
			"IL signature (): System.String use System.Web.HttpCompileException"
		alias
			"get_SourceCode"
		end

end -- class SYSTEM_WEB_HTTPCOMPILEEXCEPTION
