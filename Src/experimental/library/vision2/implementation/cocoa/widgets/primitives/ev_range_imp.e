note
	description: "Eiffel Vision range. Cocoa implementation."
	author: "Daniel Furrer"
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

	make
		do
			create {NS_SLIDER}cocoa_item.make
			Precursor {EV_GAUGE_IMP}
			enable_tabable_to
			change_actions_internal := create_change_actions
			slider.set_action (agent
				local
					l_value: INTEGER
				do
					l_value := slider.double_value.floor
					value := l_value
					change_actions_internal.call ([l_value])
				end)
			set_is_initialized (True)
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

	interface: detachable EV_RANGE note option: stable attribute end;

	slider: NS_SLIDER
		do
			Result ?= cocoa_view
		end

end -- class EV_RANGE_IMP
