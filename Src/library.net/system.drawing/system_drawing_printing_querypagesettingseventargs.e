indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.QueryPageSettingsEventArgs"

external class
	SYSTEM_DRAWING_PRINTING_QUERYPAGESETTINGSEVENTARGS

inherit
	SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS

create
	make_querypagesettingseventargs

feature {NONE} -- Initialization

	frozen make_querypagesettingseventargs (page_settings: SYSTEM_DRAWING_PRINTING_PAGESETTINGS) is
		external
			"IL creator signature (System.Drawing.Printing.PageSettings) use System.Drawing.Printing.QueryPageSettingsEventArgs"
		end

feature -- Access

	frozen get_page_settings: SYSTEM_DRAWING_PRINTING_PAGESETTINGS is
		external
			"IL signature (): System.Drawing.Printing.PageSettings use System.Drawing.Printing.QueryPageSettingsEventArgs"
		alias
			"get_PageSettings"
		end

feature -- Element Change

	frozen set_page_settings (value: SYSTEM_DRAWING_PRINTING_PAGESETTINGS) is
		external
			"IL signature (System.Drawing.Printing.PageSettings): System.Void use System.Drawing.Printing.QueryPageSettingsEventArgs"
		alias
			"set_PageSettings"
		end

end -- class SYSTEM_DRAWING_PRINTING_QUERYPAGESETTINGSEVENTARGS
