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

	EV_MENU_CONTAINER_IMP
		rename
			make as old_make
		redefine
			parent_imp
		end

	EV_PRIMITIVE_IMP
		rename
			make as old_make
		redefine
			parent_imp
		end

creation
	make

feature {NONE} -- Initialization
	
	make (par: EV_WINDOW) is         
			-- Create a menu widget with `par' as parent window.
		local
			par_imp: EV_WINDOW_IMP
		do
			widget := gtk_menu_bar_new ()
			show
			parent_imp ?= par.implementation
			check
				good_implementation: parent_imp /= Void
			end
			parent_imp.add_static_menu (Current)
		end	

feature -- Access

	parent_imp: EV_WINDOW_IMP
			-- We have to redefine it here.

feature {NONE} -- Implementation	

	add_menu (menu_imp: EV_MENU_IMP) is
		local
			name: ANY
			item: POINTER
		do
			name ?= menu_imp.name.to_c
			item := gtk_menu_item_new_with_label ($name)
			gtk_menu_item_set_submenu (GTK_MENU_ITEM (item), menu_imp.widget)
			gtk_menu_bar_append (GTK_MENU_BAR (widget), item)
			gtk_widget_show (item)
		end

	remove_menu (menu_imp: EV_MENU_IMP) is
		do
			check
				not_yet_implemented: True
			end
		end

feature {NONE} -- Inapplicable

	old_make is
			-- Do not call.
		do
			check
				Inapplicable: False
			end
		end

end -- class EV_STATIC_MENU_BAR_IMP

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------
