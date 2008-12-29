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
			initialize
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_WIDGET_IMP}
			initialize_tab_behavior
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PRIMITIVE;

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
			Result := {EV_GTK_EXTERNALS}.gtk_widget_flags (visual_widget) & {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM = {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM
		end

	is_tabable_from: BOOLEAN
			-- Is Current able to be tabbed from?

	enable_tabable_to
			-- Make `is_tabable_to' `True'.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_set_flags (visual_widget, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
		end

	disable_tabable_to
			-- Make `is_tabable_to' `False'.
		do
			{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (visual_widget, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PRIMITIVE_IMP

