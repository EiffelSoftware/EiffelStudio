indexing
	description: "Objects that provide action sequence selection for an object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EVENT_SELECTION_DIALOG

inherit
	EV_DIALOG
	
	GB_SUPPORTED_EVENTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	INTERNAL
		undefine
			default_create, copy
		end
		
	GB_SHARED_SYSTEM_STATUS
		undefine
			default_create, copy
		end
		
	GB_SHARED_COMMAND_HANDLER
	
	GB_NAMING_UTILITIES
		undefine
			default_create, copy
		end
	
	GB_WIDGET_UTILITIES
		undefine
			default_create, copy
		end
		
	GB_SHARED_OBJECT_HANDLER
		undefine
			copy, default_create
		end
		
	EIFFEL_RESERVED_WORDS
		undefine
			copy, default_create
		end
		
	GB_EVENT_UTILITIES
		undefine
			copy, default_create
		end
		
	EV_STOCK_COLORS
		rename
			implementation as stock_colors_implementation
		undefine
			copy, default_create, is_equal
		end

create
	make_with_object
	
feature {NONE} -- Initialization

	make_with_object (an_object: GB_OBJECT) is
			-- Create `Current', build interface appropriate
			-- to `an_object.
		local
			action_sequence: GB_EV_ACTION_SEQUENCES
			cell: EV_CELL
			header_label: EV_LABEL
			temp_box: EV_VERTICAL_BOX
			h_box: EV_HORIZONTAL_BOX
			separator: EV_HORIZONTAL_SEPARATOR
		do
			default_create
			set_title ("Event selection")
			disable_user_resize
			object := an_object
			show_actions.extend (agent update_text_field_minimum_width)
				-- Reset building counter.
			building_counter := 0
			
				-- Build structures used internally.
			create all_check_buttons.make (0)
			create all_text_fields.make (0)
			create all_names.make (0)
			create all_comments.make (0)
			create all_types.make (0)
			create all_class_names.make (0)
			
			
			create temp_box
			extend (temp_box)
			create header_label.make_with_text ("Actions to be performed when:")
			header_label.align_text_left
			header_label.set_minimum_height (20)
			temp_box.extend (header_label)
			temp_box.disable_item_expand (header_label)
			create separator
			temp_box.extend (separator)
			temp_box.disable_item_expand (separator)
			create viewport
			viewport.set_background_color (text_background_color)
			create h_box
			create scroll_bar
			h_box.extend (viewport)
			h_box.extend (scroll_bar)
			h_box.disable_item_expand (scroll_bar)
			temp_box.extend (h_box)
			
				-- Build and add a box which will hold all the action sequences.
			create_main_box
			viewport.extend (main_vertical_box)
			create all_labels.make (25)
			
				-- Now build the interface which will display the
				-- applicable action sequences.
			from
				action_sequences_list.start
			until
				action_sequences_list.off
			loop
				if type_conforms_to (dynamic_type_from_string (object.type), dynamic_type_from_string (action_sequences_list.item)) then
					action_sequence ?= new_instance_of (dynamic_type_from_string ("GB_" + action_sequences_list.item))
					check
						action_sequence_not_void: action_sequence /= Void
					end
					build_events_for_an_action_sequence (action_sequence)
				end
				action_sequences_list.forth
			end
			
			from
				all_labels.start
			until
				all_labels.off
			loop
					-- The "5" gives a little spacing between the end of the
					-- label and the 
				all_labels.item.set_minimum_width (minimum_label_width + 5)
				all_labels.forth
			end

				-- We now wipe out the events for the object. When we check for valid
				-- names, we will not check the current names. The events must be
				-- wiped out when the window is closed anyway to be re-filled with
				-- the current info from `Current'.
			object.events.wipe_out
			
			
			create separator
			temp_box.extend (separator)
			temp_box.disable_item_expand (separator)
				-- Now create and setup `close_button'.	
			create close_button.make_with_text ("Close")
			create h_box
			create cell
			h_box.extend (cell)
			h_box.extend (close_button)
			create cell
			h_box.extend (cell)
			h_box.disable_item_expand (close_button)
			temp_box.extend (h_box)
			temp_box.disable_item_expand (h_box)
			set_default_push_button (close_button)
			close_button.select_actions.extend (agent update_object_and_destroy)
			update_scroll_bar
				-- We must automatically update `scroll_bar' and
				-- the controls.
			scroll_bar.change_actions.extend (agent scroll_bar_moved (?))
			resize_actions.force_extend (agent update_scroll_bar)
			
				-- We attempt to set the height relative to the number
				-- of items displayed, but with a maximum of 400.
				-- We add 50 as a rough estimate for the items above and below
				-- the window, and the windows client area to coordinate difference.
			set_size (600, (main_vertical_box.minimum_height + 50).min (400))
			set_minimum_size (200, 200)
		end

feature -- Access

	object: GB_OBJECT
		-- Object associated with `Current'.

