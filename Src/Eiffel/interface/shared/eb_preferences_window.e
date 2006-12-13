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
			on_window_resize,
			on_restore,
			update_grid_columns,
			preference_name_column,
			preference_value_column,
			grid,
			build_filter_icons,
			try_to_translate,

				-- Interface names
			l_name,
			l_literal_value,
			l_status,
			l_type,
			l_request_restart,
			p_default_value,
			user_value,
			auto_value,
			no_description_text,
			preferences_title,
			restore_preference_string,
			w_Preferences_delayed_resources,
			l_tree_view,
			f_switch_to_tree_view,
			l_flat_view,
			f_switch_to_flat_view,
			l_updating_the_view,
			l_filter,
			l_tree_or_flat_view,
			l_restore_defaults,
			l_close,
			l_display_window,
			l_description,
			l_matches_of_total_preferences,
			l_count_preferences,
			l_restore_default,
			l_no_default_value,
			l_building_flat_view,
			l_building_tree_view
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

	EB_CONSTANTS
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
			set_root_icon (icon_pixmaps.tool_preferences_icon)
			set_folder_icon (icon_pixmaps.folder_preference_icon)
			Precursor {PREFERENCES_GRID} (a_preferences, a_parent_window)
			set_icon_pixmap (icon_pixmaps.tool_preferences_icon)
			register_preference_widget (create {IDENTIFIED_FONT_PREFERENCE_WIDGET}.make)
			close_request_actions.extend (agent on_close)

			grid.enable_default_tree_navigation_behavior (True, True, True, True)
		end

	scrolling_behavior: ES_GRID_SCROLLING_BEHAVIOR
	resizing_behavior: ES_GRID_RESIZING_BEHAVIOR

	preference_name_column (a_pref: PREFERENCE): EV_GRID_LABEL_ITEM is
			--
		local
			l_bp: BOOLEAN_PREFERENCE
			l_sp: STRING_PREFERENCE
			l_ip: INTEGER_PREFERENCE
			l_cp: COLOR_PREFERENCE
			l_lp: ARRAY_PREFERENCE
			l_fp: FONT_PREFERENCE
			l_ifp: IDENTIFIED_FONT_PREFERENCE
			l_scp: SHORTCUT_PREFERENCE
		do
			Result := Precursor {PREFERENCES_GRID}(a_pref)
			if Result /= Void then
				l_bp ?= a_pref
				if l_bp = Void then
					l_ip ?= a_pref
					if l_ip = Void then
						l_sp ?= a_pref
						if l_sp = Void then
							l_cp ?= a_pref
							if l_cp = Void then
								l_fp ?= a_pref
								if l_fp = Void then
									l_ifp ?= a_pref
									if l_ifp = Void then
										l_lp ?= a_pref
										if l_lp = Void then
											l_scp ?= a_pref
											if l_scp /= Void then
												Result.set_pixmap (icon_pixmaps.preference_shortcut_icon)
											else
												check False end
											end
										else
											Result.set_pixmap (icon_pixmaps.preference_list_icon)
										end
									else
										Result.set_pixmap (icon_pixmaps.preference_font_icon)
									end
								else
									Result.set_pixmap (icon_pixmaps.preference_font_icon)
								end
							else
								Result.set_pixmap (icon_pixmaps.preference_color_icon)
							end
						else
							Result.set_pixmap (icon_pixmaps.preference_string_icon)
						end
					else
						Result.set_pixmap (icon_pixmaps.preference_numerical_icon)
					end
				else
					Result.set_pixmap (icon_pixmaps.preference_boolean_icon)
				end
			end
		end


	preference_value_column (a_pref: PREFERENCE): EV_GRID_ITEM is
			--
		local
			l_id_font: IDENTIFIED_FONT_PREFERENCE
			l_font_widget: IDENTIFIED_FONT_PREFERENCE_WIDGET
		do
			l_id_font ?= a_pref
			if l_id_font /= Void then
				create l_font_widget.make_with_preference (l_id_font)
				l_font_widget.change_actions.extend (agent on_preference_changed)
				l_font_widget.set_caller (Current)
				Result := l_font_widget.change_item_widget
				Result.set_data (l_font_widget)
			else
				Result := Precursor {PREFERENCES_GRID} (a_pref)
			end
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

