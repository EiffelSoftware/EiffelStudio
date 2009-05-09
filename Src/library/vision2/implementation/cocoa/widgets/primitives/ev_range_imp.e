note
	description: "Eiffel Vision range. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RANGE_IMP

inherit
	EV_RANGE_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			make,
			interface,
			set_value,
			set_range
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the range control.
		do
			base_make (an_interface)
			create {NS_SLIDER}cocoa_item.new
			change_actions_internal := create_change_actions
			slider.set_action (agent
				local
					l_value: INTEGER
				do
					l_value := slider.double_value.floor
					value := l_value
					change_actions_internal.call ([l_value])
				end)
		end

	set_value (a_value: INTEGER)
			-- Set `value' to `a_value'.
		do
			Precursor {EV_GAUGE_IMP} (a_value)
			slider.set_double_value (a_value)
		end

	set_range
		do
			Precursor {EV_GAUGE_IMP}
			slider.set_min_value (value_range.lower)
			slider.set_max_value (value_range.upper)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RANGE;

	slider: NS_SLIDER
		do
			Result ?= cocoa_view
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_RANGE_IMP

