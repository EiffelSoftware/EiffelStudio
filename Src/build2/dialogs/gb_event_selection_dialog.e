indexing
	description: "Objects that provide action sequence selection for an obejct"
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


create
	make_with_object
	
feature {NONE} -- Initialization

	make_with_object (an_object: GB_OBJECT) is
			-- Create `Current', build interface appropriate
			-- to `an_object.
		local
			action_sequence: GB_EV_ACTION_SEQUENCES
			cell: EV_CELL
		do
			default_create
			object := an_object
			
				-- Reset building counter.
			building_counter := 0
			
				-- Build structures used internally.
			create all_check_buttons.make (0)
			create all_text_fields.make (0)
			create all_names.make (0)
			create all_comments.make (0)
			create all_types.make (0)
			create all_class_names.make (0)
			
				-- Build and add a box which will hold all the action sequences.
			create main_vertical_box
			main_vertical_box.set_padding_width (2)
			main_vertical_box.set_border_width (20)
			extend (main_vertical_box)
			
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
			
				-- Now add a cell which will expand.
			create cell
			main_vertical_box.extend (cell)
			cell.set_minimum_height (20)
			
				-- Now create and setup `close_button'.	
			create close_button.make_with_text ("Close")
			main_vertical_box.extend (close_button)
			main_vertical_box.disable_item_expand (close_button)
			set_default_push_button (close_button)
			close_button.select_actions.extend (agent update_object_and_destroy)
		end
		
feature -- Access

	object: GB_OBJECT
		-- Object associated with `Current'.

feature {NONE} -- Implementation

	main_vertical_box: EV_VERTICAL_BOX
		-- Vertical box placed directly in `Current' to hold event 
		-- structure.
		
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

	build_events_for_an_action_sequence (an_action_sequence: GB_EV_ACTION_SEQUENCES) is
			-- Build interface representing events of `an_action_sequence'.
		require
			action_sequence_not_void: an_action_sequence /= Void
		local
			counter: INTEGER
			label: EV_LABEL
			frame: EV_FRAME
			vertical_box, vertical_box1: EV_VERTICAL_BOX
			horizontal_box, horizontal_box2: EV_HORIZONTAL_BOX
			check_button: EV_CHECK_BUTTON
			text_field: EV_TEXT_FIELD
			cell: EV_CELL
			info: GB_ACTION_SEQUENCE_INFO
			feature_name: STRING
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
				create vertical_box
				create text_field
				text_field.set_minimum_width (200)
				
					-- We must check to see whether `object' has an event linked to
					-- the current action sequence.
				horizontal_box.extend (check_button)
				horizontal_box.disable_item_expand (check_button)
				
					-- This box is used to provide extra vertical
					-- spacing around an item after the button has been checked.
				create vertical_box1
				create cell
				vertical_box1.extend (cell)
				vertical_box1.extend (horizontal_box)
				create cell
				vertical_box1.extend (cell)
				main_vertical_box.extend (vertical_box1)
				main_vertical_box.disable_item_expand (vertical_box1)
				
				
				create info.make_with_details (an_action_sequence.names @ counter, action_sequences_list.item, an_action_sequence.types @ counter, temp_event_string)
				feature_name := feature_name_of_object_event (info)
				if feature_name = Void then
						-- Build empty interface.
					create label.make_with_text (an_action_sequence.names @ counter + " " + an_action_sequence.comments @ counter)
					label.align_text_left
					horizontal_box.extend (label)
				else
						-- Build interface with feature name included and displayed.
					check_button.enable_select
					vertical_box1.set_padding_width (10)
					create frame.make_with_text (an_action_sequence.names @ counter + " " + an_action_sequence.comments @ counter)
					horizontal_box.extend (frame)
					create label.make_with_text ("Generated feature name : ")
					create horizontal_box2
					horizontal_box2.extend (label)
					horizontal_box2.extend (text_field)
					text_field.set_text (feature_name)
					horizontal_box2.disable_item_expand (label)
					horizontal_box2.disable_item_expand (text_field)
					frame.extend (horizontal_box2)
				end
				
					
				
					-- Connect an event to `check_button'.
				check_button.select_actions.extend (agent check_button_selected (building_counter))
				
					-- Store information locally, for easy updating
					-- without having to perform interations and
					-- dynamic object building again.
				all_text_fields.extend (text_field)
				all_check_buttons.extend (check_button)
				all_names.extend (an_action_sequence.names @ counter)
				all_comments.extend (an_action_sequence.comments @ counter)
				all_types.extend (an_action_sequence.types @ counter)
				all_class_names.extend (action_sequences_list.item)
	
				counter := counter + 1
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
		do
			lock_update
			current_check_button := all_check_buttons @ index
			if (current_check_button).is_selected then
				horizontal_box ?= current_check_button.parent
				vertical_box ?= horizontal_box.parent
				horizontal_box.prune (horizontal_box @ 2)
				vertical_box.set_padding_width (10)
				create frame.make_with_text (all_names @ index + " " + all_comments @ index)
				horizontal_box.extend (frame)
				create label.make_with_text ("Generated feature name : ")
				create horizontal_box
				horizontal_box.extend (label)
				horizontal_box.extend (all_text_fields @ index)
				horizontal_box.disable_item_expand (label)
				horizontal_box.disable_item_expand (all_text_fields @ index)
				frame.extend (horizontal_box)
			else
				horizontal_box ?= current_check_button.parent
				horizontal_box.prune (horizontal_box @ 2)
				vertical_box ?= horizontal_box.parent
				vertical_box.set_padding_width (0)
				create label.make_with_text (all_names @ index + " " + all_comments @ index)
				label.align_text_left
				horizontal_box.extend (label)
					-- Need to unparent the previous text field, as this object
					-- is retained. This enables us to keep the previous name
					-- as the text is not lost.
				horizontal_box ?= (all_text_fields @ index).parent
				check
					parent_was_a_horizontal_box: horizontal_box /= Void
				end
				horizontal_box.prune (all_text_fields @ index)
			end
			unlock_update
			
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			system_status.enable_project_modified
			command_handler.update
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
			--| FIXME checking for duplicate names needs to be implemented. Look at name from GB_OBJECT for this code adaptation.
			
			
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
						create warning_dialog.make_with_text ("Please enter a feature name for `" + all_names @ (counter) + "'.")
						warning_dialog.show_modal_to_window (Current)
					end	
				end
				counter := counter + 1
			end
			

			if not invalid_state then
					-- We must now save the information into `object'.
					-- First wipe out the old information from `object',
				object.events.wipe_out
				
					-- Then insert the new info.
				from
					counter := 1
				until
					counter > all_check_buttons.count
				loop
					if (all_check_buttons @ counter).is_selected then
						create action_info.make_with_details (all_names @ counter,
							all_class_names @ counter, all_types @ counter,
							(all_text_fields @ counter).text)
						object.events.extend (action_info)	

					end
					counter := counter + 1
				end
			
				destroy	
			end
		end

end -- class GB_EVENT_SELECTION_DIALOG