feature {NONE} -- Names

	l_name: STRING_GENERAL is							do Result := interface_names.l_name								end
	l_literal_value: STRING_GENERAL is					do Result := interface_names.l_Literal_value					end
	l_status: STRING_GENERAL is							do Result := interface_names.l_status							end
	l_type: STRING_GENERAL is							do Result := interface_names.l_type								end
	l_request_restart: STRING_GENERAL is				do Result := interface_names.l_request_restart					end
	p_default_value: STRING_GENERAL is					do Result := interface_names.l_default							end
	user_value: STRING_GENERAL is						do Result := interface_names.l_user_set							end
	auto_value: STRING_GENERAL is						do Result := interface_names.l_auto								end
	no_description_text: STRING_GENERAL is				do Result := interface_names.l_no_description_text				end
	preferences_title: STRING_GENERAL is				do Result := interface_names.t_preference_window				end
	restore_preference_string: STRING_GENERAL is		do Result := interface_names.l_restore_preference_string		end
	w_Preferences_delayed_resources: STRING_GENERAL is	do Result := interface_names.l_preferences_delayed_resources	end
			-- Texts used in the dialog that tells the user
			-- they have to restart the application to use the new preferences.


	l_tree_view: STRING_GENERAL is						do Result := interface_names.l_Tree_view						end
	f_switch_to_tree_view: STRING_GENERAL is 			do Result := interface_names.f_switch_to_tree_view				end
	l_flat_view: STRING_GENERAL is						do Result := interface_names.l_Flat_view 						end
	f_switch_to_flat_view: STRING_GENERAL is 			do Result := interface_names.f_switch_to_flat_view				end
	l_updating_the_view: STRING_GENERAL is 				do Result := interface_names.l_update_the_view					end
	l_filter: STRING_GENERAL is							do Result := interface_names.l_filter 							end
	l_tree_or_flat_view: STRING_GENERAL					do Result := interface_names.l_tree_or_flat_view 				end
	l_restore_defaults: STRING_GENERAL 					do Result := interface_names.l_restore_defaults 				end
	l_restore_default: STRING_GENERAL					do Result := interface_names.l_restore_default 					end
	l_no_default_value: STRING_GENERAL 					do Result := interface_names.l_no_default_value 				end
	l_close: STRING_GENERAL								do Result := interface_names.b_close 							end
	l_display_window: STRING_GENERAL 					do Result := interface_names.l_display_window 					end
	l_description: STRING_GENERAL						do Result := interface_names.l_description 						end
	l_building_flat_view: STRING_GENERAL				do Result := interface_names.l_building_flat_view 				end
	l_building_tree_view: STRING_GENERAL				do Result := interface_names.l_building_tree_view 				end

	l_matches_of_total_preferences (a_count: STRING_GENERAL; a_total_count: STRING_GENERAL): STRING_GENERAL is
		do
			Result := interface_names.l_matches_of_total_preferences (a_count, a_total_count)
		end

	l_count_preferences (a_count: STRING_GENERAL): STRING_GENERAL is
		do
			Result := interface_names.l_count_preferences (a_count)
		end

feature {NONE} -- Events

	on_window_resize is
			-- Dialog was resized
		local
			l_width: INTEGER
		do
			l_width := grid.width - (grid.column (1).width + grid.column (2).width + grid.column (3).width)
		end

	on_restore is
			-- Restore all preferences to their default values.
		local
			l_confirmation_dialog: EB_CONFIRMATION_DIALOG
		do
			create l_confirmation_dialog
			l_confirmation_dialog.set_text (restore_preference_string)
			l_confirmation_dialog.show_modal_to_window (parent_window)
			if l_confirmation_dialog.selected_button.is_equal (l_confirmation_dialog.ok) then
				view_preferences.restore_defaults
			end
		end

feature {NONE} -- Implementation

	grid: ES_GRID
			-- Grid

	build_filter_icons is
		do
			icon_up := icon_pixmaps.sort_acending_icon
			icon_down := icon_pixmaps.sort_descending_icon
		end

	update_grid_columns is
			-- Update the grid columns widths and borders depending on current display type
		local
			l_preference: PREFERENCE
			nb: INTEGER
		do
			if grid.is_tree_enabled then
					-- If structured view is enabled then we autosize the columns
				Precursor
			end
			grid.ev_application.process_events
			nb := grid.row_count
			if nb > 0 then
				grid.row (1).enable_select
				on_window_resize
				l_preference ?= grid.row (1).data
				if l_preference /= Void then
					show_preference_description (l_preference)
				end
				if grid.is_displayed and grid.is_sensitive then
					grid.set_focus
				end
			end
		end

	try_to_translate (a_string: STRING_GENERAL): STRING_GENERAL is
			-- Try to translate `a_string'.
		do
			Result := interface_names.find_translation (a_string)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
