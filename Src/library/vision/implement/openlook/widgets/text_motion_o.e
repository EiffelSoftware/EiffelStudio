--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class TEXT_MOTION_O 

inherit

	EVENT_HAND_O
		redefine
			create_context_data
		end

creation

	make
	
feature {NONE}

	create_context_data (widget_oui: WIDGET): MOTION_DATA is
			-- Context data for the current action
		
		do
			!!Result.make (widget_oui, c_motion_action_current, c_motion_action_next);
		end;

feature {NONE} -- External features

	c_motion_action_current: INTEGER is
		external
			"C"
		end;

	c_motion_action_next: INTEGER is
		external
			"C"
		end; 

end

