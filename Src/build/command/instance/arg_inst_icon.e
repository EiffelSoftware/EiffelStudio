
class ARG_INST_ICON 

inherit

	ARG_INST_STONE
		redefine
			transportable
		end;
	COMMAND;
	COMMAND_ARGS;
	ICON_STONE
		rename
			set_original_stone as old_set_original_stone
		undefine
			stone_cursor
		redefine
			original_stone, set_widget_default
		end;
	ICON_STONE
		undefine
			stone_cursor
		redefine
			set_original_stone, original_stone, set_widget_default
		select
			set_original_stone
		end;
	HOLE
		rename
			target as source
		redefine
			stone, compatible
		end;
	ERROR_POPUPER

feature 

	set_widget_default is
		do
			register;
			source.add_button_press_action (3, Current, First);
			source.add_button_press_action (1, Current, Second);
			initialize_transport;
			source.set_action ("!Shift<Btn1Down>", show_command, Current);
			source.set_action ("!Shift<Btn1Up>", show_command, Void);
		end;

-- **************
-- Stone features
-- **************

	original_stone: ARG_INSTANCE;

	
feature {NONE}

	transportable: BOOLEAN;

	context: CONTEXT_STONE is
		do
			Result := original_stone.context
		end;
	
	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

	type: CONTEXT_TYPE is
		do
			Result := original_stone.type
		end;

	
feature 

	set_original_stone (arg: ARG_INSTANCE) is
		do
			old_set_original_stone (arg);
			original_stone.set_icon_stone (Current);
		end;

-- *************
-- Hole features
-- *************

	
feature {NONE}

	stone: CONTEXT_STONE;

	compatible (s: CONTEXT_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;
	
	execute (argument: ANY) is
		do
			if argument = First then
				transportable := True
			elseif argument = Second then
				if instantiated then
					transportable := True
				else
					transportable := False
				end
			end
		end;

	process_stone is
		local 	
			instantiate_cmd: INSTANTIATE_CMD
		do
			if (original_stone.eiffel_type.is_equal (stone.eiffel_type)) then
				!!instantiate_cmd.make (original_stone);
				instantiate_cmd.execute (stone.original_stone);
			else
				error_box.popup (Current, Messages.incomp_er, Void)
			end;
		end;

end
