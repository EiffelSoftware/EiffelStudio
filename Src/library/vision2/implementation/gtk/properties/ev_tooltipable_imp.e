indexing
	description: 
		"Eiffel Vision tooltipable. GTK+ implementation."
	status: "See notice at end of class"
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

	EV_ANY_IMP
		undefine
			needs_event_box,
			destroy
		redefine
			interface
		end

feature -- Initialization

	tooltip: STRING is
			-- Tooltip that has been set.
		local
			tip_ptr: POINTER
		do
			tip_ptr := {EV_GTK_EXTERNALS}.gtk_tooltips_data_get (visual_widget)
			if tip_ptr /= NULL then
				create Result.make_from_c ({EV_GTK_EXTERNALS}.gtk_tooltips_data_struct_tip_text (tip_ptr))
			else
				Result := ""
			end
		end

feature -- Element change

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make (a_text)
			{EV_GTK_EXTERNALS}.gtk_tooltips_set_tip (
				app_implementation.tooltips,
				visual_widget,
				a_cs.item,
				NULL
			)
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
	    do
			{EV_GTK_EXTERNALS}.gtk_tooltips_set_tip (
				app_implementation.tooltips,
				visual_widget,
				NULL,
				NULL
			)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE

end -- EV_TOOLTIPABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

