indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.LosFormatter"

frozen external class
	SYSTEM_WEB_UI_LOSFORMATTER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.LosFormatter"
		end

feature -- Basic Operations

	frozen deserialize_text_reader (input: SYSTEM_IO_TEXTREADER): ANY is
		external
			"IL signature (System.IO.TextReader): System.Object use System.Web.UI.LosFormatter"
		alias
			"Deserialize"
		end

	frozen deserialize (input: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.UI.LosFormatter"
		alias
			"Deserialize"
		end

	frozen serialize_stream (stream: SYSTEM_IO_STREAM; value: ANY) is
		external
			"IL signature (System.IO.Stream, System.Object): System.Void use System.Web.UI.LosFormatter"
		alias
			"Serialize"
		end

	frozen deserialize_stream (stream: SYSTEM_IO_STREAM): ANY is
		external
			"IL signature (System.IO.Stream): System.Object use System.Web.UI.LosFormatter"
		alias
			"Deserialize"
		end

	frozen serialize (output: SYSTEM_IO_TEXTWRITER; value: ANY) is
		external
			"IL signature (System.IO.TextWriter, System.Object): System.Void use System.Web.UI.LosFormatter"
		alias
			"Serialize"
		end

end -- class SYSTEM_WEB_UI_LOSFORMATTER
