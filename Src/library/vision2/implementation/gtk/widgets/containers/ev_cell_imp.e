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
			replace,
			needs_event_box
		end
		
	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

create
	make

feature -- initialization

	needs_event_box: BOOLEAN is do Result := False end

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_hbox_new (True, 0))
		end

feature -- Access

	item: EV_WIDGET
			-- Current item.

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			i: EV_WIDGET
			imp: EV_WIDGET_IMP
		do
			i := item
			if i /= Void then
				imp ?= i.implementation
				on_removed_item (imp)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (imp.c_object)
				feature {EV_GTK_EXTERNALS}.gtk_container_remove (container_widget, imp.c_object)
			end
			if v /= Void then
				imp ?= v.implementation
				feature {EV_GTK_EXTERNALS}.gtk_container_add (container_widget, imp.c_object)
				imp.update_request_size
				on_new_item (imp)
			end
			item := v
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CELL
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_CELL_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

