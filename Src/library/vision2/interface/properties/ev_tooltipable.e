indexing
	description:
		"Abstraction for objects that have a tooltip property."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tooltip, popup, hint"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOLTIPABLE

inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state
		end

feature -- Access

	tooltip: STRING_32 is
			-- Tooltip displayed on `Current'.
			-- If `Result' is empty then no tooltip displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tooltip
		ensure
			bridge_ok: equal (Result, implementation.tooltip)
			not_void: Result /= Void
			cloned: Result /= implementation.tooltip
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL) is
			-- Assign `a_tooltip' to `tooltip'.
		require
			not_destroyed: not is_destroyed
			tooltip: a_tooltip /= Void
		do
			implementation.set_tooltip (a_tooltip)
		ensure
			tooltip_assigned: tooltip.is_equal (a_tooltip)
			cloned: tooltip /= a_tooltip
		end

	remove_tooltip is
			-- Make `tooltip' empty.
		require
			not_destroyed: not is_destroyed
		do
			set_tooltip ("")
		ensure
			tooltip_removed: tooltip.is_empty
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ANY} and tooltip.is_empty
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TOOLTIPABLE_I;
			-- Responsible for interaction with native graphics toolkit.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TOOLTIPABLE

