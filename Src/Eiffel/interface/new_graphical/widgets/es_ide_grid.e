note
	description: "Summary description for {ES_IDE_GRID}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_IDE_GRID

inherit
	ES_GRID
		redefine
			create_interface_objects,
			initialize
		end

	IDE_OBSERVER
		undefine
			default_create, is_equal, copy
		redefine
			on_zoom
		end

	EB_RECYCLABLE
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			grid_preferences := preferences.development_window_data.grid_preferences
		end

	initialize
		do
			Precursor
			setup_ide_grid
			register_as_ide_observer
		end

feature -- IDE Grid settings

	setup_ide_grid
		local
			agt: PROCEDURE
		do
			agt := agent load_ide_grid_preferences
			load_ide_grid_preferences_agent := agt

			register_action (grid_preferences.change_actions, agt)

			load_ide_grid_preferences
		end

feature {NONE} -- Implementation		

	internal_recycle
		do
			if attached load_ide_grid_preferences_agent as agt then
				unregister_action (grid_preferences.change_actions, agt)
			end
		end

feature -- IDE Events

	on_zoom (a_zoom_factor: INTEGER)
		do
			grid_preferences.set_zoom_factor (a_zoom_factor)
		end

feature -- IDE properties

	grid_font: EV_FONT

feature {NONE} -- IDE Grid settings

	grid_preferences: EB_GRID_PREFERENCES

	load_ide_grid_preferences_agent: PROCEDURE

	load_ide_grid_preferences
		local
			prefs: like grid_preferences
		do
			prefs := grid_preferences
			grid_font := prefs.font_with_zoom_factor
			prefs.apply_to (Current)
		end

feature -- IDE Grid factory

	new_grid_label_item (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			if a_text = Void then
				create Result
			else
				create Result.make_with_text (a_text)
			end
			setup_grid_label_item (Result)
		end

	new_grid_label_item_with_pixmaps_on_right (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM
		do
			if a_text = Void then
				create Result
			else
				create Result.make_with_text (a_text)
			end
			setup_grid_label_item (Result)
		end

	setup_grid_label_item (glab: EV_GRID_LABEL_ITEM)
		do
			glab.set_font (grid_font)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
