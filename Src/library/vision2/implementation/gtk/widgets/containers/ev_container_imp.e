indexing

	description: 
		"EiffelVision composite, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_CONTAINER_IMP
	
inherit
	EV_CONTAINER_I

	EV_WIDGET_IMP

	EV_GTK_CONTAINERS_EXTERNALS
	
feature -- Access
	
	client_width: INTEGER is
			-- Width of the client area of container.
			-- Redefined in children.
		do
			Result := 0
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
			-- Redefined in children.
		do
			Result := 0
		end

	background_pixmap: EV_PIXMAP
			-- the background pixmap
	
feature {EV_RADIO_BUTTON_IMP} -- Access
	
	radio_button_group: POINTER is
			-- Gtk radio button group for this container. 
			-- If no radio buttons are added inside this 
			-- container, return Default_pointer
		do
			if rbg_pointer = Void then
				Result := Default_pointer
			else
				Result := rbg_pointer
			end
		end
	
	set_rbg_pointer (new_rbg_pointer: POINTER) is
		do
			rbg_pointer := new_rbg_pointer
		end
	
feature -- Element change
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			-- Create `vbox_widget' and `hbox_widget'.
			add_child_packing (child_imp)

			-- Put the `vbox' into the current container. 
			gtk_container_add (GTK_CONTAINER (widget), child_imp.vbox_widget)

			-- Sets the resizing options.
			child_packing_changed (child_imp) 
		end

	add_child_packing (child_imp: EV_WIDGET_IMP) is
			-- put the child into a GtkHBox, which will be put in a GtkVBox.
		local
			hbox_wid, vbox_wid: POINTER
		do
			-- create of gtk hbox and vbox where the widget
			-- will be placed to allow horizontal and vertical
			-- resizing options.
			hbox_wid := gtk_hbox_new (False, 0)
			vbox_wid := gtk_vbox_new (False, 0)	

			child_imp.set_hbox_widget (hbox_wid)
			child_imp.set_vbox_widget (vbox_wid)
			gtk_widget_show (child_imp.hbox_widget)
			gtk_widget_show (child_imp.vbox_widget)

			-- Put the child in the `hbox'.
			gtk_box_pack_start (child_imp.hbox_widget, child_imp.widget, 
			    True,
			    child_imp.vertical_resizable, 0)

			-- Put the `hbox' in the `vbox'.
			gtk_box_pack_start (child_imp.vbox_widget, child_imp.hbox_widget, 
			    True,
			    child_imp.vertical_resizable, 0)

			gtk_object_unref (child_imp.widget)
				-- After putting child_imp.widget in child_imp.hbox_widget
				-- its number of references reached 2, so we have to
				-- decrease it to 1.
				-- The number of reference of box_widget is 1 (its parent).
		end

	remove_child (child_imp: EV_WIDGET_IMP) is	
			-- Remove the given child from the children of
			-- the container.
		do
			gtk_object_ref (child_imp.widget)
				-- Increment child_imp.vbox_widget to 2 so it will
				-- not be destroyed when removed from the `hbox_widget' below.

			-- Remove the child from the `hbox_widget' and remove the `vbox_widget'
			-- from the current container. 			
			gtk_container_remove (GTK_CONTAINER (child_imp.hbox_widget), child_imp.widget)
			gtk_container_remove (GTK_CONTAINER (child_imp.vbox_widget), child_imp.hbox_widget)
			gtk_container_remove (GTK_CONTAINER (widget), child_imp.vbox_widget)

			-- As they have no more reference, `vbox_widget' and `hbox_widget' have
			-- been destroyed.
			child_imp.set_hbox_widget (default_pointer)
			child_imp.set_vbox_widget (default_pointer)	
		end

	set_background_pixmap (pixmap: EV_PIXMAP) is
			-- Set the container background pixmap to `pixmap'.
		local
			pix_imp: EV_PIXMAP_IMP
		do
			pix_imp ?= pixmap.implementation

			c_gtk_container_set_bg_pixmap (widget, pix_imp.widget)
			gtk_widget_show (pix_imp.widget)

			background_pixmap := pixmap
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of the
			-- container to the children.
		do
			check
				not_yet_implemented: False
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the
			-- container to the children.
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Assertion test

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container.			
		do
			Result := c_gtk_container_nb_children (widget)= 0
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			if a_child.vbox_widget /= default_pointer then
				Result := c_gtk_container_has_child (widget, a_child.vbox_widget)
			else
				Result := c_gtk_container_has_child (widget, a_child.widget)
			end
		end

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			if a_child.vbox_widget /= default_pointer then
				Result := c_gtk_container_has_child (widget, a_child.vbox_widget)
			else
				Result := c_gtk_container_has_child (widget, a_child.widget)
			end
		end

feature {NONE} -- Implementation
	
	rbg_pointer: POINTER
						

feature {EV_CONTAINER_IMP, EV_WIDGET_IMP} -- Implementation

	child_packing_changed (the_child: EV_WIDGET_IMP) is
			-- changed the settings of his child `the_child'.
			-- The child is contained in a GtkHBox which itself, is in
			-- a GtkVBox. The GtkVBox is then in the current container.
		require
			child_resize_type_value_ok: ((the_child.resize_type >=0) and (the_child.resize_type <=3))
		local
			child_interface: EV_WIDGET
		do
			child_interface ?= the_child.interface
			inspect
				the_child.resize_type
			when 0 then
				-- 0 : no horizontal nor vertical resizing, the widget moves
				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, True, False)
					-- To forbid vertical resizing
				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, False)
					-- To forbid horizontal resizing
			when 1 then
				-- 1 : only the width changes
				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, True, False)
					-- To forbid vertical resizing
				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, True)
					-- To allow horizontal resizing
			when 2 then
				-- 2 : only the height changes
				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, True, True)
					-- To allow vertical resizing
				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, False)
					-- To forbid horizontal resizing
			when 3 then
				-- 3 : both width and height change
				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, True, True)
					-- To allow vertical resizing
				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, True)
					-- To allow horizontal resizing
			end
		end

end -- class EV_CONTAINER_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
