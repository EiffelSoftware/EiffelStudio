
class ARG_INST_ICON 

inherit

	ARG_INST_STONE
		redefine
			transportable
		end;

	COMMAND
		export
			{NONE} all
		end;

	COMMAND_ARGS
		export
			{NONE} all
		end;

	ICON_STONE
		rename
			set_original_stone as old_set_original_stone,
			make_visible as make_icon_visible,
			identifier as oui_identifier,
			make as icon_stone_make
		export
			{ANY} deselect, select_icon
		undefine
			init_toolkit, stone_cursor
		redefine
			original_stone
		end;

	ICON_STONE
		rename
			identifier as oui_identifier,
			make as icon_stone_make
		undefine
			init_toolkit, stone_cursor
		redefine
			make_visible, set_original_stone, original_stone
		select
			make_visible, set_original_stone
		end;

	HOLE
		rename
			target as source
		export
			{NONE} all
		redefine
			stone, compatible
		end;

	ERROR_POPUPER
		export
			{NONE} all
		end


feature 

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			register;
			source.add_button_press_action (3, Current, First);
			source.add_button_press_action (2, Current, Second);
			initialize_transport;
			source.add_button_press_action (2, show_command, Current);
			source.add_button_release_action (2, show_command, Nothing);
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
			if not instantiated 
			then select_icon
			else deselect end;
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
			if
				argument = First
			then
				transportable := True
			elseif
				argument = Second
			then
				if
					instantiated
				then
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
				error_box.popup (Current, "Incompatible types")
			end;
		end;

end
