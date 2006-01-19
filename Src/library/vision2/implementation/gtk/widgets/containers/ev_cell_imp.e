indexing
	description:
		"Eiffel Vision cell, GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CELL_IMP

inherit
	EV_CELL_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			replace
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

create
	make

feature -- initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_event_box_new)
		end

feature -- Access

	item: EV_WIDGET
			-- Current item.

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		do
			Precursor {EV_CONTAINER_IMP} (v)
			item := v
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CELL
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_CELL_IMP

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

