indexing

	description: 
		"EiffelVision implementaiton of a Motif bulletin.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	BULLETIN_IMP

inherit

	BULLETIN_I;

	MANAGER_IMP
		rename
			is_shown as shown
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
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		end

creation

	make

feature {NONE} -- Creation

	make (a_bulletin: BULLETIN; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif bulletin.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			bulletin_make (a_bulletin.identifier, mc, man);
			set_margin_width (0);
			set_margin_height (0);
		end;

feature -- Status setting

	set_default_position (flag: BOOLEAN) is
			-- Enable or disable default position according
			-- to `flag'.
		do	
			if flag then
				enable_default_positioning
			else
				disable_default_positioning
			end
		end

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
			x_circulate_down (display.handle, window)
		end;

	restack_children (s_child_list: ARRAY [STACKABLE]) is
			-- The stackable's in the array have to have the
			-- same parent.
		local
			warray: ARRAY [POINTER];
			ind: INTEGER;
			arg1: ANY;
		do
			!! warray.make (s_child_list.lower, s_child_list.upper);
			from 
				ind := s_child_list.lower
			until 
				ind > s_child_list.upper
			loop
				warray.put (xt_window 
					(s_child_list.item (ind).screen_object), ind);
				ind := ind + 1;
			end;
			arg1 := warray.to_c;
			x_restack_windows (mel_screen.display.handle, $arg1, s_child_list.count);
		end;
			
end -- class BULLETIN_IMP


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

