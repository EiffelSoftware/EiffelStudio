indexing

	description: "Motif bulletin implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BULLETIN_M 

inherit

	BULLETIN_I
		export
			{NONE} all
		end;

	MANAGER_M;

	BULLETIN_R_M
		export
			{NONE} all
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
			ext_name_bull := a_bulletin.identifier.to_c;
			screen_object := create_bulletin 
					($ext_name_bull, 
					parent_screen_object (a_bulletin, widget_index),
					man);
		end;

	allow_recompute_size is	
			-- Allow Current bulletin to recompute its size
			-- according to its children.
		do
			set_xt_int (screen_object, MDIALOG_RESIZE_ANY, MresizePolicy);
		end;

	forbid_recompute_size is
			-- Forbid Current bulletin to recompute its size
			-- according to its children.
		do
			set_xt_int (screen_object, MDIALOG_RESIZE_NONE, MresizePolicy);
		end;

	set_default_button (but: POINTER) is
		do
			set_xt_widget (screen_object, but, MdefaultButton);
		end;

	set_default_position (flag: BOOLEAN) is 
		local
			ext_name: ANY;
		do
			ext_name := MdefaultPosition.to_c;
			set_boolean (screen_object, flag, $ext_name);
		end;

	circulate_up is
		do
			x_circulate_up (xt_display (screen_object), xt_window(screen_object));
		end;


	circulate_down is
		do
			x_circulate_down (xt_display (screen_object), xt_window(screen_object));
		end;

	restack_children (s_child_list: ARRAY [STACKABLE]) is
		local
			warray: ARRAY [POINTER];
			ind: INTEGER;
			arg1: ANY;
		do
			!!warray.make (s_child_list.lower, s_child_list.upper);
			from ind := s_child_list.lower
			until ind > s_child_list.upper
			loop
				warray.put(Xt_window (s_child_list.item(ind).screen_object), ind);
				ind := ind + 1;
			end;
			arg1 := warray.to_c;
			x_restack (Xt_display(screen_object), $arg1, s_child_list.count);
		end;
			

feature {NONE} -- External features

	create_bulletin (b_name: POINTER; scr_obj: POINTER; 
				man: BOOLEAN): POINTER is
		external
			"C"
		end;

end



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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
