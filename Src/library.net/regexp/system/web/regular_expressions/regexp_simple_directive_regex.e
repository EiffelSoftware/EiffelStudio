indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.RegularExpressions.SimpleDirectiveRegex"
	assembly: "System.Web.RegularExpressions", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	REGEXP_SIMPLE_DIRECTIVE_REGEX

inherit
	SYSTEM_DLL_REGEX
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_regexp_simple_directive_regex

feature {NONE} -- Initialization

	frozen make_regexp_simple_directive_regex is
		external
			"IL creator use System.Web.RegularExpressions.SimpleDirectiveRegex"
		end

end -- class REGEXP_SIMPLE_DIRECTIVE_REGEX
