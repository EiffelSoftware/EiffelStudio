indexing

	description: 
		"EiffelVision vertical box, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_VERTICAL_BOX_IMP
	
inherit
	
	EV_VERTICAL_BOX_I
		
	EV_BOX_IMP
		redefine
			add_child,
			child_packing_changed
		end

creation
	
	make

feature {NONE} -- Initialization
	
        make is
                        -- Create a fixed widget. 
		do
			widget := gtk_vbox_new (Default_homogeneous, Default_spacing)
			gtk_object_ref (widget)
		end	
	
feature {EV_BOX} -- Implementation
	
	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. Several children
			-- possible.
		local
			hbox_wid: POINTER
		do
			-- creation of the gtk hbox where the widget will be placed
			-- to allow horizontal resizing options.
			hbox_wid := gtk_hbox_new (False, 0)
			gtk_object_ref (hbox_wid)
				-- setting the number of references to 1

			child_imp.set_box_widget (hbox_wid)
			gtk_widget_show (child_imp.box_widget)

			gtk_box_pack_start (child_imp.box_widget, child_imp.widget, 
			    child_imp.expandable,
			    child_imp.vertical_resizable, 0)

			gtk_box_pack_start (widget, child_imp.box_widget, 
			    child_imp.expandable,
			    child_imp.vertical_resizable, 0)

			gtk_object_unref (child_imp.widget)
				-- After putting child_imp.widget in child_imp.box_widget
				-- its number of references reached 2, so we have to
				-- decrease it to 1.
 		end

feature {EV_VERTICAL_BOX_IMP} -- Implementation

	child_packing_changed (the_child: EV_WIDGET_IMP) is
			-- changed the settings of his child `the_child'.
			-- Redefined because the child is in a hbox to allow
			-- horizontal resize options. 
		do
			inspect
				the_child.resize_type
			when 0 then
				-- 0 : no horizontal nor vertical resizing, the widget moves
				c_gtk_box_set_child_options (widget, the_child.box_widget, the_child.expandable, False)
					-- To forbid vertical resizing
				c_gtk_box_set_child_options (the_child.box_widget, the_child.widget, True, False)
					-- To forbid horizontal resizing
			when 1 then
				-- 1 : only the width changes
				c_gtk_box_set_child_options (widget, the_child.box_widget, the_child.expandable, False)
					-- To forbid vertical resizing
				c_gtk_box_set_child_options (the_child.box_widget, the_child.widget, True, True)
					-- To allow horizontal resizing
			when 2 then
				-- 2 : only the height changes
				c_gtk_box_set_child_options (widget, the_child.box_widget, the_child.expandable, True)
					-- To allow vertical resizing
				c_gtk_box_set_child_options (the_child.box_widget, the_child.widget, True, False)
					-- To forbid horizontal resizing
			when 3 then
				-- 3 : both width and height change
				c_gtk_box_set_child_options (widget, the_child.box_widget, the_child.expandable, True)
					-- To allow vertical resizing
				c_gtk_box_set_child_options (the_child.box_widget, the_child.widget, True, True)
					-- To allow horizontal resizing
			end
		end


end -- class EV_VERTICAL_BOX_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
