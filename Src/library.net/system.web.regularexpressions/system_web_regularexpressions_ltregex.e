indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.RegularExpressions.LTRegex"

external class
	SYSTEM_WEB_REGULAREXPRESSIONS_LTREGEX

inherit
	SYSTEM_TEXT_REGULAREXPRESSIONS_REGEX
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_ltregex

feature {NONE} -- Initialization

	frozen make_ltregex is
		external
			"IL creator use System.Web.RegularExpressions.LTRegex"
		end

end -- class SYSTEM_WEB_REGULAREXPRESSIONS_LTREGEX
