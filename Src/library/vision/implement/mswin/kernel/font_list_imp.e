indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	FONT_LIST_IMP 
 
inherit 
	FONT_LIST_I	
		rename
			position as index,
			go as go_i_th,
			offleft as before,
			offright as before
		end

	LINKED_LIST [FONT]
		rename
			make as ll_make
		export
			{NONE} ll_make
		end

create
	make

feature -- Initialization

	make (a_font_list: FONT_LIST) is
			-- Make the list.
		do
			ll_make
		end

feature -- Obsolete 

	search_equal (v: FONT) is
		obsolete "Use .compare_objects, search"
		do
		end

feature -- Inapplicable

	destroy is
		do
		end
 
end -- class FONT_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

