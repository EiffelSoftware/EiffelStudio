indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.RegularExpressions.DirectiveRegex"

external class
	SYSTEM_WEB_REGULAREXPRESSIONS_DIRECTIVEREGEX

inherit
	SYSTEM_TEXT_REGULAREXPRESSIONS_REGEX
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_directiveregex

feature {NONE} -- Initialization

	frozen make_directiveregex is
		external
			"IL creator use System.Web.RegularExpressions.DirectiveRegex"
		end

end -- class SYSTEM_WEB_REGULAREXPRESSIONS_DIRECTIVEREGEX
