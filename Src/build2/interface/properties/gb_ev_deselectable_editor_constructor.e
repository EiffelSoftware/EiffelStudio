indexing
	description: "Builds an attribute editor for modification of objects of type EV_DESELECTABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_DESELECTABLE_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_DESELECTABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_DESELECTABLE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			first_object: EV_DESELECTABLE
		do
			create Result
			initialize_attribute_editor (Result)
			first_object := objects.first
			create check_button.make_with_text (gb_ev_deselectable_is_selected)
			check_button.set_tooltip (gb_ev_deselectable_is_selected_tooltip)
			Result.extend (check_button)
			check_button.select_actions.extend (agent toggle_selected)
			check_button.select_actions.extend (agent update_editors)
			
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check_button.select_actions.block
			if first.is_selected then
				check_button.enable_select
			else
				check_button.disable_select
			end
			check_button.select_actions.resume
		end
		
	set_up_user_events (vision2_object, an_object: like ev_type) is
			-- Add events necessary for `vision2_object'.
		local
			widget: EV_WIDGET
		do
			--| For now, just deal with widgets. At some point items may be supported also.
		user_event_widget := vision2_object
		widget ?= vision2_object
		check
			we_are_dealing_with_a_widget: widget /= Void
		end
		objects.extend (an_object)
		objects.extend (vision2_object)
		widget.pointer_button_release_actions.force_extend (agent start_timer)
		widget.key_release_actions.force_extend (agent start_timer)
		end	
		
		start_timer is
				--
			local
				timer: EV_TIMEOUT
			do
				create timer.make_with_interval (10)
				timer.actions.extend (agent check_state)
				timer.actions.extend (agent timer.destroy)
			end
			
		check_state is
				--
			do
				if user_event_widget.is_selected then
					objects.first.enable_select
					update_editors
				else
					objects.first.disable_select
					update_editors
				end
			end
			
	user_event_widget: like ev_type	

feature {NONE} -- Implementation

	check_button: EV_CHECK_BUTTON
		-- Check button used for setting attribute.
	
	toggle_selected is
			-- Update sensitive state.
		do
			if check_button.is_selected then
				for_all_objects (agent {EV_DESELECTABLE}.enable_select)
			else
				for_all_objects (agent {EV_DESELECTABLE}.disable_select)
			end
		end

	-- Constants for XML
	
	is_selected_string: STRING is "Is_selected"

end -- class GB_EV_DESELECTABLE_EDITOR_CONSTRUCTOR
