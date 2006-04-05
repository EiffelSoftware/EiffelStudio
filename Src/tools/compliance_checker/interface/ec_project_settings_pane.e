indexing
	description: "[
		Project settings pane to allow users to configure a compliance checking project.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_PROJECT_SETTINGS_PANE

inherit
	EC_PROJECT_SETTINGS_PANE_IMP

	EC_SHARED_PROJECT
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_equal,
			out
		end
		
	EV_KEY
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_equal,
			out
		end
		
feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_grid: like grid_reference_paths
			l_grid_processor: EV_GRID_DEFAULT_UI_PROCESSOR
		do			
			synchronize_project_with_interface
		
			--| `txt_assembly_path'
			txt_assembly_path.change_actions.extend (agent on_assembly_changed)
			
			--| `btn_browse'
			btn_browse.select_actions.extend (agent on_browse_for_assembly)
		
			--| `grid_reference_paths'
			l_grid := grid_reference_paths
			l_grid.set_column_count_to (1)
			l_grid.column (1).set_title (label_path)
			l_grid.enable_single_row_selection
			l_grid.enable_selection_key_handling
			l_grid.disable_dynamic_content
			l_grid.post_draw_overlay_actions.extend (agent on_item_post_draw)
			l_grid.row_select_actions.extend (agent on_grid_row_selection_changed (True, ?))
			l_grid.row_deselect_actions.extend (agent on_grid_row_selection_changed (False, ?))
			l_grid.resize_actions.extend (agent on_grid_resize)
			l_grid.virtual_size_changed_actions.extend (agent on_grid_resize (0, 0, ?, ?))
			l_grid.set_separator_color ((create {EV_STOCK_COLORS}).grey)
			l_grid.enable_row_separators
			l_grid.header.first.disable_user_resize
			l_grid.key_release_actions.extend (agent on_grid_key_released)
			
			create l_grid_processor.make (l_grid)
			
			--| `btn_add_reference'
			btn_add_reference.select_actions.extend (agent on_add_selected)
			
			--| `btn_remove_reference'
			btn_remove_reference.select_actions.extend (agent on_remove_selected)
			btn_remove_reference.disable_sensitive
			
			show_hide_assembly_error_pixmap
		end

feature -- Access

	owner_window: EC_MAIN_WINDOW assign set_owner_window
			-- Owner window

feature -- Element change

	set_owner_window (an_owner_window: like owner_window) is
			-- Set `owner_window' to `an_owner_window'.
		do
			owner_window := an_owner_window
		ensure
			owner_window_assigned: owner_window = an_owner_window
		end

feature -- Basic Operation

	synchronize_project_with_interface is
			-- Synchronized user interface with project settings
		local
			l_cursor: CURSOR
			l_list: LIST [STRING]
			l_grid: like grid_reference_paths
		do
			txt_assembly_path.set_text (project.assembly)
			l_list := project.reference_paths

			l_cursor := l_list.cursor
			l_grid := grid_reference_paths
			from 
			until
				l_grid.row_count = 0
			loop
				l_grid.remove_row (1)
			end
			
			from
				l_list.start
			until
				l_list.after
			loop
				add_reference_path (l_list.item)
				l_list.forth
			end
			l_list.go_to (l_cursor)
		end

