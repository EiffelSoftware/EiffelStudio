indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	OBSERVER_ICON

inherit

	ICON_STONE
		rename
			set_data as old_set_data
		undefine
			stone_cursor, stone, initialize_transport, init_toolkit -- last by samik
		redefine
			data, set_widget_default
		end;
	ICON_STONE
		undefine
			initialize_transport, init_toolkit
		redefine
			set_data, data, set_widget_default, stone
		select
			set_data
		end;
	HOLE
		rename
			target as source
		end;
	ERROR_POPUPER;
	CONTEXT_DRAG_SOURCE

creation

	make

feature -- Creation

	make (ed: like inst_editor) is
		do
			inst_editor := ed
		end

feature 

	set_widget_default is
		do
			register;
			initialize_transport;
		end;

-- **************
-- Stone features
-- **************

	data: CMD_INSTANCE;
	
feature {NONE}

	inst_editor: COMMAND_EDITOR

	stone: STONE is
		local
			obs_stone: OBSERVER_STONE
		do
--			!! obs_stone.make (data, inst_editor)
--			Result := obs_stone
		end;

	stone_type: INTEGER is
		do
			Result:= Stone_types.instance_type
		end;

feature 

	set_data (arg: CMD_INSTANCE) is
		do
			old_set_data (arg);
		end;

	popuper_parent: COMPOSITE is
		do
			Result := Current
		end;

end -- class OBSERVER_ICON
