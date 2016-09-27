note
	description:
		"EiffelVision primitive, GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "primitive, base, widget"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PRIMITIVE_IMP

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_WIDGET_IMP
		redefine
			interface,
			make
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			Precursor {EV_WIDGET_IMP}
			initialize_tab_behavior
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PRIMITIVE note option: stable attribute end;

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Redefined by descendents.
		end

feature -- Status report

	is_tabable_to: BOOLEAN
			-- Is Current able to be tabbed to?
		do
			Result := {GTK}.gtk_widget_get_can_focus (visual_widget)
		end

	is_tabable_from: BOOLEAN
			-- Is Current able to be tabbed from?

	enable_tabable_to
			-- Make `is_tabable_to' `True'.
		do
			{GTK}.gtk_widget_set_can_focus (visual_widget, True)
		end

	disable_tabable_to
			-- Make `is_tabable_to' `False'.
		do
			{GTK}.gtk_widget_set_can_focus (visual_widget, False)
		end

	enable_tabable_from
			-- Make `is_tabable_from' `True'.
		do
			is_tabable_from := True
		end

	disable_tabable_from
			-- Make `is_tabable_from' `False'.
		do
			is_tabable_from := False
		end

feature {NONE} -- Initialization

	initialize_tab_behavior
			-- Initialize tab behavior for `Current'.
			-- Called by `initialize'.
		do
			if is_tabable_to then
				enable_tabable_from
			end
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_PRIMITIVE_IMP
