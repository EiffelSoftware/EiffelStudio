indexing

	description:	
		"Model for custom windows.";
	date: "$Date$";
	revision: "$Revision$"

class CUSTOM_W

inherit

	INTERFACE_W;
	COMMAND;
	SET_WINDOW_ATTRIBUTES;
	FORM_D
		rename
			make as form_d_make
		export
			{NONE} form_d_make
		end

feature -- Access

	caller: CUSTOM_CALLER
			-- Associated caller

feature -- Status report

	window: WIDGET
			-- Widget where popup will be placed

feature -- Status setting

	set_window (wind: like window) is
			-- Set `window' to `win'.
		do
			window := wind
		end;  

feature {NONE} -- Interface initialization

	buttons: ROW_COLUMN;
			-- Buttons specifying the choice

	create_interface (a_parent: COMPOSITE) is
			-- Create interface with ok, cancel and apply button
			-- at bottom with `a_parent'
		local
			ok_b, apply_b, cancel_b: PUSH_B
		do
			form_d_make ("", a_parent);
			set_exclusive_grab;
			!! buttons.make ("", Current);
			buttons.set_row_layout;
			buttons.set_preferred_count (1);
			buttons.set_same_size;
			detach_top (buttons);	
			attach_left (buttons, 0);
			attach_right (buttons, 0);
			attach_bottom (buttons, 0);
			!! ok_b.make (l_Ok, buttons);
			!! cancel_b.make (l_Cancel, buttons);
			!! apply_b.make (l_Apply, buttons);
			ok_b.set_center_alignment;
			cancel_b.set_center_alignment;
			apply_b.set_center_alignment;
			ok_b.add_activate_action (Current, ok_action);
			cancel_b.add_activate_action (Current, Void);
			apply_b.add_activate_action (Current, apply_action);
		end;

	ok_action, apply_action: ANY is
			-- Action constants
		once
			!! Result;
		end

feature -- Execution

	execute (arg: ANY) is
			-- Execute the action of the buttons
		do
			if arg = ok_action then
				unrealize;
				popdown;
				caller.execute_ok_action (Current)
			elseif arg = apply_action then
				caller.execute_apply_action (Current)
			else
				unrealize;
				popdown
			end
		end;

end -- class CUSTOM_W
