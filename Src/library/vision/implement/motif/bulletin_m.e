indexing

	description: 
		"EiffelVision implementaiton of a Motif bulletin.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BULLETIN_M 

inherit

	BULLETIN_I;

	MANAGER_M
		undefine
			create_callback_struct
		end;

	MEL_BULLETIN_BOARD
		rename
			make as bulletin_make,
			make_no_auto_unmanage as bulletin_make_no_auto_unmanage,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen
		end

creation

	make

feature {NONE} -- Creation

	make (a_bulletin: BULLETIN; man: BOOLEAN) is
			-- Create a motif bulletin.
		local
			ext_name_bull: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			bulletin_make (a_bulletin.identifier,
					mel_parent (a_bulletin, widget_index),
					man);
			set_margin_width (0);
			set_margin_height (0);
		end;

feature -- Status setting

	allow_recompute_size is	
			-- Allow Current bulletin to recompute its size
			-- according to its children.
		do
			set_resize_any
		end;

	forbid_recompute_size is
			-- Forbid Current bulletin to recompute its size
			-- according to its children.
		do
			set_resize_none
		end;

feature -- Element change

	circulate_up is
			-- Circulate the children of this widget up.
		do
			x_circulate_up (display.handle, window)
		end;

	circulate_down is
			-- Circulate the children of this widget down.
		do
			x_circulate_down (mel_screen.display.handle, window)
		end;

	restack_children (s_child_list: ARRAY [STACKABLE]) is
			-- The stackable's in the array have to have the
			-- same parent.
		local
			warray: ARRAY [INTEGER];
			ind: INTEGER;
			arg1: ANY;
		do
			!! warray.make (s_child_list.lower, s_child_list.upper);
			from 
				ind := s_child_list.lower
			until 
				ind > s_child_list.upper
			loop
				warray.put (Xt_window(s_child_list.item(ind).screen_object), ind);
				ind := ind + 1;
			end;
			arg1 := warray.to_c;
			x_restack_windows (mel_screen.display.handle, $arg1, s_child_list.count);
		end;
			
end -- class BULLETIN_M

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
