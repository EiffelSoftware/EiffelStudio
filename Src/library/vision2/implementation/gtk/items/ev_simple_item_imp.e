indexing
	description: "EiffelVision simple item, gtk implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SIMPLE_ITEM_IMP

inherit
	EV_SIMPLE_ITEM_I

	EV_ITEM_IMP

	EV_TEXTABLE_IMP

	EV_PIXMAPABLE_IMP
		rename
			add_double_click_command as old_add_dblclk,
			remove_double_click_commands as old_remove_dblclk,
			set_parent as widget_set_parent,
			parent_set as widget_parent_set,
			parent_imp as widget_parent_imp
		undefine
			has_parent,
			set_foreground_color,
			set_background_color
		end

end -- class EV_SIMPLE_ITEM_IMP

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
