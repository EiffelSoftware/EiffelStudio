indexing

	description:
		"EiffelVision implementation of all font names.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FONT_LIST_IMP 

inherit

	FONT_LIST_I
		rename
			position as index,
			go as go_i_th,
			offleft as before,
			offright as after
		end

	FIXED_LIST [FONT]
		rename
			make as list_make
		export
			{NONE} list_make
		end;

	SHARED_MEL_DISPLAY
		undefine
			copy, is_equal
		end

creation

	make

feature  {NONE} -- Initialization

	make (a_font_list: FONT_LIST) is
			-- Create a font list
		local
			list: MEL_FONT_LIST_NAMES;
			font: FONT;
			font_x: FONT_IMP;
			mel_display: MEL_DISPLAY
			a_screen: SCREEN;
		do
			a_screen := a_font_list.screen;
			if a_screen = Void then
				mel_display := last_open_display
			else
				mel_display ?= a_screen.implementation
			end;
			!! list.make (mel_display, "*", 10000);
			from	
				list.make_filled (list.count);
				list.start;	
				start
			until
				list.after
			loop
				if a_screen = Void then
					!! font.make -- Use last open display
				else
					!! font.make_for_screen (a_font_list.screen);
				end;
				font_x ?= font.implementation;
				font_x.only_set_name (list.item);
				replace (font);
				forth;
				list.forth
			end
		ensure
			valid_list: not has (Void)
		end; 

feature -- Update

	search_equal (v: like first) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (shallow equality);
			-- go off right if none.
		do
			from
				start
			until
				off or v.name.is_equal (item.name)
			loop
				forth
			end
		end; 

feature -- Removal

	destroy is
			-- Reset all entries in the list to Void.
		do
			from
				start
			until
				after
			loop
					-- Replace current item with Void
				replace (Void);
				forth
			end
		end; 

end -- class FONT_LIST_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

