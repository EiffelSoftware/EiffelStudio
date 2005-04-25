indexing 
	description: "Eiffel Vision vertical progress bar. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR_IMP

inherit
	EV_VERTICAL_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			initialize,
			interface
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_PROGRESS_BAR_IMP}
			{EV_GTK_EXTERNALS}.gtk_progress_bar_set_orientation (gtk_progress_bar, gtk_progress_bottom_to_top_enum)
		end
			
feature {EV_ANY_I} -- Implementation

	gtk_progress_bottom_to_top_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_PROGRESS_BOTTOM_TO_TOP"
		end

	interface: EV_VERTICAL_PROGRESS_BAR

end -- class EV_VERTICAL_PROGRESS_BAR_IMP

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

