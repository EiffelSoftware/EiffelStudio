
class APP_NEW_STATE 

inherit

	COMMAND;
	APP_EDITOR_HOLE
		rename
			make as app_make
		redefine
			stone, compatible
		end;
	NEW_STATE_STONE

creation

	make
	
feature 

	source: WIDGET is
		do
			Result := Current
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.state_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.create_edit_label
		end;

	make (a_parent: COMPOSITE) is
		do
			app_make (a_parent);
			initialize_transport
			add_activate_action (Current, Void)
		end;

	original_stone: STATE;

feature {NONE}

	stone: STATE_STONE;

	compatible (s: STATE_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;
	
	process_stone is
			-- Create a editor for the stone dropped
			-- if it is not already being edited.
		local
			state: STATE;
		do
			state := stone.original_stone;
			if state /= Void then
				state.create_editor
			end
		end;

	execute (argument: ANY) is
			-- Create a new state
		local
			add_state_command: APP_ADD_STATE;
			new_state: STATE
		do
			!!new_state.make;
			new_state.set_internal_name ("");
			!!add_state_command;
			add_state_command.set_initial_point;
			add_state_command.execute (new_state)	
		end

end
