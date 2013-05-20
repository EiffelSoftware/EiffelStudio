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
			l_text: POINTER
			l_cs: EV_GTK_C_STRING
		do
			l_text := {GTK2}.gtk_widget_get_tooltip_text (visual_widget)
			if l_text /= default_pointer then
				create l_cs.share_from_pointer (l_text)
				Result := l_cs.string
			else
				Result := ""
			end
		end

feature -- Element change

	set_tooltip (a_text: READABLE_STRING_GENERAL)
			-- Set `tooltip' to `a_text'.
		local
			l_cs: EV_GTK_C_STRING
		do
			l_cs := app_implementation.c_string_from_eiffel_string (a_text)
			{GTK2}.gtk_widget_set_tooltip_text (visual_widget, l_cs.item)
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
