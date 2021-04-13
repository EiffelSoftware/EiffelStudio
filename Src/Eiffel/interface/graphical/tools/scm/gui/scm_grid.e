note
	description: "Summary description for {SCM_GRID}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCM_GRID

inherit
	ES_GRID
		redefine
			initialize,
			create_interface_objects
		end

	SHARED_SOURCE_CONTROL_MANAGEMENT_SERVICE
		undefine
			default_create, copy
		end

	SCM_SHARED_RESOURCES
		undefine
			default_create, copy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create, copy
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create, copy
		end

	IDE_OBSERVER
		undefine
			default_create, copy
		redefine
			on_zoom
		end

	EB_RECYCLABLE
		undefine
			default_create, copy
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

			enable_tree
			disable_row_height_fixed
--			set_separator_color (create {EV_COLOR}.make_with_8_bit_rgb (190,190,190))
			hide_tree_node_connectors
			enable_column_separators
			enable_row_separators

			enable_single_row_selection
			enable_selection_key_handling

			resize_actions.extend (agent on_resize_action)

			key_press_actions.extend (agent  (a_key: EV_KEY)
				local
					l_row: like selected_row
					i: INTEGER
				do
					l_row := selected_row
					if l_row /= Void and then l_row.parent /= Void and ev_application.ctrl_pressed then
						inspect a_key.code
						when {EV_KEY_CONSTANTS}.key_left then
							from
								i := 1
							until
								i > row_count
							loop
								if attached {EV_GRID_ROW} row (i) as r and then r.parent_row = Void and then
									r.is_expanded
								then
									r.collapse
								end
								i := i + 1
							end
						when {EV_KEY_CONSTANTS}.key_right then
							from
								i := 1
							until
								i > row_count
							loop
								if attached {EV_GRID_ROW} row (i) as r2 and then r2.parent_row = Void and then
									r2.is_expandable and then not r2.is_expanded
								then
									r2.expand
								end
								i := i + 1
							end
--							when {EV_KEY_CONSTANTS}.key_numpad_subtract then
----								if l_row.parent_row = Void then
----									remove_feature_clause (l_row)
----								end
--							when {EV_KEY_CONSTANTS}.key_numpad_add then
----								if l_row.parent_row = Void then
----									insert_feature_clause (l_row)
----								end
						else
						end
					end
				end)

			row_deselect_actions.extend (agent  (a_row: EV_GRID_ROW)
				do
					selected_row := Void
				end)

			row_select_actions.extend (agent  (a_row: EV_GRID_ROW)
				do
					if a_row /= Void and then a_row.parent /= Void then
						selected_row := a_row
					else
						selected_row := Void
					end
				end)

			set_item_pebble_function (agent  (gi: EV_GRID_ITEM): ANY do Result := gi.row end)

			setup_grid

			register_as_ide_observer
		end

feature -- Factory

	set_label_item (a_lab: EV_GRID_LABEL_ITEM)
		do
			a_lab.set_font (grid_font)
		end

	new_label_item (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			if a_text /= Void then
				create Result.make_with_text (a_text)
			else
				create Result
			end
			set_label_item (Result)
		end

	add_new_span_label_item_to (a_text: detachable READABLE_STRING_GENERAL; a_master_column: INTEGER; a_span_columns: ITERABLE [INTEGER]; a_row: EV_GRID_ROW)
		require
			a_row /= Void and then not a_row.is_destroyed
			row_parent_is_current: a_row.parent = Current
		local
			span: EV_GRID_SPAN_LABEL_ITEM
		do
			if a_text /= Void then
				create span.make_master_with_text (a_master_column, a_text)
			else
				create span.make_master (a_master_column)
			end
			span.set_font (grid_font)
			a_row.set_item (a_master_column, span)
			across
				a_span_columns as ic
			loop
				a_row.set_item (ic.item, create {EV_GRID_SPAN_LABEL_ITEM}.make_span (a_master_column))
			end
		end

	new_checkable_label_item (a_text: detachable READABLE_STRING_GENERAL): EV_GRID_CHECKABLE_LABEL_ITEM
		do
			if a_text /= Void then
				create Result.make_with_text (a_text)
			else
				create Result
			end
			set_label_item (Result)
		end

feature {NONE} -- Grid preferences

	grid_preferences: EB_GRID_PREFERENCES

	grid_font: EV_FONT

	load_grid_preferences_agent: PROCEDURE

	setup_grid
		local
			agt: PROCEDURE
		do
			agt := agent load_grid_preferences
			load_grid_preferences_agent := agt

			register_action (grid_preferences.change_actions, agt)

			load_grid_preferences
		end

	load_grid_preferences
		local
			prefs: like grid_preferences
			ft: EV_FONT
		do
			prefs := grid_preferences
			grid_font := prefs.font_with_zoom_factor

			ft := bold_font
			if ft = Void then
				ft := grid_font.twin
				ft.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				bold_font := ft
			end
			ft.set_height_in_points (grid_font.height_in_points)

			prefs.apply_to (Current)
		end

feature -- Access

	bold_font: EV_FONT

	selected_row: detachable EV_GRID_ROW

feature -- IDE Events

	on_zoom (a_zoom_factor: INTEGER)
		do
			grid_preferences.set_zoom_factor (a_zoom_factor)
		end

	open_directory_location (a_location: PATH)
		local
			l_loc_name: READABLE_STRING_32
			l_cmd: STRING_32
			l_target: STRING_32
		do
			if attached preferences.misc_data.file_browser_command as cmd then
				l_loc_name := a_location.name
				create l_target.make (2 + l_loc_name.count)
				l_target.append_character ('%"')
				l_target.append_string_general (l_loc_name)
				l_target.append_character ('%"')
				create l_cmd.make_from_string (cmd)
				l_cmd.replace_substring_all ("$target", l_target)
				execution_environment.launch (l_cmd)
			end
		end

	open_file_location (a_location: PATH)
			-- Open directory `a_full_path' in file browser and select the file
		local
			l_cmd: STRING_32
			l_platform: PLATFORM
			l_path: STRING_32
		do
			if attached preferences.misc_data.file_browser_command as cmd then
				l_path := a_location.name

				create l_platform
				if l_platform.is_windows then
					-- We add argument to select file
					l_path	:= {STRING_32} "/select,%"" + l_path + {STRING_32} "%""
				elseif l_platform.is_unix then
					-- "nautilus" don't accept last file name, we removed it here
					-- We should find a way to select file in "nautilus" file browser like Windows explorer does
					l_path := a_location.parent.name
				end
				create l_cmd.make_from_string (cmd)
				l_cmd.replace_substring_all ({STRING_32} "$target", l_path)
				execution_environment.launch (l_cmd)
			end
		end

feature -- Event

	on_resize_action (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
		do
		end

feature {NONE} -- Internal memory management

	internal_recycle
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			unregister_action (grid_preferences.change_actions, load_grid_preferences_agent)
		end

invariant

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
