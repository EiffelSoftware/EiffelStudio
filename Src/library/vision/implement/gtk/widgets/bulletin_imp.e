indexing

	description: 
		"EiffelVision bulletin, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"
	
class
	BULLETIN_IMP

inherit

	BULLETIN_I;

	MANAGER_IMP

creation

	make

feature {NONE} -- Creation

	make (a_bulletin: BULLETIN; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif bulletin.
		do
			widget := gtk_fixed_new
			widget_index := widget_manager.last_inserted_position			
--			mc ?= oui_parent.implementation;
--			widget_index := widget_manager.last_inserted_position;
--XX			bulletin_make (a_bulletin.identifier, mc, man);
--			set_margin_width (0);
--			set_margin_height (0);
		end;

feature -- Status setting

	set_default_position (flag: BOOLEAN) is
			-- Enable or disable default position according
			-- to `flag'.
		do	
			if flag then
--XX				enable_default_positioning
			else
--XX				disable_default_positioning
			end
		end

	allow_recompute_size is	
			-- Allow Current bulletin to recompute its size
			-- according to its children.
		do
--			set_resize_any
		end;

	forbid_recompute_size is
			-- Forbid Current bulletin to recompute its size
			-- according to its children.
		do
--XX			set_resize_none
		end;

feature -- Element change

	circulate_up is
			-- Circulate the children of this widget up.
		do
--XX			x_circulate_up (display.handle, window)
		end;

	circulate_down is
			-- Circulate the children of this widget down.
		do
--			x_circulate_down (display.handle, window)
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
--XX				warray.put (xt_window 
	--				(s_child_list.item (ind).screen_object), ind);
				ind := ind + 1;
			end;
			arg1 := warray.to_c;
--XX			x_restack_windows (mel_screen.display.handle, $arg1, s_child_list.count);
		end;
			


end

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--|----------------------------------------------------------------
