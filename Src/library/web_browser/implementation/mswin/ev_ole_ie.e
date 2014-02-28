note
	description: "[
					The manager control ActiveX OLE Internet Browser
					
					More details: See MSDN "IWebBrowser2 Interface"
					http://msdn.microsoft.com/en-us/library/aa752127(VS.85).aspx


					Have a look at the following page to configure the behavior of the web browser:
					http://msdn.microsoft.com/en-us/library/ee330730(v=vs.85).aspx
																				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application, accelerator, event loop"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_OLE_IE

inherit
	EV_ANY_HANDLER

feature -- Query

	hwnd: POINTER
			-- Handle to embedded ole ie

feature -- Command

	ole_initialize
			-- Initialize OLE
		local
			l_result: INTEGER
		do
			l_result := c_ole_initialize
			check success: l_result = 0 end
		end

	ole_uninitialize
			-- Unintialize OLE
		do
			c_ole_uninitialize
		end

	embed_ie (a_wel_hwnd: POINTER)
			-- Puts the browser object inside our host window, and save a pointer to this
			-- window's browser object in the window's GWL_USERDATA field
		require
			not_void: a_wel_hwnd /= default_pointer
		local
			l_result: INTEGER
		do
			l_result := c_embed_ie (a_wel_hwnd)
			check success: l_result = 0 end

			hwnd := a_wel_hwnd
		ensure
			set: hwnd = a_wel_hwnd
		end

	unembed_ie (a_wel_hwnd: POINTER)
			-- Called to detach the browser object from our host window, and free its
			-- resources, right before we destroy our window.
		require
			created: a_wel_hwnd /= default_pointer
			set: hwnd /= default_pointer
		do
			c_unembed_ie (a_wel_hwnd)

			hwnd := default_pointer
		ensure
			cleared: hwnd = default_pointer
		end

	display_web_page (a_url: READABLE_STRING_GENERAL)
			-- Displays a URL, or HTML file on disk
		require
			created: hwnd /= default_pointer
			not_void: a_url /= Void and then not a_url.is_empty
		local
			l_c_string: WEL_STRING
		do
			create l_c_string.make (a_url)
			if c_display_web_page (hwnd, l_c_string.item) /= 0 then
				check not_has_error: False end
			end
		end

	display_web_string (a_html_string: READABLE_STRING_GENERAL)
			-- Displays the html code in 'a_html_string'.
		require
			created: hwnd /= default_pointer
			not_void: a_html_string /= Void and then not a_html_string.is_empty
		local
			l_c_string: WEL_STRING
		do
			create l_c_string.make (a_html_string)
			if c_display_web_string (hwnd, l_c_string.item) /= 0 then
				check not_has_error: False end
			end
		end

	do_page_action (a_action: INTEGER)
			-- Implements the functionality of a "Back". "Forward", "Home", "Search",
			-- "Refresh", or "Stop" button
		require
			created: hwnd /= default_pointer
			valid: (create {EV_OLE_IE_PAGE_ACTIONS}).is_valid (a_action)
		do
			c_do_page_action (hwnd, a_action)
		end

	resize_browser (a_width, a_height: INTEGER)
			-- Resizes the browser object for the specified window to the specified
			-- width and height.
 		require
 			created: hwnd /= default_pointer
 		do
			c_resize_browser (hwnd, a_width, a_height)
 		end

feature {NONE} -- Externals

	c_ole_initialize: INTEGER
			-- Initialize OLE
		external
			"C inline use <ole2.h>"
		alias
			"return OleInitialize(NULL);"
		end

	c_ole_uninitialize
			-- Uninitialized OLE
		external
			"C inline use <ole2.h>"
		alias
			"OleUninitialize();"
		end

	c_embed_ie (a_wel_hwnd: POINTER): INTEGER
			-- Puts the browser object inside our host window, and save a pointer to this
			-- window's browser object in the window's GWL_USERDATA field
		external
			"C inline use %"eif_web_browser.h%""
		alias
			"return (EIF_INTEGER) EmbedBrowserObject ((HWND) $a_wel_hwnd);"
		end

	c_unembed_ie (a_wel_hwnd: POINTER)
			-- Called to detach the browser object from our host window, and free its
			-- resources, right before we destroy our window.
		external
			"C inline use %"eif_web_browser.h%""
		alias
			"UnEmbedBrowserObject ($a_wel_hwnd);"
		end

	c_display_web_page (a_wel_hwnd: POINTER; a_url: POINTER): INTEGER
			-- Displays a URL, or HTML file on disk
			-- If 0 success, otherwise failure.
		external
			"C inline use %"eif_web_browser.h%""
		alias
			"return (EIF_INTEGER) DisplayHTMLPage((HWND) $a_wel_hwnd, (LPTSTR) $a_url);"
		end

	c_display_web_string (a_wel_hwnd: POINTER; a_html_string: POINTER): INTEGER
			-- Displays the html code in 'a_html_string'.
			-- If 0 success, otherwise failure.
		external
			"C inline use %"eif_web_browser.h%""
		alias
			"return (EIF_INTEGER) DisplayHTMLStr((HWND) $a_wel_hwnd, (LPTSTR) $a_html_string);"
		end

	c_do_page_action (a_wel_hwnd: POINTER; a_action: INTEGER)
			-- Implements the functionality of a "Back". "Forward", "Home", "Search",
			-- "Refresh", or "Stop" button
		external
			"C inline use %"eif_web_browser.h%""
		alias
			"DoPageAction ((HWND) $a_wel_hwnd, (DWORD) $a_action);"
		end

	c_resize_browser (a_wel_hwnd: POINTER; a_width, a_height: INTEGER)
			-- Resizes the browser object for the specified window to the specified
			-- width and height.
		external
			"C inline use %"eif_web_browser.h%""
		alias
			"ResizeBrowser ((HWND) $a_wel_hwnd, (DWORD) $a_width, (DWORD) $a_height);"
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
