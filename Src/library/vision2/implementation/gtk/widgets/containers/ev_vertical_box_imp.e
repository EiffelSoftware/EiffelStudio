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
--		redefine
--			add_child--,
--			child_packing_changed
		end

create
	
	make

feature {NONE} -- Initialization
	
        make is
                        -- Create a fixed widget. 
		do
			widget := gtk_vbox_new (Default_homogeneous, Default_spacing)
			gtk_object_ref (widget)
		end	
	
feature -- Status report

	is_child_expandable (child: EV_WIDGET): BOOLEAN is
			-- Is the child corresponding to `index' expandable. ie: does it
			-- accept the parent to resize or move it.
		local
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= child.implementation
			Result := c_gtk_box_is_child_expandable (widget, child_imp.vbox_widget)
--			Result := c_gtk_box_is_child_expandable (widget, child_imp.hbox_widget)
		end
	
feature -- Status settings

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Make the child corresponding to `index' expandable if `flag',
			-- not expandable otherwise.
		local
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= child.implementation
			c_gtk_box_set_child_expandable (widget, child_imp.vbox_widget, flag)
--			c_gtk_box_set_child_expandable (widget, child_imp.hbox_widget, flag)
		end	

feature {EV_BOX} -- Implementation
	
--	add_child (child_imp: EV_WIDGET_IMP) is
--			-- Add child into composite. Several children
--			-- possible.
--			-- We have to redefine the packing procedure, as now
--			-- the `vbox' is the current container.
--		local
--			hbox_wid: POINTER
--		do
--			-- create of the gtk hbox where the widget will be placed
---			-- to allow horizontal resizing options.
--			hbox_wid := gtk_hbox_new (False, 0)
--
--			child_imp.set_hbox_widget (hbox_wid)
--			child_imp.set_vbox_widget (widget)
--			gtk_widget_show (child_imp.box_widget)
---
--			-- Put the child in the `hbox'.
--			gtk_box_pack_start (child_imp.hbox_widget, child_imp.widget, 
--			    True,
--			    child_imp.vertical_resizable, 0)
--
--			-- Put the `hbox' in the current container.
--			gtk_box_pack_start (widget, child_imp.hbox_widget, 
--			    True,
--			    child_imp.vertical_resizable, 0)
--
--			-- Sets the resizing options.
--			child_packing_changed (child_imp) 
--
--			gtk_object_unref (child_imp.widget)
--				-- After putting child_imp.widget in child_imp.hbox_widget
--				-- its number of references reached 2, so we have to
--				-- decrease it to 1.
 --				-- The number of reference of box_widget is 1 (its parent).
--		end

feature {EV_VERTICAL_BOX_IMP} -- Implementation

--	child_packing_changed (the_child: EV_WIDGET_IMP) is
--			-- changed the settings of his child `the_child'.
--			-- Redefined because the child is in a hbox to allow
--			-- horizontal resize options.
--		local
--			child_interface: EV_WIDGET
--		do
--			child_interface ?= the_child.interface
--			inspect
--				the_child.resize_type
--			when 0 then
--				-- 0 : no horizontal nor vertical resizing, the widget moves
--				c_gtk_box_set_child_options (widget, the_child.box_widget, is_child_expandable(child_interface), False)
--					-- To forbid vertical resizing
--				c_gtk_box_set_child_options (the_child.box_widget, the_child.widget, True, False)
--					-- To forbid horizontal resizing
--			when 1 then
--				-- 1 : only the width changes
--				c_gtk_box_set_child_options (widget, the_child.box_widget, is_child_expandable(child_interface), False)
--					-- To forbid vertical resizing
--				c_gtk_box_set_child_options (the_child.box_widget, the_child.widget, True, True)
--					-- To allow horizontal resizing
--			when 2 then
--				-- 2 : only the height changes
--				c_gtk_box_set_child_options (widget, the_child.box_widget, is_child_expandable(child_interface), True)
--					-- To allow vertical resizing
--				c_gtk_box_set_child_options (the_child.box_widget, the_child.widget, True, False)
--					-- To forbid horizontal resizing
--			when 3 then
--				-- 3 : both width and height change
--				c_gtk_box_set_child_options (widget, the_child.box_widget, is_child_expandable(child_interface), True)
--					-- To allow vertical resizing
--				c_gtk_box_set_child_options (the_child.box_widget, the_child.widget, True, True)
--					-- To allow horizontal resizing
--			end
--		end


end -- class EV_VERTICAL_BOX_IMP

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
