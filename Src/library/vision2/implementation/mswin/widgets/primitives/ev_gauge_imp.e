indexing
	description: "EiffelVision gauge. Mswindows implementation."
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
			initialize
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

	initialize is
			-- Default initialization of `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			create value_range.make (0, 100)
			value_range.change_actions.extend (~set_range)
			wel_set_range (0, 100)
			wel_set_step (1)
			wel_set_leap (10)
			wel_set_value (0)
		end

feature -- Status setting

	step_forward is
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

	step_backward is
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

	leap_forward is
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

	leap_backward is
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

	set_value (a_value: INTEGER) is
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

	set_step (a_step: INTEGER) is
			-- Assign `a_step' to `step'.
		do
			wel_set_step (a_step)
		end

	set_leap (a_leap: INTEGER) is
			-- Assign `a_leap' to `leap'.
		do
			wel_set_leap (a_leap)
		end

	set_range is
			-- Reflect value of `value_range' in `Current'.
		do
			wel_set_range (value_range.lower, value_range.upper)
		end

feature -- Deferred

	on_scroll (scroll_code, pos: INTEGER) is
			-- Called when gauge changed.
		do
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		do
			process_tab_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	wel_set_value (a_value: INTEGER) is
		deferred
		end

	wel_set_step (a_step: INTEGER) is
		deferred
		end

	wel_set_leap (a_leap: INTEGER) is
		deferred
		end

	wel_set_range (a_minimum, a_maximum: INTEGER) is
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GAUGE

end -- class EV_GAUGE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

