indexing
	"Controls access to Microsoft HTML Help, allows to display given urls"

class
	WIZARD_HTML_HELP_HANDLER

feature -- Access

	help_window_handle: INTEGER
			-- Handle to help window

feature -- Status Report

	is_valid_chm_url (a_chm_url: STRING): BOOLEAN is
			-- Is `a_chm_url' a valid Microsoft HTML Help URL?
		do
			Result := True
		end

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		do
			Result := help_window_handle /= 0
		end

feature -- Basic Operations

	show (a_chm_url: STRING) is
			-- Display help page page with url `a_chm_url'.
		require
			valid_chm_url: is_valid_chm_url (a_chm_url)
		do
			help_window_handle := cwin_html_help (default_pointer, (create {WEL_STRING}.make (a_chm_url)).item, Hh_display_topic, default_pointer)
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

end -- class WIZARD_HTML_HELP_HANDLER