indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.LosFormatter"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_LOS_FORMATTER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.LosFormatter"
		end

feature -- Basic Operations

	frozen deserialize_text_reader (input: TEXT_READER): SYSTEM_OBJECT is
		external
			"IL signature (System.IO.TextReader): System.Object use System.Web.UI.LosFormatter"
		alias
			"Deserialize"
		end

	frozen deserialize (input: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.UI.LosFormatter"
		alias
			"Deserialize"
		end

	frozen serialize_stream (stream: SYSTEM_STREAM; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.IO.Stream, System.Object): System.Void use System.Web.UI.LosFormatter"
		alias
			"Serialize"
		end

	frozen deserialize_stream (stream: SYSTEM_STREAM): SYSTEM_OBJECT is
		external
			"IL signature (System.IO.Stream): System.Object use System.Web.UI.LosFormatter"
		alias
			"Deserialize"
		end

	frozen serialize (output: TEXT_WRITER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.IO.TextWriter, System.Object): System.Void use System.Web.UI.LosFormatter"
		alias
			"Serialize"
		end

end -- class WEB_LOS_FORMATTER
