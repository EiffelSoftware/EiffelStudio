note
	description: "EiffelVision gauge. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE_IMP

inherit
	EV_PRIMITIVE_IMP
		redefine
			on_key_down,
			interface,
			make
		end

	EV_GAUGE_I
		redefine
			interface
		end

	EV_GAUGE_ACTION_SEQUENCES_IMP
		export
			{EV_CONTAINER_IMP, EV_INTERNAL_SILLY_WINDOW_IMP}
				change_actions_internal
		end

feature {NONE} -- Initialization

	make
			-- Default initialization of `Current'.
		do
			create value_range.make (0, 100)
			value_range.change_actions.extend (agent set_range)
			initialize_gauge_control
			Precursor {EV_PRIMITIVE_IMP}
		end

	initialize_gauge_control
			-- Initialize gauge control.
		do
			wel_set_range (0, 100)
			wel_set_step (1)
			wel_set_leap (10)
			wel_set_value (0)
		end

feature -- Status setting

	step_forward
			-- Increase `value' by `step'.
		local
			original_value: INTEGER
		do
			original_value := value
			wel_set_value (value_range.upper.min (value + step))
			if original_value /= value then
				if change_actions_internal /= Void then
					change_actions_internal.call ([value])
				end
			end
		end

	step_backward
			-- Decrease `value' by `step'.
		local
			original_value: INTEGER
		do
			original_value := value
			wel_set_value (value_range.lower.max (value - step))
			if original_value /= value then
				if change_actions_internal /= Void then
					change_actions_internal.call ([value])
				end
			end
		end

	leap_forward
			-- Increment `value' by `leap' if possible.
		local
			original_value: INTEGER
		do
			original_value := value
			wel_set_value (value_range.upper.min (value + leap))
			if original_value /= value then
				if change_actions_internal /= Void then
					change_actions_internal.call ([value])
				end
			end
		end

	leap_backward
			-- Decrement `value' by `leap' if possible.
		local
			original_value: INTEGER
		do
			original_value := value
			wel_set_value (value_range.lower.max (value - leap))
			if original_value /= value then
				if change_actions_internal /= Void then
					change_actions_internal.call ([value])
				end
			end
		end

feature -- Element change

	set_value (a_value: INTEGER)
			-- Assign `a_value' to `value'.
		local
			original_value: INTEGER
		do
			original_value := value
			wel_set_value (a_value)
			if original_value /= value then
				if change_actions_internal /= Void then
					change_actions_internal.call ([value])
				end
			end
		end

	set_step (a_step: INTEGER)
			-- Assign `a_step' to `step'.
		do
			wel_set_step (a_step)
		end

	set_leap (a_leap: INTEGER)
			-- Assign `a_leap' to `leap'.
		do
			wel_set_leap (a_leap)
		end

	set_range
			-- Reflect value of `value_range' in `Current'.
		do
			wel_set_range (value_range.lower, value_range.upper)
		end

feature -- Deferred

	on_scroll (scroll_code, pos: INTEGER)
			-- Called when gauge changed.
		do
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- A key has been pressed.
		do
			process_navigation_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	valid_maximum (a_position: INTEGER): BOOLEAN
			-- Is `a_position' valid as a maximum?
		do
			Result := True
		end

	wel_set_value (a_value: INTEGER)
		require
			exists: exists
			valid_minimum: a_value >= value_range.lower
			valid_maximum: valid_maximum (a_value)
		deferred
		end

	wel_set_step (a_step: INTEGER)
		require
			positive_line: a_step >= 0
		deferred
		end

	wel_set_leap (a_leap: INTEGER)
		require
			positive_leap: a_leap >= 0
		deferred
		end

	wel_set_range (a_minimum, a_maximum: INTEGER)
		require
			exists: exists
			valid_range: a_minimum <= a_maximum
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_GAUGE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GAUGE_IMP











