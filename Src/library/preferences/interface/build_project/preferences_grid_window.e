indexing
	description: "[
			A EV_TITLED_WINDOW containing a tree view of application preferences.  Provides a
			list to view preference information and ability to edit the preferences.  Also allows
			to restore preferences to their defaults.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_GRID_WINDOW

inherit
	PREFERENCES_GRID_WINDOW_IMP
		redefine
			destroy
		end

	PREFERENCE_VIEW		
		undefine
			copy, default_create
		redefine
			make
		end
		
	PREFERENCE_CONSTANTS
		undefine
			copy, default_create
		end
	
create
	make

feature {NONE} -- Initialization

	make (a_preferences: like preferences; a_parent_window: like parent_window) is
			-- New view.
		do
			default_create
			preferences := a_preferences
			parent_window := Current
			root_node_text := "Preferences root"
			set_size (640, 460)
			fill_list
			create grid
			grid.enable_row_height_fixed
			grid.enable_single_row_selection
			grid_container.extend (grid)
			grid.set_item (4, 1, Void)
			grid.column (1).set_title (l_name)
			grid.column (1).set_width (220)
			grid.column (2).set_title (l_type)
			grid.column (3).set_title (l_status)
			grid.column (4).set_title (l_literal_value)
			grid.resize_actions.force_extend (agent autosize_list_columns)
			close_button.select_actions.extend (agent on_close)
			restore_button.select_actions.extend (agent on_restore)
			l_ev_vertical_split_area_1.set_split_position (250)
			show			
		end

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do			
		end

feature -- Status Setting

	set_show_full_resource_name (a_flag: BOOLEAN) is
			-- Set 'show_full_resource_name'
		do
			show_full_resource_name := a_flag	
		end		

	set_root_icon (a_icon: EV_PIXMAP) is
			-- Set the root node icon
		require
			icon_not_void: a_icon /= Void
		do
			root_icon := a_icon
		end		
		
	set_folder_icon (a_icon: EV_PIXMAP) is
			-- Set the folder node icon
		require
			icon_not_void: a_icon /= Void
		do
			folder_icon := a_icon
		end
		
