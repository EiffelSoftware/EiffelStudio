indexing 
	status: "See notice at end of class."; 
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
 
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class FONT_LIST_IMP

