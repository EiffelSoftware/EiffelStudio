indexing
	description: "Stone for a command (used to edit a command)."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CAT_COM_IS 

inherit

	COM_ICON_STONE
		undefine
			init_toolkit
		end
	HOLE
		rename
			target as source
		redefine
			process_command
		end
	REMOVABLE
	ERROR_POPUPER
	SHARED_INSTANTIATOR

creation

	make
		
feature 

	page: COMMAND_PAGE

feature 

	make (p: like page) is
			-- Create an command icon stone with `p' as `page'.
		do
			page := p	
			register
		end -- Create

	
feature {NONE}

	process_command (dropped: CMD_STONE) is
		do
			page.insert_after (data, dropped.data)
		end

	remove_yourself is
		local
			user_cmd: USER_CMD
			remove_command: CAT_CUT_COMMAND
		do
			user_cmd ?= data
			if user_cmd /= Void then
				if user_cmd.has_descendents then
					error_box.popup (Current, 
						Messages.cannot_remove_cmd_er, 
						user_cmd.label)
				else
					page.remove_command (user_cmd)
					command_instantiator_generator.remove_command (user_cmd)
				end
			end
		end

	popuper_parent: COMPOSITE is
		do
			Result := Command_catalog
		end

end
