indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.TwoCharPeekableTextReader"

frozen external class
	SYSTEM_WEB_UI_TWOCHARPEEKABLETEXTREADER

create
	make

feature {NONE} -- Initialization

	frozen make (reader: SYSTEM_IO_TEXTREADER) is
		external
			"IL creator signature (System.IO.TextReader) use System.Web.UI.TwoCharPeekableTextReader"
		end

feature -- Basic Operations

	frozen unread (character: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.TwoCharPeekableTextReader"
		alias
			"Unread"
		end

	frozen peek: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.TwoCharPeekableTextReader"
		alias
			"Peek"
		end

	frozen read: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.TwoCharPeekableTextReader"
		alias
			"Read"
		end

end -- class SYSTEM_WEB_UI_TWOCHARPEEKABLETEXTREADER