feature {NONE} -- Events

	on_close is
			-- Close button has been pushed: apply the changes then close
			-- the Preferences Window.
		do
			preferences.save_resources
			hide
		end 

	on_item_value_changed (a_item: EV_GRID_ITEM; a_pref: PREFERENCE) is
			-- Set the resource value to the newly entered value in the edit item.
		local
			l_text_item: EV_GRID_EDITABLE_ITEM
			l_combo_item: EV_GRID_COMBO_ITEM			
			l_default_item: EV_GRID_LABEL_ITEM
		do
			l_text_item ?= a_item
			if l_text_item /= Void then
				a_pref.set_value_from_string (l_text_item.text)
			else
				l_combo_item ?= a_item
				if l_combo_item /= Void then
						-- TODO: waiting for fix in EV_GRIS_COMBO_ITEM to make sure this is not user editable.
					a_pref.set_value_from_string (l_combo_item.text)
				end
			end

			l_default_item ?= a_item.row.item (3)
			if a_pref.is_default_value then
				l_default_item.set_text ("default")
				l_default_item.row.set_foreground_color (default_color)
			else
				l_default_item.set_text ("user set")
				l_default_item.row.set_foreground_color (non_default_color)
			end
		end	

	on_set_resource_default (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE) is
			-- Set the resource value to the original default.
		local
			l_text_item: EV_GRID_EDITABLE_ITEM
			l_combo_item: EV_GRID_COMBO_ITEM
			l_label_item: EV_GRID_LABEL_ITEM
			l_color_item: EV_GRID_DRAWABLE_ITEM
			l_font: FONT_PREFERENCE
		do
			a_pref.reset
			a_item.set_text ("default")
			a_item.row.set_foreground_color (default_color)

			l_text_item ?= a_item.row.item (4)
			if l_text_item /= Void then
					-- Editable text item
				l_text_item.set_text (a_pref.string_value)
			else
				l_combo_item ?= a_item.row.item (4)
				if l_combo_item /= Void then
						-- Combo selectable item
					l_combo_item.set_text (a_pref.string_value)
				else
					l_color_item ?= a_item.row.item (4)
					if l_color_item /= Void then
							-- Color drawable item
						l_color_item.redraw
					else
						l_label_item ?= a_item.row.item (1)
						if l_label_item /= Void and then a_pref.generating_resource_type.is_equal ("FONT") then
								-- Font label item
							l_font ?= a_pref
							l_label_item ?= a_item.row.item (4)
							l_label_item.set_text (l_font.string_value)
							l_label_item.set_font (l_font.value)
						end
					end
				end
			end
		end	

	on_restore is
			-- Restore all preferences to their default values.
		local
			l_confirmation_dialog: EV_CONFIRMATION_DIALOG
		do
			create l_confirmation_dialog
			l_confirmation_dialog.set_text ("This will reset ALL preferences to their default values%N%
				% and all previous settings will be overwritten.  Are you sure?")
			l_confirmation_dialog.show_modal_to_window (parent_window)
			if l_confirmation_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				preferences.restore_defaults
				if selected_resource_name /= Void then
					fill_right_list (selected_resource_name)	
				end
			end
		end

	on_default_item_selected (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE; a_x: INTEGER; a_button: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		local
			l_popup_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
		do
			if not a_pref.is_default_value and then a_button = 3 then
				create l_popup_menu
				create l_menu_item.make_with_text ("Restore Default")
				l_menu_item.select_actions.extend (agent on_set_resource_default (a_item, a_pref))
				l_popup_menu.extend (l_menu_item)
				l_popup_menu.show_at (grid, a_x + a_item.virtual_x_position, a_screen_y - Current.screen_y)
			end
		end

	on_item_selected (a_item: EV_GRID_ITEM; a_pref: PREFERENCE) is
		local
			bool_pref: BOOLEAN_PREFERENCE
			color_pref: COLOR_PREFERENCE
			font_pref: FONT_PREFERENCE
			l_color_widget: COLOR_PREFERENCE_WIDGET
			l_font_widget: FONT_PREFERENCE_WIDGET
			l_label_item: EV_GRID_LABEL_ITEM
			l_edit_item: EV_GRID_EDITABLE_ITEM
			l_combo_item: EV_GRID_COMBO_ITEM
		do
			if a_pref.generating_resource_type.is_equal ("TEXT") then
				l_edit_item ?= a_item
				if l_edit_item /= Void then
					l_edit_item.activate
				end
			else
				bool_pref ?= a_pref
				if bool_pref /= Void then
					l_combo_item ?= a_item
					if l_combo_item /= Void then
						l_combo_item.activate
					end
				else
					color_pref ?= a_pref
					if color_pref /= Void then
						l_color_widget ?= resource_widget (color_pref)
						l_color_widget.set_caller (Current)
						l_color_widget.change
						if l_color_widget.last_selected_value /= Void then
							color_pref.set_value (l_color_widget.last_selected_value)
						end
						on_item_value_changed (a_item, a_pref)
					else
						font_pref ?= a_pref
						if font_pref /= Void then
							l_label_item ?= a_item
							l_font_widget ?= resource_widget (font_pref)
							l_font_widget.set_resource (font_pref)
							l_font_widget.set_caller (Current)
							l_font_widget.change
							if l_font_widget.last_selected_value /= Void then
								font_pref.set_value (l_font_widget.last_selected_value)
							end
							l_label_item.set_font (font_pref.value)
							l_label_item ?= a_item.row.item (4)
							l_label_item.set_text (font_pref.string_value)
							on_item_value_changed (a_item, a_pref)
						end
					end
				end
			end
		end

	on_color_item_exposed (a_item: EV_GRID_ITEM; area: EV_DRAWABLE) is
			-- Expose part of color preference value item.
		local
			l_resource: COLOR_PREFERENCE
		do
			l_resource ?= a_item.data
			if l_resource /= Void then
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.fill_rectangle (0, 0, a_item.width, a_item.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				area.draw_rectangle (1, 1, 12, 12)
				area.set_foreground_color (l_resource.value)
				area.fill_rectangle (2, 2, 10, 10)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				area.draw_text_top_left (20, 1, l_resource.string_value)
			end	
		end		

	autosize_list_columns is
			-- Autosize the last column in the list to fit to the size of the list
		local
			l_width: INTEGER
		do
			if grid.column_count > 0 then
				l_width := grid.column (1).width + grid.column (2).width + grid.column (3).width
				if grid.width - l_width > 0 then
			  		grid.column (4).set_width (grid.width - l_width)
				end
			end
		end

feature {NONE} -- Implementation

	fill_list is
			-- Fill left tree.
		local
 			it,
 			l_parent: EV_TREE_ITEM
			l_pref_hash: HASH_TABLE [EV_TREE_ITEM, STRING]
			l_known_pref_hash: HASH_TABLE [PREFERENCE, STRING]
			l_pref_name,
			l_pref_parent_name,
			l_pref_parent_full_name,
			l_prev_parent_name,
			l_pref_parent_short_name: STRING
			l_node_count,
			l_index: INTEGER
			
			l_sorted_preferences: SORTED_TWO_WAY_LIST [STRING]
			l_split_string: LIST [STRING]
		do
				-- Retrieve known preferences
			l_known_pref_hash := preferences.resources
			
			if not l_known_pref_hash.is_empty then				
				create l_pref_hash.make (l_known_pref_hash.count)
					
					-- Alphabetically sort the known preferences
				create l_sorted_preferences.make
				l_sorted_preferences.compare_objects
				l_sorted_preferences.append (create {ARRAYED_LIST [STRING]}.make_from_array (l_known_pref_hash.current_keys))			
				l_sorted_preferences.sort
				
					-- Generate a root node
				create it.make_with_text (formatted_name (root_node_text))
				if root_icon /= Void then
					it.set_pixmap (root_icon)
				end
				it.select_actions.extend (agent clear_edit_widget)
				it.select_actions.extend (agent fill_right_list (root_node_text))
				l_pref_hash.put (it, root_node_text)
				left_list.extend (it)
				
					-- Traverse the preferences in the system
				from
					l_sorted_preferences.finish
				until
					l_sorted_preferences.before
				loop
					l_pref_name := l_sorted_preferences.item
					l_pref_hash.put (it, l_pref_name)
					if l_pref_name.has ('.') then
						  -- Build parent nodes	as this preference is of the form 'a.b.c' so we must build 'a' and 'b'.
						l_pref_parent_full_name := l_pref_name.substring (1, l_pref_name.last_index_of ('.', l_pref_name.count) - 1)
						if l_pref_parent_full_name.has ('.') then
							from			
								l_split_string := l_pref_parent_full_name.split ('.')
								l_node_count := 0
								l_index := 1
								create l_pref_parent_name.make_empty
							until																	
								l_node_count = l_split_string.count
							loop																													
								l_pref_parent_short_name := l_split_string.i_th (l_index)
								
								if not l_pref_parent_name.is_empty then											
									l_pref_parent_name.extend ('.')
								end	
								l_pref_parent_name.append (l_pref_parent_short_name)	
								l_index := l_index + 1								
								create l_parent.make_with_text (formatted_name (l_pref_parent_short_name))
								if folder_icon /= Void then
									l_parent.set_pixmap (folder_icon)
								end								
								l_parent.select_actions.extend (agent clear_edit_widget)
								l_parent.select_actions.extend (agent fill_right_list (l_pref_parent_name.twin))
								if not l_pref_hash.has (l_pref_parent_name) then
									l_pref_hash.put (l_parent, l_pref_parent_name.twin)	
									if l_prev_parent_name /= Void then																			
										l_pref_hash.item (l_prev_parent_name).put_front (l_parent)																			
									else
										l_pref_hash.item (root_node_text).put_front (l_parent)
									end
								end																								
								l_prev_parent_name := l_pref_parent_name.twin
								l_node_count := l_node_count + 1
							end
						else
								-- We reach the end of building parent, so here we build 'a'.
							if not l_pref_hash.has (l_pref_parent_full_name) then
								create l_parent.make_with_text (formatted_name (l_pref_parent_full_name))
								if folder_icon /= Void then
									l_parent.set_pixmap (folder_icon)
								end
								l_parent.select_actions.extend (agent clear_edit_widget)
								l_parent.select_actions.extend (agent fill_right_list (l_pref_parent_full_name.twin))
								l_pref_hash.put (l_parent, l_pref_parent_full_name.twin)						
								l_pref_hash.item (root_node_text).put_front (l_parent)
								l_prev_parent_name := Void
							end		
						end						
					elseif not l_pref_hash.has (l_pref_name) then						
							-- Add as child to root node
						create it.make_with_text (formatted_name (l_pref_name))
						if folder_icon /= Void then
							it.set_pixmap (folder_icon)
						end
						it.select_actions.extend (agent clear_edit_widget)
						it.select_actions.extend (agent fill_right_list (l_pref_name.twin))
						l_pref_hash.item (root_node_text).put_front (it)
					end
					l_sorted_preferences.back
				end
			end				
		end

	fill_right_list (a_pref_name: STRING) is
			-- Fill right list.
		require
			pref_name_not_void: a_pref_name /= Void
			pref_name_not_empty: not a_pref_name.is_empty
		local		
			l_names: SORTED_TWO_WAY_LIST [STRING]
			l_pref_name: STRING
			grid_name_item,
			grid_default_item,
			grid_type_item: EV_GRID_LABEL_ITEM			
			l_resource: PREFERENCE
			curr_row: INTEGER
		do
			selected_resource_name := a_pref_name
				-- Retrieve known preferences
			create l_names.make

			l_names.append (create {ARRAYED_LIST [STRING]}.make_from_array (preferences.resources.current_keys))
			l_names.sort
			from
				l_names.start
				grid.clear
				curr_row := 1
			until
				l_names.after
			loop
				l_pref_name := l_names.item
				if should_display_preference (l_pref_name, a_pref_name) and l_pref_name.count > a_pref_name.count then					
					l_resource := preferences.resources.item (l_pref_name)
					
					if show_hidden_preferences or (not show_hidden_preferences and then not l_resource.is_hidden) then

						check
							resource_not_void: l_resource /= Void
						end

						if l_resource.name /= Void then
							create grid_name_item
							grid.set_item (1, curr_row, grid_name_item)
							if show_full_resource_name then
								grid_name_item.set_text (l_resource.name)
							else
								grid_name_item.set_text (formatted_name (short_resource_name (l_resource.name)))
							end
						else
							grid_name_item.set_text ("")
						end
						add_resource_change_item (l_resource, curr_row)
						grid.row (curr_row).set_data (l_resource)
						grid.row (curr_row).select_actions.extend (agent show_resource_description (l_resource))
						create grid_default_item
						grid_default_item.pointer_button_press_actions.extend (agent on_default_item_selected (grid_default_item, l_resource, ?, ?, ?, ?, ?, ?, ?, ?))
						grid.set_item (3, curr_row, grid_default_item)
						if l_resource.is_default_value then
							grid_default_item.set_text (default_value)
							grid_default_item.row.set_foreground_color (default_color)
						else
							grid_default_item.set_text (user_value)
							grid_default_item.row.set_foreground_color (non_default_color)
						end
						create grid_type_item
						grid_type_item.set_text (l_resource.string_type)
						grid.set_item (2, curr_row, grid_type_item)
						curr_row := curr_row + 1
					end
				end
				l_names.forth
			end
			if grid.row_count > 0 then
				grid.row (1).enable_select
			end
		end

	should_display_preference (a_pref_name, b_pref_name: STRING): BOOLEAN is
			-- Should we display the preference in the right list?
		do
			Result := a_pref_name.substring (1, b_pref_name.count).is_equal (b_pref_name)
			if Result then				
				Result := not (a_pref_name.substring (b_pref_name.count + 2, a_pref_name.count).has ('.'))
			end
		end		

feature {NONE} -- Implementation

	destroy is
			-- Destroy.
		do
			Precursor
		end

	pixmap_file_contents (pn: STRING): EV_PIXMAP is
			-- Load a pixmap in file named `pn'.
		require
			valid_file_name: pn /= Void
		local
			retried: BOOLEAN
			fullp: FILE_NAME
		do
			create Result
			if not retried then
				create fullp.make_from_string (pixmaps_path_cell.item)
				fullp.set_file_name (pn)
				fullp.add_extension (pixmaps_extension_cell.item)
				Result.set_with_named_file (fullp)
			end
		rescue
			retried := True
			retry
		end
		
	show_resource_description (a_resource: PREFERENCE) is
			-- Show selected list resource in edit widget.
		require
			resource_not_void: a_resource /= Void
		do
			if a_resource.description /= Void then
				description_text.set_text (a_resource.description)
			else
				description_text.set_text (no_description_text)
			end
		end		

	add_resource_change_item (l_resource: PREFERENCE; row_index: INTEGER) is
			-- Add the correct resource change widget item at `row_index' of `grid'
		local
			l_bool: BOOLEAN_PREFERENCE
			l_font: FONT_PREFERENCE
			l_color: COLOR_PREFERENCE
			l_bool_item: EV_GRID_COMBO_ITEM
			l_font_item: EV_GRID_LABEL_ITEM
			l_color_item: EV_GRID_DRAWABLE_ITEM
			l_string_edit_item: EV_GRID_EDITABLE_ITEM
		do
			l_bool ?= l_resource
			if l_bool /= Void then
				create l_bool_item
				l_bool_item.deactivate_actions.extend (agent on_item_value_changed (l_bool_item, l_resource))
				l_bool_item.set_text (l_bool.value.out)
				l_bool_item.set_item_strings (<<"True", "False">>)
				grid.set_item (4, row_index, l_bool_item)
				l_bool_item.pointer_button_press_actions.force_extend (agent l_bool_item.activate)
			else
				if l_resource.generating_resource_type.is_equal ("TEXT") then
					create l_string_edit_item
					l_string_edit_item.deactivate_actions.extend (agent on_item_value_changed (l_string_edit_item, l_resource))
					l_string_edit_item.set_text (l_resource.string_value)
					grid.set_item (4, row_index, l_string_edit_item)
					l_string_edit_item.pointer_button_press_actions.force_extend (agent on_item_selected (l_string_edit_item, l_resource))
				else
					l_font ?= l_resource
					if l_font /= Void then
						create l_font_item
						l_font_item.set_text (l_font.string_value)
						l_font_item.set_font (l_font.value)
						grid.set_item (4, row_index, l_font_item)
						l_font_item.pointer_button_release_actions.force_extend (agent on_item_selected (l_font_item, l_resource))
					else
						l_color ?= l_resource
						if l_color /= Void then
							create l_color_item
							l_color_item.expose_actions.extend (agent on_color_item_exposed (l_color_item, ?))
							l_color_item.set_data (l_resource)
							grid.set_item (4, row_index, l_color_item)
							l_color_item.pointer_button_press_actions.force_extend (agent on_item_selected (l_color_item, l_resource))
						end
					end
				end
			end
		end

	clear_edit_widget is
			-- Clear the edit widget
		do
			description_text.set_text ("")
		end
	
	short_resource_name (a_name: STRING): STRING is
			-- The short, non-unique name of a resource
		require
			name_not_void: a_name /= Void			
		do
			Result := a_name.substring (a_name.last_index_of ('.', a_name.count) + 1, a_name.count)
		end		
	
	formatted_name (a_name: STRING): STRING is
			-- Formatted name for display
		do
			create Result.make_from_string (a_name)
			Result.replace_substring_all ("_", " ")
			Result.replace_substring (Result.item (1).upper.out, 1, 1)
		end		
	
feature {NONE} -- Private attributes

	show_full_resource_name: BOOLEAN
			-- Show the full name of the resource in the list?

	root_node_text: STRING
			-- Text for the top level node.

	selected_resource_name: STRING
			-- Name of resource selected in tree.  Used to programatically to update the right-side list.

	root_icon: EV_PIXMAP
	
	folder_icon: EV_PIXMAP
	
	default_color: EV_COLOR is
			-- Color for row when value is a default value
		once
			Result := (create {EV_STOCK_COLORS}).black
		end
	
	non_default_color: EV_COLOR is
			-- Color for row when value is not a default value
		once
			Result := (create {EV_STOCK_COLORS}).dark_green
		end

	grid: EV_GRID

invariant
	has_preferences: preferences /= Void

end -- class PREFERENCES_GRID_WINDOW

