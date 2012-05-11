note
	description:
		"Eiffel Vision tooltipable. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOLTIPABLE_IMP

inherit
	EV_TOOLTIPABLE_I
		redefine
			interface
		end

feature -- Initialization

	tooltip: STRING_32
			-- Tooltip that has been set.
		local
			a_cs: EV_GTK_C_STRING
		do
			--a_cs := app_implementation.reusable_gtk_c_string
			Result := ""
		end

feature -- Element change

	set_tooltip (a_text: READABLE_STRING_GENERAL)
			-- Set `tooltip' to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := app_implementation.c_string_from_eiffel_string (a_text)
			--| FIXME IEK: Implement me
		end

feature {NONE} -- Implementation

	visual_widget: POINTER
		deferred
		end

	app_implementation: EV_APPLICATION_IMP
		deferred
		end

	tooltips_pointer: POINTER
			-- Pointer to the tooltips pointer
		do
			Result := app_implementation.tooltips
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOLTIPABLE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- EV_TOOLTIPABLE_IMP
