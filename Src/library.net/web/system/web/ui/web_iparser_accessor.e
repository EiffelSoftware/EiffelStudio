indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.IParserAccessor"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IPARSER_ACCESSOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Web.UI.IParserAccessor"
		alias
			"AddParsedSubObject"
		end

end -- class WEB_IPARSER_ACCESSOR
