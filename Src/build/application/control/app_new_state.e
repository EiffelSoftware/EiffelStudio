
class APP_NEW_STATE 

inherit

	COMMAND;
	DRAG_SOURCE
		redefine
			transportable
		end;
	APP_EDITOR_HOLE
		rename
			make as app_make
		redefine
			process_state, compatible
		end;
	NEW_STATE_STONE


creation

	make
	
feature 

	transportable: BOOLEAN is
		do
			Result := True
		end;

	source: WIDGET is
		do
			Result := Current
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.state_pixmap
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.create_edit_label)
		end;

	make (a_parent: COMPOSITE) is
		do
			app_make (a_parent);
			initialize_transport
			add_activate_action (Current, Void)
		end;

	data: BUILD_STATE;

feature {NONE}

	compatible (st: STONE): BOOLEAN is
		do
			Result := st.stone_type = Stone_types.state_type
		end;

	process_state (dropped: STATE_STONE) is
			-- Create a editor for the stone dropped
			-- if it is not already being edited.
		local
			state: BUILD_STATE;
		do
			state := dropped.data;
			if state /= Void then
				state.create_editor
			end
		end;

	execute (argument: ANY) is
			-- Create a new state
		local
			add_state_command: APP_ADD_STATE;
			new_state: BUILD_STATE
		do
			!!new_state.make;
			new_state.set_internal_name ("");
			!!add_state_command;
			add_state_command.set_initial_point;
			add_state_command.execute (new_state)	
		end

end
