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
			create slider.make
			cocoa_view := slider
			Precursor {EV_GAUGE_IMP}
			enable_tabable_to
			slider.set_action (agent
				local
					l_value: INTEGER
				do
					l_value := slider.double_value.floor
					value := l_value
					change_actions.call ([l_value])
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

	slider: NS_SLIDER

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RANGE note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_RANGE_IMP
