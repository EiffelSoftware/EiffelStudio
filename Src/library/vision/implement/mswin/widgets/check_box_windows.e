indexing
	description: "This class represents a MS_WINDOWS check box"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_BOX_WINDOWS

inherit
	CHECK_BOX_I

	BOX_WINDOWS
		redefine
			realize_children
		end

creation
	make

feature {NONE} -- Initalization

	make (a_check_box: CHECK_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make a check box.
		do
			!! private_attributes
			parent ?= oui_parent.implementation;
			!! toggle_list.make;
			managed := man
			set_form_width (Minimum_width)
		end

feature {NONE} -- Implementation

	realize_current is
			-- Realize current and the children.
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not exists then
				wc ?= parent
				wel_make (wc, "", x, y, width, height, id_default)
				realize_children
			end
		end

	realize_children is
			-- Realize the children.
		local
			tb: TOGGLE_B_WINDOWS;
			c: CURSOR
			wc: WEL_COMPOSITE_WINDOW
		do
			if not exists then
				wc ?= parent
				wel_make (wc, "", x, y, width, height, id_default)
			end;
			from
				c := toggle_list.cursor;
				toggle_list.start
			variant
				toggle_list.count - toggle_list.index
			until
				toggle_list.after
			loop
				tb := toggle_list.item;
				tb.realize;
				toggle_list.forth
			end;
			toggle_list.go_to (c)
		end

	wel_children: LINKED_LIST [WEL_WINDOW]
			-- List of children

feature {NONE} -- Inapplicable

	wel_set_menu (wel_menu: WEL_MENU) is 
		do
		end

end -- class CHECK_BOX_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006 
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
