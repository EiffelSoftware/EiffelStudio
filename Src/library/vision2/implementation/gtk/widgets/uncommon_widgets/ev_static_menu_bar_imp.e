--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision static menu bar, gtk implementation.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_STATIC_MENU_BAR_IMP

inherit
	EV_STATIC_MENU_BAR_I
		redefine
			parent_imp
		end

	EV_MENU_HOLDER_IMP
--		undefine
--			parent
		redefine
			parent_imp
		end

	EV_PRIMITIVE_IMP
--		undefine
--			parent
		redefine
			parent_imp
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
		do
		--FIXME	widget := gtk_menu_bar_new ()
--FIXME			gtk_menu_bar_set_shadow_type (c_object, GTK_SHADOW_NONE)
--			parent_imp ?= par.implementation
			check
				FIXME: false
			end
		end
	
--	make (par: EV_TITLED_WINDOW) is         
--			-- Create a menu widget with `par' as parent window.
--		local
--			par_imp: EV_TITLED_WINDOW_IMP
--		do
--			widget := gtk_menu_bar_new ()
--			parent_imp ?= par.implementation
--			check
--				good_implementation: parent_imp /= Void
--			end
--			show
--			parent_imp.add_static_menu (Current)
--		end	

feature -- Access

	parent_imp: EV_TITLED_WINDOW_IMP
			-- We have to redefine it here.

feature {NONE} -- Implementation	

	add_menu (menu_imp: EV_MENU_IMP) is
		local
			name: ANY
			i: POINTER
		do
			name := menu_imp.name.to_c
			i := gtk_menu_item_new_with_label ($name)
			gtk_menu_item_set_submenu (GTK_MENU_ITEM (i), menu_imp.c_object)
			gtk_menu_bar_append (GTK_MENU_BAR (c_object), i)
			gtk_widget_show (i)
		end

	remove_menu (menu_imp: EV_MENU_IMP) is
		do
			check
				not_yet_implemented: True
			end
		end

feature {NONE} -- Inapplicable

--	old_make is
--			-- Do not call.
--		do
--			check
--				Inapplicable: False
--			end
--		end

end -- class EV_STATIC_MENU_BAR_IMP

--!----------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.4.4  2000/02/04 18:24:25  oconnor
--| unreleased
--|
--| Revision 1.10.4.3  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.10.4.2  2000/01/27 19:29:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.4.1  1999/11/24 17:30:01  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.4  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.9.2.3  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
