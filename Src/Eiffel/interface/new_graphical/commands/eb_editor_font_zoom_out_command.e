note
	description: "Command to decrease editor font zoom factor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
class
	EB_EDITOR_FONT_ZOOM_OUT_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			target as develop_window
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_develop_window: EB_DEVELOPMENT_WINDOW)
			-- Creation method
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}(a_develop_window)
			enable_sensitive

			init_accelerator

			update_accelerator (develop_window.window)
		end

	init_accelerator
			-- Initialize accelerator
		local
			l_preference: EB_SHARED_PREFERENCES
			l_shortcut: SHORTCUT_PREFERENCE
		do
			create l_preference
			l_shortcut := l_preference.preferences.editor_data.shortcuts.item ("zoom_out")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			set_referred_shortcut (l_shortcut)
		end

feature -- Command

	execute
			-- <Precursor>
		local
			l_preference: EB_SHARED_PREFERENCES
			l_value: INTEGER
		do
			create l_preference
			l_value := l_preference.preferences.editor_data.font_zoom_factor_preference.value - 1
			l_preference.preferences.editor_data.font_zoom_factor_preference.set_value (l_value)

			if
				attached develop_window as dw and then
				attached dw.menus.zoom_font_menu as m
			then
				if l_value > 0 then
					m.set_text (Interface_names.m_zoom + "%T(+" + l_value.out + ")")
				elseif l_value < 0 then
					m.set_text (Interface_names.m_zoom + "%T(" + l_value.out + ")")
				else
					m.set_text (Interface_names.m_zoom)
				end
			end
		end

feature -- Query

	menu_name: STRING_GENERAL
			-- Menu name
		do
			Result := interface_names.m_zoom_out
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end -- class EB_EDITOR_FONT_ZOOM_OUT_COMMAND
