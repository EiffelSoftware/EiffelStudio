deferred class MAIN_PANEL_TOGGLE

inherit

	HOLE
		redefine
			process_any
			
		select
			init_toolkit
		end;
	TOGGLE_B
		rename
			make as toggle_b_make,
			state as armed,
			init_toolkit as toggle_b_init_toolkit
		end;
	LICENCE_COMMAND
		rename
			init_toolkit as licence_command_init_toolkit
		end

feature {NONE}

	stone_type: INTEGER is
		do
			Result := Stone_types.any_type
		end;

	target: WIDGET is
		do
			Result := Current		
		end;
	
	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			toggle_b_make (a_name, a_parent);
			add_activate_action (Current, Void);
			set_toggle_off;
			register;
			set_left_alignment
		end;

	work (arg: ANY) is
		do
			if main_panel.project_initialized then
				toggle_pressed		
			elseif armed then
				set_toggle_off
			else
				set_toggle_on
			end
		end;

	toggle_pressed is
			-- Perform actions with Current is pressed.
		require
			project_initialized: main_panel.project_initialized
		deferred
		end;

	process_any (stone: STONE) is
		local
			ed: EDITABLE
		do
			ed ?= stone.data;
			if ed /= Void then
				ed.create_editor
			end
		end;

end 
