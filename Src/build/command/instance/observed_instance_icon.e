indexing
	description: "Icon representing an observed command instance."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	OBSERVED_INSTANCE_ICON

inherit
	OBSERVER_ICON
		redefine
			stone
		end

creation
	make

feature {NONE}

	stone: STONE is
		local
			observed_cmd_stone: OBSERVED_INSTANCE_STONE
		do
			!! observed_cmd_stone.make (data, command_tool)
			observed_cmd_stone.add_associated_observer (command_tool.command_instance)
			Result := observed_cmd_stone
		end

end -- class OBSERVED_INSTANCE_ICON
