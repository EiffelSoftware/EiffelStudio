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

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.8.14  2001/02/02 00:52:46  rogers
--| On_key_down now calls process_tab_key before Precursor. This ensures that
--| any tab movement we do in our implementation can be overriden by the user
--| with key_press_actions.
--|
--| Revision 1.2.8.13  2000/11/01 01:56:31  manus
--| Cosmetics on Precursor
--|
--| Revision 1.2.8.12  2000/09/13 22:10:54  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.2.8.11  2000/09/13 19:14:14  rogers
--| Altered to use value_range from the interface. Removed now redundent
--| features. Comments, Formatting.
--|
--| Revision 1.2.8.10  2000/09/06 02:33:11  manus
--| No need for exporting to a class which does not belong to the system anymore
--|
--| Revision 1.2.8.9  2000/08/22 00:25:13  rogers
--| change_actions_internal, inherited from EV_GAUGE_ACTION_SEQUENCES_IMP is
--| now also exported to EV_INTERNAL_SILLY_WINDOW_IMP.
--|
--| Revision 1.2.8.8  2000/08/11 18:51:31  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.2.8.7  2000/08/08 02:31:17  manus
--| Added export of `change_actions_internal' to EV_CONTAINER_IMP where it is
--| used.
--|
--| Revision 1.2.8.6  2000/08/04 20:31:16  rogers
--| All action sequence calls through the interface have been replaced with
--| calls to the internal action sequences.
--|
--| Revision 1.2.8.5  2000/07/24 23:48:33  rogers
--| Now inherits EV_GAUGE_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.2.8.4  2000/06/22 19:10:09  rogers
--| All calls to `change_actions' are now passed the current value of
--| `Current'.
--|
--| Revision 1.2.8.3  2000/06/19 18:26:03  rogers
--| Comments, formatting.
--|
--| Revision 1.2.8.2  2000/06/19 17:48:33  rogers
--| Connected change_actions when user changes `value'.
--|
--| Revision 1.2.8.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/04/13 18:18:11  brendel
--| Default minimum = 0; value = 0.
--|
--| Revision 1.6  2000/02/15 16:49:25  brendel
--| Implementation of feature `range' moved to _IMP.
--|
--| Revision 1.5  2000/02/15 03:18:08  brendel
--| Cleanup.
--| Released.
--|
--| Revision 1.4  2000/02/14 22:30:34  brendel
--| Changed to comply with signature change of `set_range' in EV_GAUGE.
--| Now takes INTEGER_INTERVAL instead of 2 integers.
--|
--| Revision 1.3  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.6  2000/02/03 17:19:47  brendel
--| Implemented complying to new interface.
--|
--| Revision 1.2.10.5  2000/02/01 03:33:07  brendel
--| Added make_with_range.
--| Changed export status of interface.
--|
--| Revision 1.2.10.4  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.2.10.3  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.2  1999/12/17 00:40:17  rogers
--| Altered to fit in with the review branch. redefinition of interface.
--|
--| Revision 1.2.10.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
