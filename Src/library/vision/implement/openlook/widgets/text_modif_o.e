indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TEXT_MODIF_O 

inherit

	EVENT_HAND_O
		redefine
			create_context_data
		end

creation

	make
		
feature {NONE}

	create_context_data (widget_oui: WIDGET): MODIFY_DATA is
			-- Context data for the current action
		
		do
			!!Result.make (widget_oui, c_motion_action_current, c_motion_action_next, c_modify_action_start, c_modify_action_end, c_modify_action_text)
		end;

feature {NONE} -- External features

	c_motion_action_current: INTEGER is
		external
			"C"
		end;

	c_modify_action_text: STRING is
		external
			"C"
		end; 

	c_modify_action_end: INTEGER is
		external
			"C"
		end;

	c_modify_action_start: INTEGER is
		external
			"C"
		end;

	c_motion_action_next: INTEGER is
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
