indexing
	description: "EiffelStudio preference window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES_GRID_CONTROL

inherit
	PREFERENCES_GRID_CONTROL
		rename
			preferences as view_preferences
		redefine
			make,
			on_restore,
			update_grid_columns,
			preference_name_column,
			preference_value_column,
			grid,
			build_filter_icons,
			try_to_translate,
			on_shortcut_modification_denied,
			new_boolean_widget,
			new_choice_widget,

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
			shortcut_modification_denied,
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
			l_building_tree_view,
			build_preference_name_to_display,
			build_full_name_to_display
		end

	EB_SHARED_PREFERENCES
		undefine
			copy,
			default_create
		end

	EB_SHARED_PIXMAPS
		undefine
			copy,
			default_create
		end

	SHARED_BENCH_NAMES
		undefine
			copy,
			default_create
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make, make_with_hidden

feature -- Access

	make (a_preferences: like view_preferences) is
			-- New window.  Redefined to register EiffelStudio specific preference widgets for
			-- special preference types.
		do
			set_root_icon (icon_pixmaps.tool_preferences_icon)
			set_folder_icon (icon_pixmaps.folder_preference_icon)
			Precursor {PREFERENCES_GRID_CONTROL} (a_preferences)
			register_preference_widget (create {IDENTIFIED_FONT_PREFERENCE_WIDGET}.make)
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
			create Result
			Result.set_text (build_preference_name_to_display (a_pref))
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
				l_font_widget.change_actions.extend (agent on_preference_changed (?, l_font_widget))
				l_font_widget.set_caller (Current)
				Result := l_font_widget.change_item_widget
				Result.set_data (l_font_widget)
			else
				Result := Precursor {PREFERENCES_GRID_CONTROL} (a_pref)
			end
		end

feature {NONE} -- Names

	l_name: STRING_GENERAL is							do Result := names.l_name								end
	l_literal_value: STRING_GENERAL is					do Result := names.l_Literal_value					end
	l_status: STRING_GENERAL is							do Result := names.l_status							end
	l_type: STRING_GENERAL is							do Result := names.l_type								end
	l_request_restart: STRING_GENERAL is				do Result := names.l_request_restart					end
	p_default_value: STRING_GENERAL is					do Result := names.l_default							end
	user_value: STRING_GENERAL is						do Result := names.l_user_set							end
	auto_value: STRING_GENERAL is						do Result := names.l_auto								end
	no_description_text: STRING_GENERAL is				do Result := names.l_no_description_text				end
	preferences_title: STRING_GENERAL is				do Result := names.t_preference_window				end
	restore_preference_string: STRING_GENERAL is		do Result := names.l_restore_preference_string		end
	shortcut_modification_denied: STRING_GENERAL is		do Result := names.l_shortcut_modification_denied 	end
	w_Preferences_delayed_resources: STRING_GENERAL is	do Result := names.l_preferences_delayed_resources	end
			-- Texts used in the dialog that tells the user
			-- they have to restart the application to use the new preferences.

	l_tree_view: STRING_GENERAL is						do Result := names.l_Tree_view						end
	f_switch_to_tree_view: STRING_GENERAL is 			do Result := names.f_switch_to_tree_view				end
	l_flat_view: STRING_GENERAL is						do Result := names.l_Flat_view 						end
	f_switch_to_flat_view: STRING_GENERAL is 			do Result := names.f_switch_to_flat_view				end
	l_updating_the_view: STRING_GENERAL is 				do Result := names.l_update_the_view					end
	l_filter: STRING_GENERAL is							do Result := names.l_filter 							end
	l_tree_or_flat_view: STRING_GENERAL					do Result := names.l_tree_or_flat_view 				end
	l_restore_defaults: STRING_GENERAL 					do Result := names.l_restore_defaults 				end
	l_restore_default: STRING_GENERAL					do Result := names.l_restore_default 					end
	l_no_default_value: STRING_GENERAL 					do Result := names.l_no_default_value 				end
	l_close: STRING_GENERAL								do Result := names.b_close 							end
	l_display_window: STRING_GENERAL 					do Result := names.l_display_window 					end
	l_description: STRING_GENERAL						do Result := names.l_description 						end
	l_building_flat_view: STRING_GENERAL				do Result := names.l_building_flat_view 				end
	l_building_tree_view: STRING_GENERAL				do Result := names.l_building_tree_view 				end

	l_matches_of_total_preferences (a_count: INTEGER; a_total_count: INTEGER): STRING_GENERAL is
		do
			Result := names.l_matches_of_total_preferences (a_count, a_total_count)
		end

	l_count_preferences (a_count: STRING_GENERAL): STRING_GENERAL is
		do
			Result := names.l_count_preferences (a_count)
		end

