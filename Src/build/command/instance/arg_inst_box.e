indexing
	description: "List of Arguments."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class ARG_INST_BOX

inherit
	EB_ICON_LIST
		redefine
			new_icon,
			create_new_icon
		end

creation
	make

feature {NONE}

--	new_icon: ARG_INST_ICON
		-- Type of icon contained in the current box

	command_tool: COMMAND_TOOL
		-- Parent comand tool

	create_new_icon is
		do
--			!! new_icon.make (command_tool)
		end
		
end -- class ARG_INST_BOX

