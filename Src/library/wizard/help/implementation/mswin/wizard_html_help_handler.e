indexing
	"Controls access to Microsoft HTML Help, allows to display given urls"

class
	WIZARD_HTML_HELP_HANDLER

inherit
	WEL_SW_CONSTANTS

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
		local
			returned_value: INTEGER
		do	
			returned_value := cwin_shell_execute (cwin_desktop_window, (create {WEL_STRING}.make ("open")).item, (create {WEL_STRING}.make ("F:\Eiffel50\bench\wizards\new_projects\dotnet\wizard.chm")).item, default_pointer, default_pointer, sw_shownormal)
			--help_window_handle := cwin_html_help (cwin_desktop_window, (create {WEL_STRING}.make (a_chm_url)).item, Hh_display_topic, 0)
		end
		
feature {NONE} -- Externals

	cwin_desktop_window: POINTER is
			-- Help Workshop `HtmlHelp' API.
		external
			"C [macro <Htmlhelp.h>]: HWND"
		alias
			"GetDesktopWindow()"
		end
	
	cwin_shell_execute (hwnd, verb, file, parameters, directory: POINTER; show_cmd:INTEGER): INTEGER is
			-- Shell API `ShellExecute' function
		external
			"C [macro <shellapi.h>] (HWND, LPCTSTR, LPCTSTR, LPCTSTR, LPCTSTR, INT): EIF_INTEGER"
		alias
			"ShellExecute"
		end
		
	cwin_html_help (hwnd, pszFile: POINTER; command: INTEGER; data: INTEGER): INTEGER is
			-- Help Workshop `HtmlHelp' API.
		external
			"C [macro <Htmlhelp.h>] (HWND, LPCSTR, UINT, DWORD): EIF_INTEGER"
		alias
			"HtmlHelp"
		end

	Hh_display_topic: INTEGER is
			-- Help Workshop HH_DISPLAY_TOPIC constant
		external
			"C [macro <Htmlhelp.h>]: EIF_INTEGER"
		alias
			"HH_DISPLAY_TOPIC"
		end

end -- class WIZARD_HTML_HELP_HANDLER