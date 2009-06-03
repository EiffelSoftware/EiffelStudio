note
	description:
		"Abstraction for objects that may be selected/unselected."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "deselect, deselectable, select, selected, selectable"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DESELECTABLE

inherit
	EV_SELECTABLE
		redefine
			implementation,
			is_in_default_state
		end

feature -- Status setting

	disable_select
			-- Deselect the object.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_select
		ensure
			unselected: action_sequence_call_counter = old action_sequence_call_counter implies not is_selected
		end

	toggle
			-- Change `is_selected'.
		require
			not_is_destroyed: not is_destroyed
			can_be_selected: not is_selected implies is_selectable
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		ensure
			is_selected_changed: action_sequence_call_counter = old action_sequence_call_counter implies is_selected /= old is_selected
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_SELECTABLE} and not is_selected
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_DESELECTABLE_I
			-- Responsible for interaction with native graphics toolkit.

invariant

	not_selectable_therefore_not_selected: not is_selectable implies not is_selected
		-- Some descendents of deselectable may only be selected when parented. This is
		-- any descendent in which the parent can be in a single selection mode, to combat the
		-- problem of adding two selected items, we have this assertion, so these items
		-- cannot be selected unless they are parented.


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




end -- class EV_DESELECTABLE