feature {NONE} -- Implementation

	main_vertical_box: EV_VERTICAL_BOX
		-- Vertical box placed directly in `Current' to hold event 
		-- structure.
		
	viewport: EV_VIEWPORT
		-- Scrollable area to hold `main_vertical_box'.
		
	scroll_bar: EV_VERTICAL_SCROLL_BAR
		-- A scroll bar to be connected to the viewport
		-- when required.
		
	close_button: EV_BUTTON
		-- Clicking will close `Current'.
		
	all_check_buttons: ARRAYED_LIST [EV_CHECK_BUTTON]
		-- All check buttons connected to `Current'.
		
	all_text_fields: ARRAYED_LIST [EV_TEXT_FIELD]
		-- All text fields associated with the check buttons.
		-- Ordered with `all_check_buttons'.
		
		-- The next few attributes store all the information
		-- about the action sequences for `object'. We store
		-- them locally, so that we only have to create the objects
		-- once in order to retrieve the information.
		-- `all_names' @ 3 corresponds to `all_types' @ 3 etc etc.
		
	all_names: ARRAYED_LIST [STRING]
		-- All action sequence names associated with `object'.
	
	all_types: ARRAYED_LIST [STRING]
		-- All action sequence types associated with `object'.
	
	all_comments: ARRAYED_LIST [STRING]
		-- All comments associated with each action sequence for `object'.
	
	all_class_names: ARRAYED_LIST [STRING]
		-- All class names corresponding to class defining each action sequence name.
		
	building_counter: INTEGER
		-- Current action sequence being built.
		
	temp_event_string: STRING is "Temporary feature name for comparison purposes."
		-- Used internally. Cannot be entered by user, as contains spaces.
		
	all_labels: ARRAYED_LIST [EV_LABEL]
		-- Used to hold all labels displayed before the
		-- check buttons. When the interface has been
		-- Created, we must then assign a minimum_width to all
		-- the labels which will match that of the largest.
		-- This procedure will ensure that all columns align correctly.
	
	minimum_label_width: INTEGER
		-- The largest `minimum_width' of all labels displayed before
		-- the check buttons.
		
	right_side_spacing: INTEGER is 30
		-- Distance from right hand side of text boxes to scroll bar.

	build_events_for_an_action_sequence (an_action_sequence: GB_EV_ACTION_SEQUENCES) is
			-- Build interface representing events of `an_action_sequence'.
		require
			action_sequence_not_void: an_action_sequence /= Void
		local
			counter: INTEGER
			label, start_label: EV_LABEL
			frame: EV_FRAME
			vertical_box: EV_VERTICAL_BOX
			horizontal_box, horizontal_box2: EV_HORIZONTAL_BOX
			check_button: EV_CHECK_BUTTON
			text_field: EV_TEXT_FIELD
			cell: EV_CELL
			info: GB_ACTION_SEQUENCE_INFO
			feature_name: STRING
			renamed_action_sequence_name: STRING
			action_sequence_comment: STRING
		do
			from
				counter := 1
			until
				counter = an_action_sequence.count + 1
			loop
				building_counter := building_counter + 1
				create frame
				create horizontal_box
				create check_button
				check_button.set_background_color (text_background_color)
				create vertical_box
				create text_field
				text_field.set_minimum_width (100)
				
					-- Add the start label.
				create start_label
				start_label.set_background_color (text_background_color)
				create vertical_box
				vertical_box.set_background_color (text_background_color)
				horizontal_box.extend (vertical_box)
				horizontal_box.disable_item_expand (vertical_box)
				start_label.align_text_left
				vertical_box.extend (start_label)
				vertical_box.disable_item_expand (start_label)
				create cell
				cell.set_background_color (text_background_color)
				vertical_box.extend (cell)
				
					-- We must check to see whether `object' has an event linked to
					-- the current action sequence.
				create vertical_box
				vertical_box.set_background_color (text_background_color)
				
				create cell
				cell.set_background_color (text_background_color)
				vertical_box.extend (check_button)
				vertical_box.disable_item_expand (check_button)
				vertical_box.extend (cell)

				horizontal_box.extend (vertical_box)
				horizontal_box.disable_item_expand (vertical_box)
				main_vertical_box.extend (horizontal_box)
				
				
				create info.make_with_details (an_action_sequence.names @ counter, action_sequences_list.item, an_action_sequence.types @ counter, temp_event_string)
					-- Adjust event names that have been renamed in Vision2 interface
				renamed_action_sequence_name := modified_action_sequence_name (object.type, info)
				feature_name := feature_name_of_object_event (info)
					-- Display text before the check button.
					
				action_sequence_comment := clone (an_action_sequence.comments @ counter)
					-- We prune the `comment_start_string' from the start of the action sequence
					-- for a description of what the action sequence does.
					-- We check here, as if this is not the case, our output may not be correct
					-- and will need special handling.
				check
					action_sequence_comment.substring_index (comment_start_string, 1) = 1
				end
				action_sequence_comment.keep_tail (action_sequence_comment.count - comment_start_string.count)
				start_label.set_text (action_sequence_comment)
				
					-- We must store the minimum_width of `start_label' if
					-- it is greater than the minimum width stored during
					-- previous calls to `build_events_for_an_action_sequence'.
				all_labels.extend (start_label)
				if start_label.minimum_width > minimum_label_width then
					minimum_label_width := start_label.minimum_width
				end

				if feature_name = Void then
						-- Build empty interface.
					create label.make_with_text (renamed_action_sequence_name)
					label.set_background_color (text_background_color)
					label.align_text_left
					horizontal_box.extend (label)
				else
						-- Build interface with feature name included and displayed.
					check_button.enable_select
					create frame.make_with_text (renamed_action_sequence_name)
					frame.set_background_color (text_background_color)
					horizontal_box.extend (frame)
					horizontal_box.set_background_color (text_background_color)
					create label.make_with_text ("Generated feature name : ")
					label.set_background_color (text_background_color)
					create horizontal_box2
					horizontal_box.set_background_color (text_background_color)
					horizontal_box2.extend (label)
					horizontal_box2.extend (text_field)
					text_field.set_text (feature_name)
					frame.extend (horizontal_box2)
					disable_all_items (horizontal_box2)
				end
				
					
				
					-- Connect an event to `check_button'.
				check_button.select_actions.extend (agent check_button_selected (building_counter))
					-- Connect event to `text_field'.
				text_field.change_actions.force_extend (agent validate_name_change (building_counter))
				
					-- Store information locally, for easy updating
					-- without having to perform interations and
					-- dynamic object building again.
				all_text_fields.extend (text_field)
				all_check_buttons.extend (check_button)
				all_names.extend (renamed_action_sequence_name)
				all_comments.extend (an_action_sequence.comments @ counter)
				all_types.extend (an_action_sequence.types @ counter)
				all_class_names.extend (action_sequences_list.item)
	
				counter := counter + 1
			end
		end
		
	update_text_field_minimum_width is
			-- For all text field in `all_text_fields' that are displayed,
			-- update minimum width relative to the scroll bar
			-- displayed to their right.
			-- We check to see if they are displayed using `all_check_buttons'.
			-- if the button `is_selected' then we must update the text_field.
		do
			from
				all_text_fields.start
			until
				all_text_fields.off
			loop
				if (all_check_buttons @ (all_text_fields.index)).is_selected then
					all_text_fields.item.set_minimum_width (x_position_relative_to_window (scroll_bar) -
					x_position_relative_to_window (all_text_fields.item) - right_side_spacing)			
				end
				all_text_fields.forth
			end
		end
		
		
	validate_name_change (index: INTEGER) is
			-- text field, `all_text_fields' @ `index' has been modified, 
			-- so validate, and update display accordingly.
		local
			current_text_field: EV_TEXT_FIELD
		do
			current_text_field := all_text_fields @ index
			if valid_class_name (current_text_field.text) or current_text_field.text.is_empty then
				if object_handler.name_in_use (current_text_field.text, Void) or (reserved_words.has (current_text_field.text.as_lower)) then
					current_text_field.set_foreground_color (red)
				else
					current_text_field.set_foreground_color (black)
				end
			else
				undo_last_character (current_text_field)
			end
		end
		
	feature_name_of_object_event (info: GB_ACTION_SEQUENCE_INFO): STRING is
			-- Does `object' have an event matching `info'. If so, then
			-- Result is matching name
		local
			events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
			matched: BOOLEAN
		do
				-- Local verion for fast iteration.
			events := object.events
			
			from
				events.start
			until
				events.off or matched = True
			loop
				if events.item.name.is_equal (info.name) and
					events.item.class_name.is_equal (info.class_name) and
					events.item.type.is_equal (info.type) then
					check
						feature_name_not_empty: not events.item.name.is_empty
					end
					Result := events.item.feature_name
					matched := True
				end
				events.forth
			end
		end
		
	check_button_selected (index: INTEGER) is
			-- Check button all_check_buttons @ `index' has been selected.
			-- We must maximize/minimize the feature name entry depending on
			-- the state of check button corresponding to `index' in
			-- `all_check_buttons'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			vertical_box: EV_VERTICAL_BOX
			label: EV_LABEL
			current_check_button: EV_CHECK_BUTTON
			frame: EV_FRAME
			current_text_field: EV_TEXT_FIELD
		do
			lock_update
			current_check_button := all_check_buttons @ index
			current_text_field := all_text_fields @ index	
			if (current_check_button).is_selected then
				vertical_box ?= current_check_button.parent
				horizontal_box ?= vertical_box.parent
				horizontal_box.prune (horizontal_box @ 3)
				create frame.make_with_text (all_names @ index)
				frame.set_background_color (text_background_color)
				horizontal_box.extend (frame)
				create label.make_with_text ("Generated feature name : ")
				label.set_background_color (text_background_color)
				create horizontal_box
				horizontal_box.extend (label)
				current_text_field.set_text (current_text_field.text.as_lower)
				horizontal_box.extend (current_text_field)
				disable_all_items (horizontal_box)
				frame.extend (horizontal_box)
				horizontal_box.set_background_color (text_background_color)
			else
				vertical_box ?= current_check_button.parent
				horizontal_box ?= vertical_box.parent
				horizontal_box.prune (horizontal_box @ 3)
				
				create label.make_with_text (all_names @ index)
				label.set_background_color (text_background_color)
				label.align_text_left
				horizontal_box.extend (label)
					-- Need to unparent the previous text field, as this object
					-- is retained. This enables us to keep the previous name
					-- as the text is not lost.
				horizontal_box ?= current_text_field.parent
				check
					parent_was_a_horizontal_box: horizontal_box /= Void
				end
				horizontal_box.prune (current_text_field)
				rebuild_controls_minimally
			end
			update_scroll_bar
			unlock_update

				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			system_status.enable_project_modified
			command_handler.update
				-- We do this here as when the update is locked,
				-- there appears to be problems.
			if current_check_button.is_selected then
				current_text_field.set_minimum_width (x_position_relative_to_window (scroll_bar) -
					x_position_relative_to_window (current_text_field) - right_side_spacing)
				current_text_field.set_focus
			end
		end
		
	create_main_box is
			-- Create `main_vertical_box' and initialize.
		do
			create main_vertical_box
			main_vertical_box.set_padding_width (10)
			main_vertical_box.set_border_width (20)
			main_vertical_box.set_background_color (text_background_color)
		end
		
	update_scroll_bar is
			-- Update scroll bar to reflect
			-- current size of the controls.
		do
			if viewport.height >= main_vertical_box.minimum_height then
				scroll_bar.hide
			else
				if not scroll_bar.is_show_requested then
					scroll_bar.show		
				end
				scroll_bar.value_range.adapt ((create {INTEGER_INTERVAL}.make (0, main_vertical_box.minimum_height - viewport.height)))
				if viewport.height > 0 then
					scroll_bar.set_leap (viewport.height)
				end
				scroll_bar_moved (scroll_bar.value)
			end
		end
		
	scroll_bar_moved (new_scroll_bar_value: INTEGER) is
			-- `scroll_bar' value has changed, so updated
			-- the position of the controls within `viewport'.
		do
			viewport.set_y_offset (new_scroll_bar_value)
		end

	rebuild_controls_minimally is
			-- Rebuild all controls representing action sequences
			-- into `main_vertical_box' which must be re-created
			-- during this process. We do this so that the box
			-- is minimal. There is no way to shrink an EV_BOX's
			-- size once it has been expanded by its children.
		local
			a_box: EV_VERTICAL_BOX
			temp_widget: EV_WIDGET
		do
			a_box := main_vertical_box
			create_main_box
			from
				a_box.start
			until
				a_box.off
			loop
				temp_widget ?= a_box.item
				a_box.remove
				main_vertical_box.extend (temp_widget)
			end
			viewport.wipe_out
			viewport.extend (main_vertical_box)
		end
		
	update_object_and_destroy is
			-- Update `object' to reflect changes made during lifetime of
			-- `Current', and then destroy `Current'.
		local
			invalid_state: BOOLEAN
			warning_dialog: EV_WARNING_DIALOG
			counter: INTEGER
			action_info: GB_ACTION_SEQUENCE_INFO
		do	
				-- We must validate all the names contained in the boxes.
				-- First, we need to find out all selected text fields.
			from
				counter := 1
			until
				counter > all_check_buttons.count or invalid_state
			loop
				if (all_check_buttons @ counter).is_selected then
					if (all_text_fields @ counter).text.is_empty then
						invalid_state := True
						--create warning_dialog.make_with_text ("Please enter a feature name for `" + all_names @ (counter) + "'.%NOr deselect " + all_names @ (counter))
						create warning_dialog.make_with_text ("You have not entered a feature name for `" + all_names @ (counter) + "'.%NPlease enter a feature name, or uncheck this action sequence.")
						warning_dialog.show_modal_to_window (Current)
					elseif (all_text_fields @ counter).foreground_color.is_equal (red) then
						invalid_state := True
						create warning_dialog.make_with_text (Event_feature_name_warning)
						warning_dialog.show_modal_to_window (Current)
					elseif repeated_name ((all_text_fields @ counter).text.as_lower, counter) then
						invalid_state := True
						create warning_dialog.make_with_text (Duplicate_event_feature_name_warning)
						warning_dialog.show_modal_to_window (Current)
					end	
				end
				counter := counter + 1
			end
			

			if not invalid_state then			
					-- Then insert the new info.
				from
					counter := 1
				until
					counter > all_check_buttons.count
				loop
					if (all_check_buttons @ counter).is_selected then
						create action_info.make_with_details (all_names @ counter,
							all_class_names @ counter, all_types @ counter,
							(all_text_fields @ counter).text.as_lower)
						object.events.extend (action_info)	

					end
					counter := counter + 1
				end
			
				destroy	
			end
		end
		
	repeated_name (current_name: STRING; index: INTEGER): BOOLEAN is
			-- Is `current_name' the text of an expanded feature
			-- name entry, exluding `index' position?
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				counter > all_check_buttons.count or Result
			loop
				if (all_check_buttons @ counter).is_selected and index /= counter then
					if (all_text_fields @ counter).text.as_lower.is_equal (current_name) then
						Result :=True
					end
				end
				counter := counter + 1
			end
		end
		
	text_background_color: EV_COLOR is
			-- `Result' is EV_COLOR used for
			-- background of controls.
			-- This is provided, so all controls can be
			-- changed from one single place.
		once
			Result := white
		ensure
			result_not_void: Result /= Void
		end
		

end -- class GB_EVENT_SELECTION_DIALOG
