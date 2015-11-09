note
	description: "Command to open code analysis preference dialog."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CA_SHOW_PREFERENCES_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine tooltext end

	ES_CODE_ANALYSIS_BENCH_HELPER

	CA_SHARED_NAMES

create
	make

feature {NONE} -- Initialization

	make
		do
			enable_sensitive
		end

feature -- Execution

	execute
		do
			if preference_window = Void or else preference_window.is_destroyed then
				create preference_window.make (code_analyzer.preferences)
				preference_window.set_title (ca_names.preferences_window_title)
				preference_window.raise
			end
			preference_window.show
		end

feature {NONE} -- Implementation

	preference_window: ES_CA_PREFERENCES_WINDOW
			-- Preferences dialog.

feature -- Properties

	name: STRING_32 = "Code Analysis Preferences"
			-- <Precursor>

	menu_name: STRING_32
			-- <Precursor>
		do
			Result := ca_names.pref_menu_name
		end

	tooltext: STRING_32
			-- <Precursor>
		do
			Result := ca_names.pref_tooltext
		end

	description: STRING_32 = ""
			-- <Precursor>

	tooltip: STRING_32
			-- <Precursor>
		do
			Result := ca_names.pref_tooltip
		end

	pixmap: EV_PIXMAP
			-- <Precursor>
		once
			Result := pixmaps.icon_pixmaps.project_settings_advanced_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- <Precursor>
		once
			Result := pixmaps.icon_pixmaps.project_settings_advanced_icon_buffer
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
