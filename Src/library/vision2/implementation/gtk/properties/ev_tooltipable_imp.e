indexing
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

	tooltip: STRING_32 is
			-- Tooltip that has been set.
		local
			tip_ptr, l_null: POINTER
			a_cs: EV_GTK_C_STRING
		do
			a_cs := app_implementation.reusable_gtk_c_string
			tip_ptr := {EV_GTK_EXTERNALS}.gtk_tooltips_data_get (visual_widget)
			if tip_ptr /= l_null then
				a_cs.share_from_pointer ({EV_GTK_EXTERNALS}.gtk_tooltips_data_struct_tip_text (tip_ptr))
				Result := a_cs.string
			else
				Result := ""
			end
		end

feature -- Element change

	set_tooltip (a_text: STRING_GENERAL) is
			-- Set `tooltip' to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
			a_win, l_null: POINTER
		do
			a_cs := app_implementation.c_string_from_eiffel_string (a_text)
			{EV_GTK_EXTERNALS}.gtk_tooltips_set_tip (
				tooltips_pointer,
				visual_widget,
				a_cs.item,
				l_null
			)
			if a_text.is_empty then
					-- Hide the existing tooltip window.
				a_win := {EV_GTK_EXTERNALS}.gtk_tooltips_struct_tip_window (tooltips_pointer)
				if a_win /= default_pointer then
					{EV_GTK_EXTERNALS}.gtk_widget_hide (a_win)
				end
			end
		end

feature {NONE} -- Implementation

	visual_widget: POINTER
		deferred
		end

	app_implementation: EV_APPLICATION_IMP
		deferred
		end

	tooltips_pointer: POINTER is
			-- Pointer to the tooltips pointer
		do
			Result := app_implementation.tooltips
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE;

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




end -- EV_TOOLTIPABLE_IMP

