note
	description: "[
		A service to access setting of text in the status bar or one or more shell windows.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	STATUS_BAR_S

inherit
	USABLE_I

	SERVICE_I

	DISPOSABLE_I

feature -- Element change

	set_text (a_text: !READABLE_STRING_GENERAL; a_style: NATURAL_8)
			-- Sets the status bar message text on all windows.
			--
			-- `a_text': The text to set on the status bar.
			-- `a_style': A text style, see {STATUS_BAR_TEXT_STYLE} for applicable styles.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	set_text_on_window (a_text: !READABLE_STRING_GENERAL; a_style: NATURAL_8; a_window: !SHELL_WINDOW_I)
			-- Sets the status bar message text on a selected window.
			--
			-- `a_text': The text to set on the status bar.
			-- `a_style': A text style, see {STATUS_BAR_TEXT_STYLE} for applicable styles.
			-- `a_window': The window to set the status text on.
		require
			is_interface_usable: is_interface_usable
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		end

feature -- Basic operations

	clear
			-- Clears the status bar text on all windows.
		require
			is_interface_usable: is_interface_usable
		do
			set_text ("", {STATUS_BAR_TEXT_STYLE}.normal)
		end

	clear_on_window (a_text: !READABLE_STRING_GENERAL; a_window: !SHELL_WINDOW_I)
			-- Clears the status bar text on a selected window.
			--
			-- `a_text': The text to set on the status bar.
			-- `a_window': The window clear the status text from.
		require
			is_interface_usable: is_interface_usable
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			set_text_on_window ("", {STATUS_BAR_TEXT_STYLE}.normal, a_window)
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
