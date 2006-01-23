indexing

	description:
		"EiffelVision implementation of all font names."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

create

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
			create list.make (mel_display, "*", 10000);
			from	
				list.make_filled (list.count);
				list.start;	
				start
			until
				list.after
			loop
				if a_screen = Void then
					create font.make -- Use last open display
				else
					create font.make_for_screen (a_font_list.screen);
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