feature {NONE} -- Events

	on_restore is
			-- Restore all preferences to their default values.
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (restore_preference_string, parent_window, agent view_preferences.restore_defaults, Void)
		end

feature {NONE} -- Implementation

	grid: ES_GRID
			-- Grid

	build_filter_icons is
		do
			icon_up := icon_pixmaps.sort_acending_icon
			icon_down := icon_pixmaps.sort_descending_icon
		end

	build_full_name_to_display (a_pref: STRING): STRING_32 is
			-- Build a translated full name of a preference.
		local
			l_str_32: STRING_32
			l_string: STRING
			l_list: LIST [STRING]
		do
			l_string := a_pref
			create l_str_32.make (l_string.count)
			l_list := l_string.split ('.')
			if not l_list.is_empty then
				from
					l_list.start
				until
					l_list.after
				loop
					l_str_32.append (try_to_translate (formatted_name (l_list.item)).as_string_32)
					l_list.forth
					if not l_list.after then
						l_str_32.extend ('.')
					end
				end
			end
			Result := l_str_32
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
				on_resize
				l_preference ?= grid.row (1).data
				if l_preference /= Void then
					show_preference_description (l_preference)
				end
				if grid.is_displayed and grid.is_sensitive then
					grid.set_focus
				end
			end
		end

	build_preference_name_to_display (a_pref: PREFERENCE): STRING_32 is
		local
			l_sp: STRING_PREFERENCE
			l_short_name: STRING_GENERAL
		do
			if a_pref.name /= Void then
				l_sp ?= a_pref
				if l_sp /= Void and then preferences.debug_tool_data.grid_column_layout_preferences.has_item (l_sp) then
						-- Try to translate dynamically built preference "debugger.grid_column_layout_".
					l_short_name := names.l_grid_column_layout
					l_short_name := l_short_name.as_string_32 + a_pref.name.substring (a_pref.name.last_index_of ('_', a_pref.name.count) + 1, a_pref.name.count)
					if show_full_preference_name then
						Result := try_to_translate (build_full_name_to_display (parent_preference_name (a_pref.name))).as_string_32 + "." + l_short_name
					else
						Result := l_short_name
					end
				else
					if show_full_preference_name then
						Result := build_full_name_to_display (a_pref.name)
					else
						Result := try_to_translate (formatted_name (short_preference_name (a_pref.name)))
					end
				end
			else
				create {STRING_32}Result.make_empty
			end
		end

	try_to_translate (a_string: STRING_GENERAL): STRING_GENERAL is
			-- Try to translate `a_string'.
		do
			Result := names.find_translation (a_string)
		end

	on_shortcut_modification_denied (a_shortcut_pref: SHORTCUT_PREFERENCE) is
			-- Shortcut modification denied.
		do
			prompts.show_error_prompt (shortcut_modification_denied, Void, Void)
		end

feature {NONE} -- Widget initialization

	new_boolean_widget (a_pref: BOOLEAN_PREFERENCE): BOOLEAN_PREFERENCE_WIDGET is
		do
			Result := Precursor (a_pref)
			Result.set_displayed_booleans (names.l_true, names.l_false)
		end

	new_choice_widget (a_pref: ARRAY_PREFERENCE): CHOICE_PREFERENCE_WIDGET is
		local
			l_array: ARRAY [STRING]
			l_displayed_names: HASH_TABLE [STRING_GENERAL, STRING]
		do
			Result := Precursor (a_pref)
				-- Set display names for preferences of type LIST.
			if a_pref = preferences.misc_data.locale_id_preference then
				l_array := a_pref.value
				l_displayed_names := locale_names.locales_from_array (l_array)
				l_displayed_names.force (names.l_unselected, "Unselected")
				Result.set_displayed_value (l_displayed_names)
			elseif a_pref = preferences.development_window_data.ctrl_right_click_receiver_preference then
				Result.set_displayed_value (names.c_right_click_receiver)
			elseif a_pref = preferences.search_tool_data.init_scope_preference then
				Result.set_displayed_value (names.c_init_search_scope)
			end
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
