indexing
	description: "System Help Manager"
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_MANAGER

feature -- Commands

	show_help is
			-- Show help
		do
			show (url_prefix + default_page_url)			
		end
		
feature -- Access

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		do
			Result := help_window_handle /= 0
		end

feature {NONE} -- Implementation

	help_window_handle: INTEGER
			-- Handle to help window

	show (a_chm_url: STRING) is
			-- Display help page page with url `a_chm_url'.
		do
			help_window_handle := cwin_html_help (default_pointer, (create {WEL_STRING}.make (a_chm_url)).item, Hh_display_topic, default_pointer)
		end

	url_prefix: STRING is 
			-- URL prefix for $EiffelGraphicalCompiler$ help files
		once
			Result := (create {APPLICATION_CONSTANTS}).documentation_directory.out + "\help.chm::"
		end
	
	default_page_url: STRING is 
			-- URL default page whe opening help
		once
			Result := "index.html"
		end
	
feature {NONE} -- Externals

	cwin_html_help (hwnd, pszFile: POINTER; command: INTEGER; data: POINTER): INTEGER is
			-- Help Workshop `HtmlHelp' API.
		external
			"C [macro %"Htmlhelp.h%"] (HWND, LPCSTR, UINT, DWORD): EIF_INTEGER"
		alias
			"HtmlHelp"
		end

	Hh_display_topic: INTEGER is
			-- Help Workshop HH_DISPLAY_TOPIC constant
		external
			"C [macro %"Htmlhelp.h%"]: EIF_INTEGER"
		alias
			"HH_DISPLAY_TOPIC"
		end

end -- class HELP_MANAGER
