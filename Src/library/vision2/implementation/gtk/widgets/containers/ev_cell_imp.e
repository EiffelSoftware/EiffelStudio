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

create
	make

feature -- initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
		end

feature -- Access

	item: EV_WIDGET is
			-- Current item
		local
			p: POINTER
			imp: EV_ANY_IMP
			a_child_list: POINTER
		do
			a_child_list := C.gtk_container_children (container_widget)
			if a_child_list /= NULL then
				p := C.g_list_nth_data (a_child_list, 0)
				if p /= NULL then
					imp := eif_object_from_c (p)
					check
						imp_not_void: imp /= Void
							-- C object should have Eiffel object.
					end
					Result ?= imp.interface
				end
				C.g_list_free (a_child_list)
			end
		end

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			i: EV_WIDGET
			imp: EV_WIDGET_IMP
		do
			i := item
			if i /= Void then
				on_removed_item (i)
				imp ?= i.implementation
				C.gtk_object_ref (imp.c_object)
				C.gtk_container_remove (container_widget, imp.c_object)
				C.gtk_object_unref (imp.c_object)
			end
			if v /= Void then
				imp ?= v.implementation
				C.gtk_container_add (container_widget, imp.c_object)
				update_child_requisition (imp.c_object)
				on_new_item (v)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER
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

