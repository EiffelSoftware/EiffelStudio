indexing

	description: 
		"Command associated to the workarea. Create a new entity % 
		%according to the currently selected creation command.";
	date: "$Date$";
	revision: "$Revision $"

class 
	WORKAREA_CREATE_ENTITY

inherit
	WORKAREA_COMMAND
		redefine
		--	context_data_useful
		end

creation

	make

feature -- Status report

	context_data_useful: BOOLEAN is True
		-- Should the context data be available when Current 
		-- command is invoked as a callback ? Yes.

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Create a new entity according to the currently selected 
			-- creation command
		local
			--bt_data: BUTTON_DATA
		do
		--	check
		--		not_used: not_used = void
		--	end
		--	bt_data ?= context_data
		--	check
		--		button_data_exists: bt_data /= Void
		--	end;
		--	workarea.create_entity_command.execute (bt_data)
		end

end -- class WORKAREA_CREATE_ENTITY
