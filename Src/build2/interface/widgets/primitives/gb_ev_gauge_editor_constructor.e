indexing
	description: "Builds an attribute editor for modification of objects of type EV_GAUGE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			create value_entry.make (Current, Result, value_string, gb_ev_gauge_value, gb_ev_gauge_value_tooltip,
				agent set_value (?), agent valid_value (?), components)
			create step_entry.make (Current, Result, step_string, gb_ev_gauge_step, gb_ev_gauge_step_tooltip,
				agent set_step (?), agent positive_value (?), components)
			create leap_entry.make (Current, Result, leap_string, gb_ev_gauge_leap, gb_ev_gauge_leap_tooltip,
				agent set_leap (?), agent positive_value (?), components)
			create upper_entry.make (Current, Result, upper_string, gb_ev_gauge_upper, gb_ev_gauge_upper_tooltip,
				agent set_upper (?), agent valid_upper (?), components)
			create lower_entry.make (Current, Result, lower_string, gb_ev_gauge_lower, gb_ev_gauge_lower_tooltip,
				agent set_lower (?), agent valid_lower (?), components)
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			execution_agents.put (agent set_value (?), value_string)
			validate_agents.put (agent valid_value (?), value_string)
			execution_agents.put (agent set_step (?), step_string)
			validate_agents.put (agent positive_value (?), step_string)
			execution_agents.put (agent set_leap (?), leap_string)
			validate_agents.put (agent positive_value (?), leap_string)
			execution_agents.put (agent set_upper (?), upper_string)
			validate_agents.put (agent valid_upper (?), upper_string)
			execution_agents.put (agent set_lower (?), lower_string)
			validate_agents.put (agent valid_lower (?), lower_string)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			value_entry.update_constant_display (first.value.out)
			step_entry.update_constant_display (first.step.out)
			leap_entry.update_constant_display (first.leap.out)
			upper_entry.update_constant_display (first.value_range.upper.out)
			lower_entry.update_constant_display (first.value_range.lower.out)
		end
		
	set_up_user_events (actual_object: GB_OBJECT; vision2_object, an_object: like ev_type) is
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
			set_object (actual_object)
			objects.extend (an_object)
			objects.extend (vision2_object)
			widget.pointer_button_release_actions.force_extend (agent start_timer)
		end
		
	has_user_events: BOOLEAN is True
		-- Does `Current' have user events which must be set?
		
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
			for_first_object (agent {EV_GAUGE}.set_value (user_event_widget.value))
			update_editors
		end
		
	user_event_widget: like ev_type

	set_value (a_value: INTEGER) is
			-- Update property `value' on all items in `objects'.
		do
			for_all_objects (agent {EV_GAUGE}.set_value (a_value))
			update_editors
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
			update_editors
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
			update_editors
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
			adapt_value_range (object, interval)
			for_all_instance_referers (object, agent adapt_value_range (?, interval))
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			enable_project_modified
			update_editors
		end
		
	adapt_value_range (an_object: GB_OBJECT; value_range: INTEGER_INTERVAL) is
			-- Adapt value range of `an_object' to `value_range'.
		require
			object_not_void: an_object /= Void
			value_range_not_void: value_range /= Void
		local
			gauge: EV_GAUGE
		do
			gauge ?= an_object.object
			gauge.value_range.adapt (value_range)
			gauge ?= an_object.real_display_object
			if gauge /= Void then
				gauge.value_range.adapt (value_range)
			end
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
			adapt_value_range (object, interval)
			for_all_instance_referers (object, agent adapt_value_range (?, interval))
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			enable_project_modified
			update_editors
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
	
	upper_entry, lower_entry, value_entry, step_entry, leap_entry: GB_INTEGER_INPUT_FIELD;
		-- Input widgets for `Upper', `Lower' and `Value'.

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


end -- class GB_EV_GAUGE_EDITOR_CONSTRUCTOR