feature {NONE} -- Agent Handlers

	on_assembly_changed is
			-- Called when `txt_assembly_path' text changes.
		require
			txt_assembly_path_not_void: txt_assembly_path /= Void
		do
			project.set_assembly (txt_assembly_path.text)
			show_hide_assembly_error_pixmap
		end
		
	on_browse_for_assembly is
			-- Called when user selected to browse for an assembly.
		require
			txt_assembly_path_not_void: txt_assembly_path /= Void
			owner_window_not_void: owner_window /= Void
		local
			l_ofd: EV_FILE_OPEN_DIALOG
			l_dir: like sticky_assembly_path
			l_file_name: STRING
		do
			create l_ofd
			l_ofd.set_title (title_browse_for_assembly)
			l_ofd.filters.extend ([filter_assembly, filter_name_assembly])
			l_ofd.filters.extend ([filter_all_files, filter_name_all_files])
			l_dir := sticky_assembly_path
			if l_dir /= Void then
				l_ofd.set_start_directory (l_dir)
			end
			
			l_ofd.show_modal_to_window (owner_window)
			l_file_name := l_ofd.file_name
			if l_file_name /= Void and then not l_file_name.is_empty then
				sticky_assembly_path := l_ofd.file_path
				txt_assembly_path.set_text (l_file_name)
				txt_assembly_path.set_caret_position (l_file_name.count + 1)
			end
		end
		
	sticky_assembly_path: STRING
			-- Last assembly path directory		
				
	on_grid_row_selection_changed (a_selected: BOOLEAN; a_row: EV_GRID_ROW) is
			-- Called when selection changes in `grid_reference_paths'.
			-- `a_selected' indicates a selection or deselection.
		require
			grid_reference_paths_not_void: grid_reference_paths /= Void
		local
			l_grid: like grid_reference_paths
			l_selected_row: ARRAYED_LIST [EV_GRID_ROW]
		do
			if a_selected then
				btn_remove_reference.enable_sensitive
			else
				l_grid := grid_reference_paths
				l_selected_row := l_grid.selected_rows
				if not l_selected_row.is_empty then
					btn_remove_reference.enable_sensitive
				else
					btn_remove_reference.disable_sensitive
				end
			end
		end
		
	on_grid_key_released (a_key: EV_KEY) is
			-- Called when user presses key on focused item in `grid_reference_paths'
		require
			a_key_not_void: a_key /= Void
		local
			l_rows: ARRAY [EV_GRID_ROW]
			l_item: EV_GRID_EDITABLE_ITEM
		do
			inspect a_key.code
			
			when key_f2 then
				l_rows := grid_reference_paths.selected_rows
				if l_rows.count > 0 then
					l_item ?= (l_rows[1]).item (1)
					check
						l_item_not_void: l_item /= Void
					end
					if l_item /= Void then
						l_item.ensure_visible
						active_reference_text := l_item.text
						l_item.activate	
						l_item.text_field.select_all
					end
				end
			when key_delete then
				on_remove_selected
			else
				--| Do nothing...	
			end
		end
		
	on_item_post_draw (a_drawable: EV_DRAWABLE; a_item: EV_GRID_ITEM; a_column: INTEGER; a_row: INTEGER) is
			-- Called after a item has been drawn.
		do
			if a_item /= Void then
				a_drawable.draw_pixmap (a_item.column.width - 17, 0, icon_open)
			end
		end
		
	on_grid_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Called when `grid_reference_paths' resizes
		local
			l_grid: like grid_reference_paths
		do
			l_grid := grid_reference_paths
			l_grid.virtual_size_changed_actions.block
			l_grid.column (1).set_width (l_grid.viewable_width - 1)
			l_grid.virtual_size_changed_actions.resume
		end		
		
	on_browse_path (a_item: EV_GRID_EDITABLE_ITEM; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Called when user selects to browse for an existing path (using folder icon on grid item)
		require
			a_item_not_void: a_item /= Void
		local
			l_dir: like browse_for_reference_path
		do
			if a_button = 1 then
				if a_x > grid_reference_paths.viewable_width - 18 then
					l_dir := browse_for_reference_path
					if l_dir /= Void then
						if not project.reference_paths.has (l_dir) then
							project.replace_reference_path (a_item.text, l_dir)
							a_item.set_text (l_dir)
							set_path_pixmap (a_item, l_dir)
						else							
							display_already_added_error	
						end
					end
				end
			end	
		end
		
	on_double_click_reference_path (a_item: EV_GRID_EDITABLE_ITEM; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Called when user double left clicks on reference path item in `grid_reference_paths'.
		require
			a_item_not_void: a_item /= Void
		do
			if a_button = 1 then
				active_reference_text := a_item.text
				a_item.activate
				a_item.text_field.select_all
			end
		end
		
	on_end_edit_reference_path (a_item: EV_GRID_EDITABLE_ITEM) is
			-- Called when editable edit session reference path has ended.
		require
			a_item_not_void: a_item /= Void
			active_reference_text_not_void: active_reference_text /= Void
			not_active_reference_text_is_empty: not active_reference_text.is_empty
		local
			l_text: STRING
			l_old_text: like active_reference_text
		do
			l_text := a_item.text
			if not l_text.is_empty and then l_text.item (l_text.count) = '\' then
				l_text.prune_all_trailing ('\')
				a_item.set_text (l_text)
			end
			l_old_text := active_reference_text
			if not l_text.is_equal (l_old_text) then
				if l_text.is_empty then
					grid_reference_paths.remove_row (a_item.row.index)
					project.remove_reference_path (l_old_text)
				elseif not project.reference_paths.has (l_text) then
					project.replace_reference_path (l_old_text, l_text)
					set_path_pixmap (a_item, l_text)
				else
					display_already_added_error
					a_item.set_text (l_old_text)
				end	
			end
			active_reference_text := Void
		end	
		
	on_reference_path_pointer_move (a_item: EV_GRID_EDITABLE_ITEM; a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Called when mouse moved over grid item.
		do
			if a_x > a_item.column.width - 18 then
				a_item.set_tooltip (tooltip_browse_for_reference_path)
			elseif a_x <= 18 and a_item.pixmap = icon_error then
				a_item.set_tooltip (tooltip_reference_path_not_found)
			else
				a_item.set_tooltip ("")
			end
		end

	on_add_selected is
			-- Called when `btn_add' is selected.
		local
			l_dir: like browse_for_reference_path
			l_project: like project
		do
			l_dir := browse_for_reference_path
			if l_dir /= Void then
				l_project := project
				if not l_project.reference_paths.has (l_dir) then
					l_project.add_reference_path (l_dir)
					add_reference_path (l_dir)
				else					
					display_already_added_error
				end
			end
		end
		
	on_remove_selected is
			-- Called when `btn_remove' is selected.
		require
			grid_reference_paths_not_void: grid_reference_paths /= Void
		local
			l_grid: like grid_reference_paths
			l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_project: like project
			l_row: EV_GRID_ROW
			l_item: EV_GRID_EDITABLE_ITEM
			i: INTEGER
		do
			l_grid := grid_reference_paths
			l_selected_rows := l_grid.selected_rows
			if not l_selected_rows.is_empty then
				i := (l_selected_rows.first.index - 1).max (1)
				l_project := project
				from
					l_selected_rows.start
				until
					l_selected_rows.after
				loop
					l_row := l_selected_rows.item
					l_item ?= l_row.item (1)
					check
						l_item_not_void: l_item /= Void
					end
					if l_item /= Void then
						l_project.remove_reference_path (l_item.text)
					end
					l_grid.remove_row (l_row.index)
					l_selected_rows.forth
				end
				if l_grid.row_count > 0 then
					i := i.min (l_grid.row_count)
					l_grid.row (i).enable_select
				end
			end
		end

feature {NONE} -- Implementation

	show_hide_assembly_error_pixmap is
			-- Shows or hides assembly cannot be found error pixmap based on `txt_assembly_path'
		require
			pixm_assembly_cannot_be_found_not_void: pixm_assembly_cannot_be_found /= Void
			txt_assembly_path_not_void: txt_assembly_path /= Void
		local
			l_text: STRING
		do
			l_text := txt_assembly_path.text
			if not l_text.is_empty and then (create {RAW_FILE}.make (l_text)).exists then
				pixm_assembly_cannot_be_found.hide
			else
				pixm_assembly_cannot_be_found.show
			end
		end

	add_reference_path (a_path: STRING) is
			-- Addes `a_path' to `grid_reference_paths'
		require
			a_path_not_void: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
			grid_reference_paths_not_void: grid_reference_paths /= Void
		local
			l_grid: like grid_reference_paths
			l_edit_item: EV_GRID_EDITABLE_ITEM
			i: INTEGER
		do
			l_grid := grid_reference_paths
			i := l_grid.row_count + 1
			l_grid.insert_new_row (i)
			
			create l_edit_item.make_with_text (a_path)
			l_grid.set_item (1, i, l_edit_item)
			l_edit_item.pointer_double_press_actions.extend (agent on_double_click_reference_path (l_edit_item, ?, ?, ?, ?, ?, ?, ?, ?))
			l_edit_item.pointer_button_release_actions.extend (agent on_browse_path (l_edit_item, ?, ?, ?, ?, ?, ?, ?, ?))
			l_edit_item.deactivate_actions.extend (agent on_end_edit_reference_path (l_edit_item))
			l_edit_item.pointer_motion_actions.extend (agent on_reference_path_pointer_move (l_edit_item, ?, ?, ?, ?, ?, ?, ?))
			set_path_pixmap (l_edit_item, a_path)
			l_edit_item.set_right_border (18)
			if i = 1 then
				l_edit_item.row.enable_select	
			end
		end

	browse_for_reference_path: STRING is
			-- Browses for a reference path folder
		local
			l_dd: EV_DIRECTORY_DIALOG
			l_dir: STRING
		do
			create l_dd
			l_dd.set_title ("")
			if sticky_path /= Void then
				l_dd.set_start_directory (sticky_path)
			end
			l_dd.show_modal_to_window (owner_window)
			l_dir := l_dd.directory
			if l_dir /= Void and then not l_dir.is_empty then
				Result := l_dir
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty 
		end
	
	set_path_pixmap (a_item: EV_GRID_EDITABLE_ITEM; a_dir: STRING) is
			-- Sets pixmaps for `a_item' base on validity of `a_dir'
		require
			a_item_not_void: a_item /= Void
			a_dir_not_void: a_dir /= Void
			not_a_dir_is_empty: not a_dir.is_empty
		do
			if (create {DIRECTORY}.make (a_dir)).exists then
				a_item.set_pixmap (icon_blank)
			else
				a_item.set_pixmap (icon_error)
			end
		end

	sticky_path: STRING 
			-- Last selected path
			
	active_reference_text: STRING
			-- Text take from activated editable item when first activated
		
feature {NONE} -- Dialogs

	display_already_added_error is
			-- Displays already added dialog box.
		local
			l_error: EV_ERROR_DIALOG
		do
			create l_error.make_with_text (error_already_added)
			l_error.set_buttons (<<button_okay>>)
			l_error.set_default_cancel_button (l_error.button (button_okay))
			l_error.show_relative_to_window (owner_window)
		end

invariant
	owner_window_not_void: owner_window /= Void

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
end -- class EC_PROJECT_SETTINGS_PANE

