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
--			set_icon_pixmap (pixmap_file_contents (Interface_names.preference_window_icon))
			fill_list
			right_list.set_column_titles (<<l_name, l_literal_value, l_status, l_type>>)
			right_list.resize_actions.force_extend (agent autosize_list_columns)
			
			close_request_actions.extend (agent on_cancel)
			set_button.select_actions.extend (agent on_set_resource)
			set_default_button.select_actions.extend (agent on_set_resource_default)
			cancel_button.select_actions.extend (agent on_cancel)
			ok_button.select_actions.extend (agent on_close)
			restore_button.select_actions.extend (agent on_restore)
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
			l_resource_widget: RESOURCE_WIDGET
		do			
			l_resource_widget ?= resource_cell.data
			if l_resource_widget /= Void then
				changed_resources.put (l_resource_widget.resource, l_resource_widget.resource.string_value)
				l_resource_widget.update_changes
				right_list.selected_item.go_i_th (2)
				right_list.selected_item.replace (l_resource_widget.resource.string_value)
			end		
		end	

	on_set_resource_default is
			-- Set the resource value to the original default.
		local
			l_resource_widget: RESOURCE_WIDGET
		do			
			l_resource_widget ?= resource_cell.data
			if l_resource_widget /= Void then
				--changed_resources.put (l_resource_widget.resource, l_resource_widget.resource.string_value)
				l_resource_widget.resource.reset
				right_list.selected_item.go_i_th (2)
				right_list.selected_item.replace (l_resource_widget.resource.string_value)
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
				fill_right_list (selected_resource_name)
			end
		end		

	autosize_list_columns is
			-- Auto-size the last column in the list to fit to the size of the list
		local
			l_width: INTEGER
		do
			l_width := right_list.column_width (1) + right_list.column_width (2) + right_list.column_width (3)
	  		right_list.set_column_width (right_list.width - l_width, 4)
		end	

feature {NONE} -- Implementation

	fill_list is
			-- Fill left tree.
		local
 			it,
 			l_parent: EV_TREE_ITEM
			l_pref_hash: HASH_TABLE [EV_TREE_ITEM, STRING]
			l_known_pref_hash: HASH_TABLE [RESOURCE, STRING]
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
				create it.make_with_text (root_node_text)
				it.select_actions.extend (agent fill_right_list (root_node_text))
				l_pref_hash.put (it, root_node_text)
				left_list.extend (it)
				
				from
					l_sorted_preferences.finish
				until
					l_sorted_preferences.before
				loop
					l_pref_name := l_sorted_preferences.item					
					l_pref_hash.put (it, l_pref_name)
					if l_pref_name.has ('.') then
						  -- Build parent nodes	
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
								create l_parent.make_with_text (l_pref_parent_short_name)
								l_parent.select_actions.extend (agent fill_right_list (l_pref_parent_name))
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
							if not l_pref_hash.has (l_pref_parent_full_name) then
								create l_parent.make_with_text (l_pref_parent_full_name)
								l_parent.select_actions.extend (agent fill_right_list (l_pref_parent_full_name))
								l_pref_hash.put (l_parent, l_pref_parent_full_name.twin)						
								l_pref_hash.item (root_node_text).put_front (l_parent)
							end		
						end						
					elseif not l_pref_hash.has (l_pref_name) then						
							-- Add as child to root node
						create it.make_with_text (l_pref_name)
						it.select_actions.extend (agent fill_right_list (l_pref_name))
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
			l_names: ARRAY [STRING]
			l_pref_name: STRING
			l_index: INTEGER
			it: EV_MULTI_COLUMN_LIST_ROW
			l_resource: RESOURCE
		do
			selected_resource_name := a_pref_name
				-- Retrieve known preferences
			l_names := preferences.resources.current_keys
			from
				l_index := 1
				right_list.wipe_out
			until
				l_index > l_names.count
			loop
				l_pref_name := l_names.item (l_index)
				if l_pref_name.substring (1, a_pref_name.count).is_equal (a_pref_name) and l_pref_name.count > a_pref_name.count then					
					l_resource := preferences.resources.item (l_pref_name)
					
					check
						resource_not_void: l_resource /= Void
					end
					
					create it
					if l_resource.name /= Void then						
						it.extend (l_resource.name)	
					else
						it.extend ("")	
					end
					it.extend (l_resource.string_value)
					if l_resource.is_default_value then						
						it.extend (default_value)
					else
						it.extend (user_value)
					end
					it.extend (l_resource.string_type)
					it.select_actions.extend (agent show_resource_in_edit_widget (l_resource))					
					right_list.extend (it)
				end
				l_index := l_index + 1
			end
		end

feature {NONE} -- Implementation

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
		
	show_resource_in_edit_widget (a_resource: RESOURCE) is
			-- Show selected list resource in edit widget.
		require
			resource_not_void: a_resource /= Void
		local
			l_resource_widget: RESOURCE_WIDGET
			l_timeout: EV_TIMEOUT
		do
			l_resource_widget := preferences.resource_widget (a_resource)
			if resource_cell.has (l_resource_widget.change_item_widget) then
				resource_cell.prune (l_resource_widget.change_item_widget)
			end
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
			
			create l_timeout.make_with_interval (250)
			l_timeout.actions.extend (agent focus_edit_widget(l_timeout))
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
			l_resource: RESOURCE
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
	
feature {NONE} -- Private attributes

	root_node_text: STRING
			-- Text for the top level node.

	changed_resources: HASH_TABLE [RESOURCE, STRING]
			-- A hash table of resources that have been changed since this dialog was opened.
			-- Table key is the resource's old string value.
			-- Used to reset the values if the user wishes to cancel all of their prior changes	.

	selected_resource_name: STRING
			-- Name of resource selected in tree.  Used to programatically to update the right-side list.

invariant
	has_preferences: preferences /= Void
	has_changed_resources: changed_resources /= Void

end -- class PREFERENCES_TREE_WINDOW

