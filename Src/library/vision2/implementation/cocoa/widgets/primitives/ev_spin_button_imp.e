indexing
	description: "Eiffel Vision spin button. Cocoa Implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I
		undefine
			hide_border
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			on_key_event,
			default_key_processing_blocked,
			on_focus_changed,
			set_value,
			set_range
		redefine
			interface,
			initialize,
			make,
			dispose,
			set_default_minimum_size,
			cocoa_set_size
		end

	EV_TEXT_FIELD_IMP
		rename
			create_change_actions as create_text_change_actions,
			change_actions as text_change_actions,
			change_actions_internal as text_change_actions_internal
		redefine
			make,
			interface,
			initialize,
			set_text,
			dispose,
			on_change_actions,
			set_default_minimum_size,
			cocoa_set_size
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface)
			-- Create the spin button.
		do
			base_make (an_interface)
			create {NS_VIEW}cocoa_item.new
			create text_field.new
			create stepper.new
			view.add_subview (text_field)
			view.add_subview (stepper)
			stepper.set_value_wraps (False)
			change_actions_internal := create_change_actions
			stepper.set_action (agent
				do
					set_value (stepper.double_value.floor)
					change_actions_internal.call ([value])
				end)
			create text.make_empty
			align_text_left
		end

	initialize
		do
			Precursor {EV_TEXT_FIELD_IMP}
			ev_gauge_imp_initialize --| {EV_GAUGE} Precursor
		end

feature -- Element change

	set_value (a_value: INTEGER)
			-- Set `value' to `a_value'.
		do
			Precursor {EV_GAUGE_IMP} (a_value)
			set_text (a_value.out)
		end

	set_range
			-- Update widget range from `value_range'
		do
			Precursor {EV_GAUGE_IMP}
			stepper.set_min_value (value_range.lower)
			stepper.set_max_value (value_range.upper)
		end


	set_default_minimum_size
			-- Called after creation. Set the current size and notify the parent.
		do
			internal_set_minimum_size (maximum_character_width * 4 + stepper_width, 24)
		end

feature {NONE} -- Implementation

	on_change_actions
			do
				gauge_change_actions
			 	Precursor {EV_TEXT_FIELD_IMP}
			end


	gauge_change_actions
			-- A change action has occurred.
		local
			a_data: TUPLE [INTEGER_32]
		do
				if change_actions_internal /= Void then
					create a_data.default_create
					a_data.put (value, 1)
					change_actions_internal.call (a_data)
				end
		end

	dispose
		do
			Precursor {EV_TEXT_FIELD_IMP}
			Precursor {EV_GAUGE_IMP}
		end


	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			Precursor {EV_TEXT_FIELD_IMP} (a_text)
		end

	cocoa_set_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32)
			-- Cococa doesn't support Combo Boxes higher than the default. Just position it right
		local
			l_y_position: INTEGER
			l_height: INTEGER
			l_max_height: INTEGER
		do
			l_max_height := 24
			if a_height <= l_max_height then
				l_y_position := a_y_position
				l_height := a_height
			else
				l_y_position := a_y_position + ((a_height - l_max_height) // 2)
				l_height := l_max_height
			end
			view.set_frame (create {NS_RECT}.make_rect (a_x_position, a_y_position, a_width, a_height))
			text_field.set_frame (create {NS_RECT}.make_rect (0, l_y_position, a_width - stepper_width, l_height))
			stepper.set_frame (create {NS_RECT}.make_rect (a_width - stepper_width, l_y_position, stepper_width, l_height))
		end

feature {EV_ANY_I} -- Implementation

	stepper_width: INTEGER is 15

	interface: EV_SPIN_BUTTON;

	stepper: NS_STEPPER;

	view: NS_VIEW
		do
			Result ?= cocoa_item
		end

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_SPIN_BUTTON_IMP

