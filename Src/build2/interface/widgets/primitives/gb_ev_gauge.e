indexing
	description: "Objects that manipulate objects of type EV_GAUGE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_GAUGE
	
	-- The following properties from EV_GAUGE are manipulated by `Current'.
	-- Step - Performed on the real object and the display_object.
	-- Value - Performed on the real object and the display_object.
	-- Leap - Performed on the real object and the display_object.

inherit
	
	GB_EV_ANY
		redefine
			attribute_editor,
			set_up_user_events,
			ev_type
		end
		
	GB_XML_UTILITIES
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
		local
			label: EV_LABEL
		do
			Result := Precursor {GB_EV_ANY}
			
			create label.make_with_text (Value_string)
			Result.extend (label)
			create value
			Result.extend (value)
			value.return_actions.extend (agent set_value)
			value.return_actions.extend (agent update_editors)
			
			create label.make_with_text (Step_string)
			Result.extend (label)
			create step
			Result.extend (step)
			step.return_actions.extend (agent set_step)
			step.return_actions.extend (agent update_editors)
			
			create label.make_with_text (Leap_string)
			Result.extend (label)
			create leap
			Result.extend (leap)
			leap.return_actions.extend (agent set_leap)
			leap.return_actions.extend (agent update_editors)
			
			create upper_entry.make (Current, Result, "Upper", agent set_upper (?), agent valid_upper (?))
			create lower_entry.make (Current, Result, "Lower", agent set_lower (?), agent valid_lower (?))
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			gauge: EV_GAUGE
		do
			gauge ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			gauge.default_create
			if gauge.value /= first.value then
				add_element_containing_integer (element, Value_string, objects.first.value)
			end
			if gauge.step /= first.step then
				add_element_containing_integer (element, Step_string, objects.first.step)
			end
			if gauge.leap /= first.leap then
				add_element_containing_integer (element, Leap_string, objects.first.leap)
			end
				-- We always store the lower and upper values for the value range, as it is much easier to
				-- restore them if we know they are always together. We need them in pairs for the
				-- restoration anyway.
			if gauge.value_range.lower /= first.value_range.lower or gauge.value_range.upper /= first.value_range.upper then
				add_element_containing_integer (element, Lower_string, objects.first.value_range.lower)
				add_element_containing_integer (element, Upper_string, objects.first.value_range.upper)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			element_info2: ELEMENT_INFORMATION
			interval: INTEGER_INTERVAL
		do
			full_information := get_unique_full_info (element)
			
				-- We must set the upper and lower first as they affect the valid values that may
				-- be set.
			element_info := full_information @ (Upper_string)
			if element_info /= Void then
				element_info2 := full_information @ (Lower_string)
				check
					info_not_void: element_info2 /= Void
				end
				create interval.make (element_info2.data.to_integer, element_info.data.to_integer)
				first.value_range.adapt (interval)
				(objects @ 2).value_range.adapt (interval)
			end
			
			element_info := full_information @ (Value_string)
			if element_info /= Void then
				for_all_objects (agent {EV_GAUGE}.set_value (element_info.data.to_integer))
			end
			
			element_info := full_information @ (Step_string)
			if element_info /= Void then
				for_all_objects (agent {EV_GAUGE}.set_step (element_info.data.to_integer))
			end
			
			element_info := full_information @ (Leap_string)
			if element_info /= Void then
				for_all_objects (agent {EV_GAUGE}.set_leap (element_info.data.to_integer))
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; a_name, a_type: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info, element_info2: ELEMENT_INFORMATION
			lower, upper: STRING
		do
			Result := ""
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (Upper_string)
			if element_info /= Void then
				element_info2 := full_information @ (Lower_string)
				check
					info_not_void: element_info2 /= Void
				end
				lower := element_info2.data
				upper := element_info.data
				Result := a_name + ".value_range.adapt(create {INTEGER_INTERVAL}.make (" + lower + ", " + upper + "))"
			end
			
			element_info := full_information @ (Value_string)
			if element_info /= Void then
				Result := Result + indent + a_name + ".set_value (" + element_info.data + ")"
			end
			element_info := full_information @ (Step_string)
			if element_info /= Void then
				Result := Result + indent + a_name + ".set_step (" + element_info.data + ")"
			end
			element_info := full_information @ (Leap_string)
			if element_info /= Void then
				Result := Result + indent + a_name + ".set_leap (" + element_info.data + ")"
			end
			Result := strip_leading_indent (Result)
		end

feature {NONE} -- Implementation

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			value.return_actions.block
			step.return_actions.block
			leap.return_actions.block
			
			value.set_text (first.value.out)
			step.set_text (first.step.out)
			leap.set_text (first.leap.out)

			value.return_actions.resume
			step.return_actions.resume
			leap.return_actions.resume
			
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

	set_value is
			-- Update property `value' on all items in `objects'.
		require
			first_not_void: first /= Void
		local
			a_value: INTEGER
		do
			if value.text /= Void and then value.text.is_integer then
				a_value := value.text.to_integer
				if a_value > 0 and first.value_range.has (a_value) then
					for_all_objects (agent {EV_GAUGE}.set_value (a_value))
				end
			end
		end
		
	set_step is
			-- Update property `step' on all items in `objects'.
		require
			first_not_void: first /= Void
		local
			a_value: INTEGER
		do
			if step.text /= Void and then step.text.is_integer then
				a_value := step.text.to_integer
				if a_value > 0 then
					for_all_objects (agent {EV_GAUGE}.set_step (a_value))
				end
			end
		end
		
	set_leap is
			-- Update property `leap' on all items in `objects'.
		require
			first_not_void: first /= Void
		local
			a_value: INTEGER
		do
			if leap.text /= Void and then leap.text.is_integer then
				a_value := leap.text.to_integer
				if a_value > 0 then
					for_all_objects (agent {EV_GAUGE}.set_leap (a_value))
				end
			end
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
			(objects @ 2).value_range.adapt (interval)
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			system_status.enable_project_modified
			command_handler.update
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
			(objects @ 2).value_range.adapt (interval)
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			system_status.enable_project_modified
			command_handler.update
		end
		
	valid_lower (lower: INTEGER): BOOLEAN is
			-- Is `lower' a valid upper?
		do
			Result := lower <= upper_entry.text.to_integer
		end
		
	value, step, leap: EV_TEXT_FIELD

	Value_string: STRING is "Value"
	Step_string: STRING is "Step"
	Leap_string: STRING is "Leap"
	Upper_string: STRING is "Upper"
	Lower_string: STRING is "Lower"
	
	upper_entry, lower_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `Upper' and `Lower'.

end -- class GB_EV_WINDOW