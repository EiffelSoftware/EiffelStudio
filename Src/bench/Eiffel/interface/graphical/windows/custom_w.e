indexing

	description:	
		"Model for custom windows.";
	date: "$Date$";
	revision: "$Revision$"

class CUSTOM_W

inherit

	COMMAND;
	WINDOW_ATTRIBUTES;
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

	buttons: FORM;
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
			!! ok_b.make (Interface_names.b_Ok, buttons);
			!! apply_b.make (Interface_names.b_Apply, buttons);
			!! cancel_b.make (Interface_names.b_Cancel, buttons);
			buttons.set_fraction_base (3);
			attach_left (buttons, 5);
			attach_right (buttons, 5);
			attach_bottom (buttons, 5);
			buttons.attach_top (ok_b, 0);
			buttons.attach_top (apply_b, 0);
			buttons.attach_top (cancel_b, 0);
			buttons.attach_bottom (ok_b, 0);
			buttons.attach_bottom (apply_b, 0);
			buttons.attach_bottom (cancel_b, 0);
			buttons.attach_left (ok_b, 0);
			buttons.attach_right_position (ok_b, 1);
			buttons.attach_left_position (apply_b, 1);
			buttons.attach_right_position (apply_b, 2);
			buttons.attach_left_position (cancel_b, 2);
			buttons.attach_right (cancel_b, 0);
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
