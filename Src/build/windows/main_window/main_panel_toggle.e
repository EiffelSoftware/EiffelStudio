deferred class MAIN_PANEL_TOGGLE

inherit

	TOGGLE_B
		rename
			make as toggle_b_make,
			state as armed
		end;
	LICENCE_COMMAND;

feature {NONE}
	
	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			toggle_b_make (a_name, a_parent);
			add_activate_action (Current, Void);
			set_toggle_off;
			set_left_alignment
		end;

	work (arg: ANY) is
		do
			if main_panel.project_initialized then
				toggle_pressed		
			end
		end;

	toggle_pressed is
			-- Perform actions with Current is pressed.
		require
			project_initialized: main_panel.project_initialized
		deferred
		end;

end 
