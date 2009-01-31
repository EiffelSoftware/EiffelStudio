note
	description: "[
		Default status bar service ({STATUS_BAR_S}) implementation for setting status bar text in one or
		more shell windows.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STATUS_BAR

inherit
	STATUS_BAR_S

	DISPOSABLE_SAFE

inherit {NONE}
	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precusor>
		do
		end

feature -- Element change

	set_text (a_text: !READABLE_STRING_GENERAL; a_style: NATURAL_8)
			-- <Precursor>
		local
			l_windows: LIST [EB_DEVELOPMENT_WINDOW]
			l_window: EB_DEVELOPMENT_WINDOW
		do
			l_windows := window_manager.development_windows
			from l_windows.start until l_windows.after loop
				l_window := l_windows.item_for_iteration
				check l_window_attached: l_window /= Void end
				if l_window.is_interface_usable then
					set_text_on_window (a_text, a_style, l_window)
				end
				l_windows.forth
			end
		end

	set_text_on_window (a_text: !READABLE_STRING_GENERAL; a_style: NATURAL_8; a_window: !SHELL_WINDOW_I)
			-- <Precursor>
		do
			if {l_window: EB_DEVELOPMENT_WINDOW} a_window then
				inspect a_style
				when {STATUS_BAR_TEXT_STYLE}.normal then
					l_window.status_bar.display_message (a_text.as_string_32)
				when {STATUS_BAR_TEXT_STYLE}.error then
					l_window.status_bar.display_error_message (a_text.as_string_32)
				end
			else
				check False end
			end
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
