indexing
	"Controls access to Microsoft HTML Help, allows to display given urls"

class
	WIZARD_HTML_HELP_HANDLER

inherit
	WEL_SW_CONSTANTS
	
	WIZARD_SHARED

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
			returned_value := cwin_shell_execute (cwin_desktop_window, (create {WEL_STRING}.make ("open")).item, (create {WEL_STRING}.make (Chm_url)).item, default_pointer, default_pointer, sw_shownormal)
			--help_window_handle := cwin_html_help (cwin_desktop_window, (create {WEL_STRING}.make (a_chm_url)).item, Hh_display_topic, 0)
		end

feature {NONE} -- Implementation

	Chm_url: STRING is 
			-- Path to `wizard.chm' (relatively to $ISE_EIFFEL value)
		once
			Result := wizard_source + "\wizard.chm"
		ensure
			non_void_path: Result /= Void
			not_empty_path: not Result.is_empty
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

--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

