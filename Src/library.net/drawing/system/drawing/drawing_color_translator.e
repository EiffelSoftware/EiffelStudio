indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.ColorTranslator"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_COLOR_TRANSLATOR

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen to_win32 (c: DRAWING_COLOR): INTEGER is
		external
			"IL static signature (System.Drawing.Color): System.Int32 use System.Drawing.ColorTranslator"
		alias
			"ToWin32"
		end

	frozen from_win32 (win32_color: INTEGER): DRAWING_COLOR is
		external
			"IL static signature (System.Int32): System.Drawing.Color use System.Drawing.ColorTranslator"
		alias
			"FromWin32"
		end

	frozen from_ole (ole_color: INTEGER): DRAWING_COLOR is
		external
			"IL static signature (System.Int32): System.Drawing.Color use System.Drawing.ColorTranslator"
		alias
			"FromOle"
		end

	frozen to_html (c: DRAWING_COLOR): SYSTEM_STRING is
		external
			"IL static signature (System.Drawing.Color): System.String use System.Drawing.ColorTranslator"
		alias
			"ToHtml"
		end

	frozen from_html (html_color: SYSTEM_STRING): DRAWING_COLOR is
		external
			"IL static signature (System.String): System.Drawing.Color use System.Drawing.ColorTranslator"
		alias
			"FromHtml"
		end

	frozen to_ole (c: DRAWING_COLOR): INTEGER is
		external
			"IL static signature (System.Drawing.Color): System.Int32 use System.Drawing.ColorTranslator"
		alias
			"ToOle"
		end

end -- class DRAWING_COLOR_TRANSLATOR
