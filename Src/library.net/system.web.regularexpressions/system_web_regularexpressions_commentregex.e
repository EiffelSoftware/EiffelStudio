indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.RegularExpressions.CommentRegex"

external class
	SYSTEM_WEB_REGULAREXPRESSIONS_COMMENTREGEX

inherit
	SYSTEM_TEXT_REGULAREXPRESSIONS_REGEX
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_commentregex

feature {NONE} -- Initialization

	frozen make_commentregex is
		external
			"IL creator use System.Web.RegularExpressions.CommentRegex"
		end

end -- class SYSTEM_WEB_REGULAREXPRESSIONS_COMMENTREGEX
