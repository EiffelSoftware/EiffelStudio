indexing
	description:
		"Eiffel Vision tool bar separator. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	is_dockable: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create implementation for `an_interface'
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_vseparator_new)
		end
	
	initialize is
			-- Initialize some stuff useless to separators.
		do
			Precursor {EV_ITEM_IMP}
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, 10, -1)
			is_initialized := True
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SEPARATOR

end -- class EV_TOOL_BAR_SEPARATOR_I

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

