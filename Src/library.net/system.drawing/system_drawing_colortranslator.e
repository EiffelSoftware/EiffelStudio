indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.ColorTranslator"

frozen external class
	SYSTEM_DRAWING_COLORTRANSLATOR

create {NONE}

feature -- Basic Operations

	frozen to_win32 (c: SYSTEM_DRAWING_COLOR): INTEGER is
		external
			"IL static signature (System.Drawing.Color): System.Int32 use System.Drawing.ColorTranslator"
		alias
			"ToWin32"
		end

	frozen from_win32 (win32_color: INTEGER): SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (System.Int32): System.Drawing.Color use System.Drawing.ColorTranslator"
		alias
			"FromWin32"
		end

	frozen from_ole (ole_color: INTEGER): SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (System.Int32): System.Drawing.Color use System.Drawing.ColorTranslator"
		alias
			"FromOle"
		end

	frozen to_html (c: SYSTEM_DRAWING_COLOR): STRING is
		external
			"IL static signature (System.Drawing.Color): System.String use System.Drawing.ColorTranslator"
		alias
			"ToHtml"
		end

	frozen from_html (html_color: STRING): SYSTEM_DRAWING_COLOR is
		external
			"IL static signature (System.String): System.Drawing.Color use System.Drawing.ColorTranslator"
		alias
			"FromHtml"
		end

	frozen to_ole (c: SYSTEM_DRAWING_COLOR): INTEGER is
		external
			"IL static signature (System.Drawing.Color): System.Int32 use System.Drawing.ColorTranslator"
		alias
			"ToOle"
		end

end -- class SYSTEM_DRAWING_COLORTRANSLATOR
