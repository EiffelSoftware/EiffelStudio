indexing
	description: "Icon appearing in the argument box."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 

	ARG_INST_ICON 

inherit

	ICON_STONE
		rename
			stone_cursor as icon_stone_cursor
		undefine
			initialize_transport, init_toolkit -- last by sami
		redefine
			set_data, data, set_widget_default, stone
		end

	STONE
		redefine
			stone
		end

	HOLE
		rename
			target as source
		redefine
			process_context, compatible
		end

	ERROR_POPUPER

	CONTEXT_DRAG_SOURCE

	REMOVABLE

creation

	make

feature -- Creation
	
	make (a_tool: COMMAND_TOOL) is
		do
			command_tool := a_tool
		end

feature 

	set_widget_default is
		do
			register
			initialize_transport
		end

feature -- Stone features

	data: ARG_INSTANCE
			-- Argument instance that this stone represents
	
	process (hole: HOLE) is
			-- Process the hole.
		do
			hole.process_argument (Current)
		end

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.type_cursor
		end

	stone_type: INTEGER is
		do
			Result := Stone_types.argument_type 
		end

	compatible (s: STONE): BOOLEAN is
		do
			Result := s.stone_type = Stone_types.context_type
		end

feature {NONE} 

	stone: STONE is
		do
			Result := Current
		end

	context: CONTEXT is
		do
			Result := data.context
		end
	
	identifier: INTEGER is
		do
			Result := data.identifier
		end

	type: CONTEXT_TYPE is
		do
			Result := data.type
		end

feature 

	set_data (arg: ARG_INSTANCE) is
		do
			Precursor (arg)
			data.set_icon_stone (Current)
		end

	process_context (dropped: CONTEXT_STONE) is
		local 	
			instantiate_cmd: INSTANTIATE_CMD
		do
			if (data.type.eiffel_type.is_equal (dropped.data.eiffel_type)) then
				!!instantiate_cmd.make (data)
				instantiate_cmd.execute (dropped.data)
			else
				error_box.popup (Current, Messages.incomp_er, Void)
			end
		end

	popuper_parent: COMPOSITE is
		do
			Result := Current
		end

feature -- Removable

	remove_yourself is
			-- Remove a formal argument.
		do
			command_tool.remove_argument (data, Current)
		end

feature -- Attributes

	command_tool: COMMAND_TOOL
			-- Associated command tool
invariant

	command_tool_not_void: command_tool /= Void

end
