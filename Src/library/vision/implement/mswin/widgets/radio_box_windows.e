indexing
	description: "This class represents a MS_WINDOWS radio box"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BOX_WINDOWS

inherit
	RADIO_BOX_I

	BOX_WINDOWS
		redefine
			realize_children
		end

creation
	make

feature -- Initialization

	realize_current is
			-- Realize current object without it children.
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not exists then
				wc ?= parent
				wel_make (wc, "", x, y, width, height, id_default)
				realize_children
			end
		end;

	make (a_radio_box: RADIO_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make a radio box.
		do
			!! private_attributes
			parent ?= oui_parent.implementation;
			!! toggle_list.make;
			only_one := true;
			managed := man;
			set_form_width (Minimum_width)
		end

	set_always_one (flag: BOOLEAN) is
			-- Set `only_one' to `flag'.
		do
			only_one := flag
		end

feature {NONE} -- Implementation

	only_one: BOOLEAN

	realize_children is
			-- Realize the children
		local
			tb: TOGGLE_B_WINDOWS
			a_style: INTEGER
			c: CURSOR
		do
			c := toggle_list.cursor
			from
				toggle_list.start
			variant
				toggle_list.count - toggle_list.index
			until
				toggle_list.after
			loop
				tb := toggle_list.item;
				a_style := ws_child + ws_visible
				if only_one then
					a_style := a_style + bs_autoradiobutton
				else
					a_style := a_style + bs_radiobutton
				end
				check
					after1: not toggle_list.after
				end
				tb.realize;
				check
					after2: not toggle_list.after
				end
				toggle_list.forth
			end
			toggle_list.go_to (c)
		end

	wel_set_menu (wel_menu: WEL_MENU) is
		do
		end

	wel_children: LINKED_LIST [WEL_WINDOW]

end -- class RADIO_BOX_WINDOWS
 
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
