
class OBSERVER_ICON 

inherit

	ICON_STONE
		rename
			set_data as old_set_data
		undefine
			stone_cursor, stone, initialize_transport, init_toolkit
		redefine
			data, set_widget_default
		end
	ICON_STONE
		undefine
			initialize_transport, init_toolkit
		redefine
			set_data, data, set_widget_default, stone
		select
			set_data
		end
	HOLE
		rename
			target as source
		end
	ERROR_POPUPER
	CONTEXT_DRAG_SOURCE

creation

	make

feature -- Creation

	make (ed: COMMAND_TOOL) is
		do
			command_tool := ed
		end

feature 

	set_widget_default is
		do
			register
			initialize_transport
		end

-- **************
-- Stone features
-- **************

	data: CMD_INSTANCE
	
feature {NONE}

	command_tool: COMMAND_TOOL

	stone: STONE is
		local
			obs_stone: OBSERVER_STONE
		do
			!! obs_stone.make (data, command_tool)
			Result := obs_stone
		end

	stone_type: INTEGER is
		do
			Result:= Stone_types.instance_type
		end

feature 

	set_data (arg: CMD_INSTANCE) is
		do
			old_set_data (arg)
		end

	popuper_parent: COMPOSITE is
		do
			Result := Current
		end

end
