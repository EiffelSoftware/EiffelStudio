indexing
	description: "Builds an attribute editor for modification of objects of type EV_GAUGE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_GAUGE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_GAUGE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_GAUGE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result
			initialize_attribute_editor (Result)
			create value_entry.make (Current, Result, gb_ev_gauge_value, gb_ev_gauge_value_tooltip,
				agent set_value (?), agent valid_value (?))
			create step_entry.make (Current, Result, gb_ev_gauge_step, gb_ev_gauge_step_tooltip,
				agent set_step (?), agent positive_value (?))
			create leap_entry.make (Current, Result, gb_ev_gauge_leap, gb_ev_gauge_leap_tooltip,
				agent set_leap (?), agent positive_value (?))
			create upper_entry.make (Current, Result, gb_ev_gauge_upper, gb_ev_gauge_upper_tooltip,
				agent set_upper (?), agent valid_upper (?))
			create lower_entry.make (Current, Result, gb_ev_gauge_lower, gb_ev_gauge_lower_tooltip,
				agent set_lower (?), agent valid_lower (?))
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
feature {NONE} -- Implementation

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			value_entry.set_text (first.value.out)
			step_entry.set_text (first.step.out)
			leap_entry.set_text (first.leap.out)
			upper_entry.set_text (first.value_range.upper.out)
			lower_entry.set_text (first.value_range.lower.out)
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
		end	
		
	start_timer is
			-- Start a timer, which is used as a delay between an event begin
			-- received by `user_event_widget' and `check_state'.
		local
			timer: EV_TIMEOUT
		do
			create timer.make_with_interval (10)
			timer.actions.extend (agent check_state)
			timer.actions.extend (agent timer.destroy)
		end
			
	check_state is
			-- Update the display window representation of
			-- the gauge, to reflect change from user.
		do
			objects.first.set_value (user_event_widget.value)
			update_editors
		end
		
	user_event_widget: like ev_type

	set_value (a_value: INTEGER) is
			-- Update property `value' on all items in `objects'.
		do
			for_all_objects (agent {EV_GAUGE}.set_value (a_value))
		end
		
	valid_value (a_value: INTEGER): BOOLEAN is
			-- is `a_value' a valid value for items in `objects'?
		do
			Result := (a_value >= 0 and first.value_range.has (a_value))
		end

	set_step (a_step: INTEGER)is
			-- Set step on all items in `objects' to `a_step'.
		do
			for_all_objects (agent {EV_GAUGE}.set_step (a_step))
		end
		
	positive_value (a_value: INTEGER): BOOLEAN is
			-- is `a_value' greater than 0?
		do
			Result := a_value > 0
		end
		
	set_leap (a_leap: INTEGER) is
			-- Set leap on all items in `objects' to `a_leap'.
		do
			for_all_objects (agent {EV_GAUGE}.set_leap (a_leap))
		end
		
	set_upper (integer: INTEGER) is
			-- Update property `upper' on all items in `objects'.
		require
			first_not_void: first /= Void
		local
			lower: INTEGER
			interval: INTEGER_INTERVAL
		do
			lower := lower_entry.text.to_integer
			create interval.make (lower, integer)
			first.value_range.adapt (interval)
			if objects @ 2 /= Void then
				(objects @ 2).value_range.adapt (interval)	
			end
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			enable_project_modified
		end
		
	valid_upper (upper: INTEGER): BOOLEAN is
			-- Is `upper' a valid upper?
		do
			Result := upper >= lower_entry.text.to_integer
		end
		
	set_lower (integer: INTEGER) is
			-- Update property `lower' on all items in `objects'.
		require
			first_not_void: first /= Void
		local
			upper: INTEGER
			interval: INTEGER_INTERVAL
		do
			upper := upper_entry.text.to_integer
			create interval.make (integer, upper)
			first.value_range.adapt (interval)
			if objects @ 2 /= Void then
				(objects @ 2).value_range.adapt (interval)	
			end
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			enable_project_modified
		end
		
	valid_lower (lower: INTEGER): BOOLEAN is
			-- Is `lower' a valid upper?
		do
			Result := lower <= upper_entry.text.to_integer
		end

	Value_string: STRING is "Value"
	Step_string: STRING is "Step"
	Leap_string: STRING is "Leap"
	Upper_string: STRING is "Upper"
	Lower_string: STRING is "Lower"
	
	upper_entry, lower_entry, value_entry, step_entry, leap_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `Upper', `Lower' and `Value'.

end -- class GB_EV_GAUGE_EDITOR_CONSTRUCTOR
