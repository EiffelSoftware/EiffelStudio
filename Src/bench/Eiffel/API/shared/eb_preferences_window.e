indexing
	description: "EiffelStudio preference window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES_WINDOW

inherit
	PREFERENCES_GRID
		rename
			preferences as view_preferences
		redefine
			make,
			hide,
			on_close,
			add_preference_change_item,
			set_preference_to_default,
			on_preference_changed
		end

	EB_SHARED_PIXMAPS
		rename
			implementation as px_implementation
		undefine
			copy,
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			copy,
			default_create
		end

create
	make, make_with_hidden

feature -- Access

	make (a_preferences: like view_preferences; a_parent_window: like parent_window) is
			-- New window.  Redefined to register EiffelStudio specific preference widgets for
			-- special preference types.
		do
			set_root_icon (icon_preference_root)
			set_folder_icon (icon_preference_folder)
			Precursor {PREFERENCES_GRID} (a_preferences, a_parent_window)
			set_icon_pixmap (icon_preference_window)
			register_preference_widget (create {IDENTIFIED_FONT_PREFERENCE_WIDGET}.make)
			close_request_actions.extend (agent on_close)
		end

	add_preference_change_item (l_preference: PREFERENCE; a_row: EV_GRID_ROW) is
			-- Add the correct preference change widget item at `a_row' of `grid'
		local
			l_id_font: IDENTIFIED_FONT_PREFERENCE
			l_font_widget: IDENTIFIED_FONT_PREFERENCE_WIDGET
		do
			l_id_font ?= l_preference
			if l_id_font /= Void then
				create l_font_widget.make_with_preference (l_id_font)
				l_font_widget.set_caller (Current)
				l_font_widget.change_actions.extend (agent on_preference_changed (l_preference))
				a_row.set_item (4, l_font_widget.change_item_widget)
				a_row.item (4).set_data (l_font_widget)
			else
				Precursor {PREFERENCES_GRID} (l_preference, a_row)
			end
		end

	set_preference_to_default (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE) is
			-- Set the preference value to the original default.
		local
			l_label_item: EV_GRID_LABEL_ITEM
			l_font: IDENTIFIED_FONT_PREFERENCE
		do
			l_font ?= a_pref
			if l_font /= Void then
				a_pref.reset
				a_item.set_text (a_pref.default_value)
				a_item.set_font (default_font)
				l_label_item ?= a_item.row.item (1)
				if l_label_item /= Void then
						-- Font label item
					l_label_item.set_font (l_font.value.font)
				end
			else
				Precursor {PREFERENCES_GRID} (a_item, a_pref)
			end
		end

	on_preference_changed (a_pref: PREFERENCE) is
			-- Preference was changed
		local
			l_id_font_pref: IDENTIFIED_FONT_PREFERENCE
		do
			l_id_font_pref ?= a_pref
			if l_id_font_pref /= Void then
				grid.selected_rows.first.set_height (l_id_font_pref.value.font.height.max (default_row_height))
			end
			Precursor {PREFERENCES_GRID} (a_pref)
		end

	on_close is
			-- Window was closed
		do
			preferences.misc_data.preference_window_height_preference.set_value (height)
			preferences.misc_data.preference_window_width_preference.set_value (width)
			Precursor
		end

	hide is
			-- Window was closed through cancel button
		do
			preferences.misc_data.preference_window_height_preference.set_value (height)
			preferences.misc_data.preference_window_width_preference.set_value (width)
			Precursor
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_PREFERENCES_WINDOW
