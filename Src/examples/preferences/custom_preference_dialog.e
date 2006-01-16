indexing
	description: "[
			Customized dialog for showing preferences.  This dialog show preferences on the left side as a pixmap and
			then the child prefences to the right in separate frames for a nicer look.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_PREFERENCE_DIALOG

inherit
	CUSTOM_PREFERENCE_DIALOG_IMP

	PREFERENCE_VIEW		
		undefine
			copy, default_create
		redefine
			make
		end
		
create
	make
	
feature {NONE} -- Initialization

	make (a_preferences: like preferences; a_parent_window: like parent_window) is
				-- Initialize
		do
			default_create			
			preferences := a_preferences
			parent_window := Current	
			fill_list			
			close_request_actions.extend (agent on_cancel)
			cancel_button.select_actions.extend (agent on_cancel)
			ok_button.select_actions.extend (agent on_close)
			restore_button.select_actions.extend (agent on_restore)			
			create grid
			main_preference_box.extend (grid)
			grid.set_item (2, 1, Void)
			show						
		end

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
		end

feature {NONE} -- Implementation

	grid: EV_GRID

	fill_list is
			-- Fill Left pixmaps list.
		local
			l_pref_hash: HASH_TABLE [EV_PIXMAP, STRING]
			l_known_pref_hash: HASH_TABLE [PREFERENCE, STRING]
			l_pref_name,
			l_pref_parent_short_name: STRING
			l_split_string: LIST [STRING]
			l_root_pixmap: EV_PIXMAP
			l_hbox: EV_HORIZONTAL_BOX
			l_row_index: INTEGER
			l_exec: EXECUTION_ENVIRONMENT
			l_filename: FILE_NAME
		do
				-- Retrieve known preferences
			l_known_pref_hash := preferences.preferences
			
			if not l_known_pref_hash.is_empty then				
				create l_pref_hash.make (l_known_pref_hash.count)					
				
				from
					l_known_pref_hash.start
					l_row_index := 1
					create l_exec
				until
					l_known_pref_hash.after
				loop
					l_pref_name := l_known_pref_hash.key_for_iteration
					if l_pref_name.has ('.') then
						l_split_string := l_pref_name.split ('.')						
						l_pref_parent_short_name := l_split_string.i_th (1)
						if not l_pref_hash.has (l_pref_parent_short_name) then
							create l_root_pixmap
							create l_hbox
							create l_filename.make_from_string (l_exec.current_working_directory)
							l_filename.extend (l_pref_parent_short_name)
							l_filename.add_extension ("png")
							l_root_pixmap.set_with_named_file (l_filename.string)
							l_root_pixmap.pointer_button_press_actions.force_extend (agent fill_container (l_pref_parent_short_name))
							l_hbox.extend (l_root_pixmap)
							l_hbox.set_minimum_size (120, 120)
							l_hbox.set_background_color ((create {EV_STOCK_COLORS}).white)
							parent_pixmap_box.extend (l_hbox)
							parent_pixmap_box.disable_item_expand (l_hbox)							
							l_pref_hash.put (l_root_pixmap, l_pref_parent_short_name)
						end						
					end
					l_known_pref_hash.forth
				end
			end
		end

	fill_container (parent_preference: STRING) is
			-- Show parent preferences.
		require
			parent_not_void: parent_preference /= Void
		local		
			l_preference: PREFERENCE
			l_preferences: HASH_TABLE [PREFERENCE, STRING]
			l_row_index: INTEGER
		do
			grid.wipe_out
			grid.set_item (2, 1, Void)
			parent_title_label.set_text (parent_preference)
				-- Retrieve known preferences
			l_preferences := preferences.preferences
			from
				l_preferences.start
				l_row_index := 1
			until
				l_preferences.after
			loop
				l_preference := l_preferences.item_for_iteration
				if l_preference.name.substring (1, parent_preference.count).is_equal (parent_preference) then					
					show_preference_in_container (l_preference, l_row_index)	
				end
				l_row_index := l_row_index + 1
				l_preferences.forth
			end
		end		
		
	show_preference_in_container (a_preference: PREFERENCE; a_row_index: INTEGER) is
				-- Show selected list preference in main container.
		require
			preference_not_void: a_preference /= Void
		local
			l_preference_widget: PREFERENCE_WIDGET
			l_dr: DIRECTORY_RESOURCE
			l_cr: COLOR_PREFERENCE	
			l_br: BOOLEAN_PREFERENCE		
		do
			l_dr ?= a_preference
			if l_dr = Void then
				l_cr ?= a_preference
				if l_cr /= Void then
					create {COLOR_PREFERENCE_WIDGET} l_preference_widget.make_with_preference (l_cr)						
					l_preference_widget.set_caller (Current)
					grid.set_item (1, a_row_index, create {EV_GRID_LABEL_ITEM}.make_with_text (a_preference.name))
					grid.set_item (2, a_row_index, l_preference_widget.change_item_widget)
				else
					l_br ?= a_preference
					if l_br /= Void then
						create {BOOLEAN_PREFERENCE_WIDGET} l_preference_widget.make_with_preference (l_br)						
						l_preference_widget.set_caller (Current)
						grid.set_item (1, a_row_index, create {EV_GRID_LABEL_ITEM}.make_with_text (a_preference.name))
						grid.set_item (2, a_row_index, l_preference_widget.change_item_widget)
					end
				end
			else
				create {DIRECTORY_RESOURCE_WIDGET} l_preference_widget.make_with_preference (l_dr)
				l_preference_widget.set_caller (Current)
				grid.set_item (1, a_row_index, create {EV_GRID_LABEL_ITEM}.make_with_text (a_preference.name))
				grid.set_item (2, a_row_index, l_preference_widget.change_item_widget)
			end									
			
			grid.column (1).set_title ("Preference Name")
			grid.column (2).set_title ("Value")
			grid.column (1).resize_to_content
			grid.column (1).set_width (grid.column (1).width + padding_width)
		end	

feature {NONE} -- Events

	on_close is
			-- Close button has been pushed: apply the changes then close
			-- the Preferences Window.
		do
			preferences.save_preferences
			destroy
		end 

	on_cancel is
			-- Cancel button has been pushed: retrieve previous preference values to cancel those which 
			-- were just modified.
		do
			destroy
		end

	on_restore is
			-- Restore all preferences
		local
			l_confirmation_dialog: EV_CONFIRMATION_DIALOG
		do
			create l_confirmation_dialog
			l_confirmation_dialog.set_text ("This will reset ALL preferences to their default values%N%
				% and all previous settings will be overwritten.  Are you sure?")
			l_confirmation_dialog.show_modal_to_window (parent_window)
			if l_confirmation_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				preferences.restore_defaults
				fill_container (selected_preference_name)
			end
		end		
		
feature {NONE} -- Private Attributes

	selected_preference_name: STRING
			-- Selected preference

	padding_width: INTEGER is 3
			-- Column padding width

end -- class CUSTOM_PREFERENCE_DIALOG

