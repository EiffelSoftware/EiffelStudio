indexing
	description: "[
			A EV_TITLED_WINDOW containing a tree view of application preferences.  Provides a
			list to view preference information and ability to edit the preferences.  Also allows
			to restore preferences to their defaults.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_TREE_WINDOW

inherit
	PREFERENCES_TREE_WINDOW_IMP
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
			create changed_resources.make (2)
			changed_resources.compare_objects
			set_size (640, 460)
			fill_list
			right_list.set_column_titles (<<l_name, l_literal_value, l_status, l_type>>)
			right_list.resize_actions.force_extend (agent autosize_list_columns)
			right_list.pointer_double_press_actions.force_extend (agent on_list_double_clicked)
			right_list.column_title_click_actions.extend (agent column_clicked (?))
			
			close_request_actions.extend (agent on_cancel)
			set_button.select_actions.extend (agent on_set_resource)
			set_default_button.select_actions.extend (agent on_set_resource_default)
			cancel_button.select_actions.extend (agent on_cancel)
			ok_button.select_actions.extend (agent on_close)
			restore_button.select_actions.extend (agent on_restore)
			show	
			last_selected_column := 1
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
			destroy
		end 

	on_cancel is
			-- Cancel button has been pushed: retrieve previous preference values to cancel those which 
			-- were just modified.
		do
			restore_changed_resources
			destroy
		end

	on_set_resource is
			-- Set the resource value to the newly entered value in the edit widget.
		local
			l_resource_widget: PREFERENCE_WIDGET
		do			
			l_resource_widget ?= resource_cell.data
			if l_resource_widget /= Void then
				changed_resources.put (l_resource_widget.resource, l_resource_widget.resource.string_value)
				l_resource_widget.update_resource
				right_list.selected_item.go_i_th (2)
				right_list.selected_item.replace (l_resource_widget.resource.string_value)
				right_list.selected_item.go_i_th (3)
				if l_resource_widget.resource.is_default_value then
					right_list.selected_item.replace ("default")
				else
					right_list.selected_item.replace ("user set")	
				end				
			end		
		end	

	on_set_resource_default is
			-- Set the resource value to the original default.
		local
			l_resource_widget: PREFERENCE_WIDGET
		do			
			l_resource_widget ?= resource_cell.data
			if l_resource_widget /= Void then
				l_resource_widget.reset
				right_list.selected_item.go_i_th (2)
				right_list.selected_item.replace (l_resource_widget.resource.string_value)
				right_list.selected_item.go_i_th (3)
				right_list.selected_item.replace ("default")
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

	on_list_double_clicked is
			-- 
		local
			sel_item: EV_MULTI_COLUMN_LIST_ROW
			int_pref: INTEGER_PREFERENCE
			bool_pref: BOOLEAN_PREFERENCE
			string_pref: STRING_PREFERENCE
			list_pref: ARRAY_PREFERENCE
			color_pref: COLOR_PREFERENCE
			font_pref: FONT_PREFERENCE
			l_timeout: EV_TIMEOUT
			l_resource_widget: PREFERENCE_WIDGET
			l_color_widget: COLOR_PREFERENCE_WIDGET
			l_font_widget: FONT_PREFERENCE_WIDGET
		do
			sel_item := right_list.selected_item
			if sel_item /= Void then
				int_pref ?= sel_item.data
				if int_pref /= Void then
					create l_timeout.make_with_interval (250)
					l_timeout.actions.extend (agent focus_edit_widget (l_timeout))
				else
					bool_pref ?= sel_item.data
					if bool_pref /= Void then
						bool_pref.set_value (not bool_pref.value)
						l_resource_widget := resource_widget (bool_pref)						
						resource_cell.set_data (l_resource_widget)						
						on_set_resource
					else
						string_pref ?= sel_item.data
						if string_pref /= Void then
							create l_timeout.make_with_interval (250)
							l_timeout.actions.extend (agent focus_edit_widget (l_timeout))
						else
							list_pref ?=sel_item.data
							if list_pref /= Void then
								create l_timeout.make_with_interval (250)
								l_timeout.actions.extend (agent focus_edit_widget (l_timeout))
							else
								color_pref ?= sel_item.data
								if color_pref /= Void then
									l_color_widget ?= resource_widget (color_pref)
									l_color_widget.set_caller (Current)
									l_color_widget.change
								else
									font_pref ?=sel_item.data
									if font_pref /= Void then
										l_font_widget ?= resource_widget (font_pref)
										l_font_widget.set_caller (Current)
										l_font_widget.change
									end
								end
							end
						end
					end
				end
			end
		end		

	on_item_selected (a_pref: PREFERENCE) is
			-- 
		do
			show_resource_in_edit_widget (a_pref)		
		end	

	autosize_list_columns is
			-- Auto-size the last column in the list to fit to the size of the list
		local
			l_width: INTEGER
		do
			l_width := right_list.column_width (1) + right_list.column_width (2) + right_list.column_width (3)
			if right_list.width - l_width > 0 then
		  		right_list.set_column_width (right_list.width - l_width, 4)				
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
			it: EV_MULTI_COLUMN_LIST_ROW
			l_resource: PREFERENCE
		do
			selected_resource_name := a_pref_name
				-- Retrieve known preferences
			create l_names.make
			
			l_names.append (create {ARRAYED_LIST [STRING]}.make_from_array (preferences.resources.current_keys))
			l_names.sort
			from
				l_names.start
				right_list.wipe_out								
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
						
						create it
						if l_resource.name /= Void then
							if show_full_resource_name then
								it.extend (l_resource.name)								
							else
								it.extend (formatted_name (short_resource_name (l_resource.name)))
							end
						else
							it.extend ("")	
						end
						it.extend (l_resource.string_value)
						it.set_data (l_resource)
						if l_resource.is_default_value then						
							it.extend (default_value)
						else
							it.extend (user_value)
						end
						it.extend (l_resource.string_type)
						it.select_actions.extend (agent on_item_selected (l_resource))
						right_list.extend (it)
					end
				end
				l_names.forth
			end
			right_list.resize_column_to_content (1)
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
			resource_cell.wipe_out
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
		
	show_resource_in_edit_widget (a_resource: PREFERENCE) is
			-- Show selected list resource in edit widget.
		require
			resource_not_void: a_resource /= Void
		local
			l_resource_widget: PREFERENCE_WIDGET
		do
			l_resource_widget := resource_widget (a_resource)
			resource_cell.wipe_out
			resource_cell.put (l_resource_widget.change_item_widget)			
			resource_cell.set_data (l_resource_widget)
			if l_resource_widget.resource.description /= Void then
				description_text.set_text (l_resource_widget.resource.description)
			else
				description_text.set_text (no_description_text)
			end
			l_resource_widget.set_caller (Current)
			set_button.enable_sensitive
			if l_resource_widget.resource.has_default_value then
				set_default_button.enable_sensitive
			else
				set_default_button.disable_sensitive
			end
		end		
	
	focus_edit_widget (a_timeout: EV_TIMEOUT) is
			-- Set focus into editable portion of editing widget, if applicable.
		require
			timeout_not_void: a_timeout /= Void
		do
			a_timeout.destroy
			if right_list.selected_item /= Void and not resource_cell.is_empty then
				resource_cell.item.set_focus
			end
		end		
		
	restore_changed_resources is
			-- Restore the values of the resources which have been changed in this session.
		local
			l_resource: PREFERENCE
		do
			from 
				changed_resources.start
			until
				changed_resources.after
			loop
				l_resource ?= changed_resources.item_for_iteration
				l_resource.set_value_from_string (changed_resources.key_for_iteration)
				changed_resources.forth
			end	
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
	
	column_clicked (a_column: INTEGER) is
			-- Called by `column_title_click_actions' of `right_list'.
		do
			perform_sort (a_column)
		end
		
	perform_sort (a_column: INTEGER) is
			-- Perform sort of information displayed in `constants_list',
			-- sorted by column index `a_column', 
		local
			sorter: DS_ARRAY_QUICK_SORTER [EV_MULTI_COLUMN_LIST_ROW]
			comparator: MULTI_COLUMN_LIST_ROW_STRING_COMPARATOR
			l_preferences: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		do
			if last_selected_column = a_column then
					-- Reverse the sort if this column has already been clicked.
				reverse_sort := not reverse_sort
			else
				reverse_sort := False
			end
			last_selected_column := a_column

				-- Lock window updates, and display a wait cursor.
			right_list.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)			
			
			create l_preferences.make (right_list.count)
				-- Place all items in `l_preferences' ready for sorting.
			from
				right_list.start
			until
				right_list.count = l_preferences.count
			loop
				l_preferences.force (right_list.i_th (l_preferences.count + 1))
			end
			
				-- Initialize `sorter' and `comparator'
			create comparator
			comparator.set_sort_column (a_column)
			create sorter.make (comparator)
			if reverse_sort then
				sorter.reverse_sort (l_preferences)	
			else
				sorter.sort (l_preferences)
			end
	
				-- Clear `constants_list' and rebuild rows in sorted order.		
			right_list.wipe_out
			from
				l_preferences.start
			until
				l_preferences.off
			loop
				right_list.extend (l_preferences.item)
				l_preferences.forth
			end
			
				-- Restore cursor.
			left_list.set_pointer_style ((create {EV_STOCK_PIXMAPS}).standard_cursor)
		end
	
feature {NONE} -- Private attributes

	show_full_resource_name: BOOLEAN
			-- Show the full name of the resource in the list?

	root_node_text: STRING
			-- Text for the top level node.

	changed_resources: HASH_TABLE [PREFERENCE, STRING]
			-- A hash table of resources that have been changed since this dialog was opened.
			-- Table key is the resource's old string value.
			-- Used to reset the values if the user wishes to cancel all of their prior changes	.

	selected_resource_name: STRING
			-- Name of resource selected in tree.  Used to programatically to update the right-side list.

	root_icon: EV_PIXMAP
	
	folder_icon: EV_PIXMAP
	
	last_selected_column: INTEGER
		-- Last column selected by user.
	
	reverse_sort: BOOLEAN
		-- Should sort opertion be reversed?

invariant
	has_preferences: preferences /= Void
	has_changed_resources: changed_resources /= Void

end -- class PREFERENCES_TREE_WINDOW

