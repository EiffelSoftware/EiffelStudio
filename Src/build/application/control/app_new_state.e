
class APP_NEW_STATE 

inherit

	COMMAND;
	HOLE
		rename
			target as source
		redefine
			stone, compatible
		end;
	ICON
		rename
			button as source,
			make_visible as make_icon_visible,
			identifier as oui_identifier
		end;
	ICON
		rename
			button as source,
			identifier as oui_identifier
		redefine
			make_visible
		select
			make_visible
		end;
	NEW_STATE_STONE

creation

	make
	
feature -- Creation

	make is
		do
			set_symbol (Pixmaps.state_pixmap);
			set_label ("Create/edit");
		end; 

feature

	original_stone: STATE;

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			register;
			add_activate_action (Current, Void);
			initialize_transport
		end;

	
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
