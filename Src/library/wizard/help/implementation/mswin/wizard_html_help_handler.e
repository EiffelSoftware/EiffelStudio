note
	description: "Controls access to Microsoft HTML Help, allows to display given urls"

class
	WIZARD_HTML_HELP_HANDLER

inherit
	WEL_SW_CONSTANTS

	WIZARD_SHARED

feature -- Access

	help_window_handle: INTEGER
			-- Handle to help window

feature -- Status Report

	is_valid_chm_url (a_chm_url: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_chm_url' a valid Microsoft HTML Help URL?
		do
			Result := True
		end

	last_show_successful: BOOLEAN
			-- Was last call to `show' successful?
		do
			Result := help_window_handle /= 0
		end

feature -- Basic Operations

	show (a_chm_url: READABLE_STRING_GENERAL)
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

	Chm_url: STRING_32
			-- Path to `wizard.chm' (relatively to $ISE_EIFFEL value)
		once
			Result := wizard_source.extended ({STRING_32} "wizard.chm").name
		ensure
			non_void_path: Result /= Void
			not_empty_path: not Result.is_empty
		end

feature {NONE} -- Externals

	cwin_desktop_window: POINTER
			-- Help Workshop `HtmlHelp' API.
		external
			"C [macro <Htmlhelp.h>]: HWND"
		alias
			"GetDesktopWindow()"
		end

	cwin_shell_execute (hwnd, verb, file, parameters, directory: POINTER; show_cmd:INTEGER): INTEGER
			-- Shell API `ShellExecute' function
		external
			"C [macro <shellapi.h>] (HWND, LPCTSTR, LPCTSTR, LPCTSTR, LPCTSTR, INT): EIF_INTEGER"
		alias
			"ShellExecute"
		end

	cwin_html_help (hwnd, pszFile: POINTER; command: INTEGER; data: INTEGER): INTEGER
			-- Help Workshop `HtmlHelp' API.
		external
			"C [macro <Htmlhelp.h>] (HWND, LPCSTR, UINT, DWORD): EIF_INTEGER"
		alias
			"HtmlHelp"
		end

	Hh_display_topic: INTEGER
			-- Help Workshop HH_DISPLAY_TOPIC constant
		external
			"C [macro <Htmlhelp.h>]: EIF_INTEGER"
		alias
			"HH_DISPLAY_TOPIC"
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
