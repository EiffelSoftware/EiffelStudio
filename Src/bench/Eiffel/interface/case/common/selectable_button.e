indexing   
	description: 
		"Button associated to a command and represented by a bitmap that %
		%may change, depending upon the button's state (selected or not).";
	date: "$Date$";
	revision: "$Revision $"

class 
	SELECTABLE_BUTTON

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON
		rename
			make as button_make
		end

creation
	make

feature {NONE} -- Initialization


	make (a_parent: EV_TOOL_BAR; pix: EV_PIXMAP; com1,com2: EV_ROUTINE_COMMAND) is
		-- Creation of the Button
		require
			pixmaps_exist: pix /= Void
			at_least_one_first_command_exists: com1 /= Void
			parent_exists: a_parent /= Void
		do
			button_make(a_parent)
			set_pixmap(pix)
			add_select_command(com1,Void)
			if com2 /= Void then
				add_unselect_command(com2,Void)
			end
		end

end -- class SELECTABLE_BUTTON



