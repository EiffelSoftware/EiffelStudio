
class APP_NEW_STATE 

inherit

	COMMAND
		export
			{NONE} all
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	HOLE
		rename
			target as source
		
		export
			{NONE} all
		redefine
			stone, compatible
		end;
	ICON
		rename
			button as source,
			make_visible as make_icon_visible,
			identifier as oui_identifier
		
		export
			{NONE} all
		undefine
			init_toolkit
		end;
	ICON
		rename
			button as source,
			identifier as oui_identifier
		undefine
			init_toolkit
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
			set_symbol (State_pixmap);
			set_label ("Create/edit");
		end; 

feature

	original_stone: STATE;

	make_visible (a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_icon_visible (a_parent);
			register;
			add_activate_action (Current, Nothing);
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
