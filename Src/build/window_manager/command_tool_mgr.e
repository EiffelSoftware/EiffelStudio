indexing
	description: "Command tool manager."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class

	COMMAND_TOOL_MGR

inherit

	EDITOR_MGR
		redefine
			editor_type, clear_editor
		end

creation

	make

feature {NONE} -- Implementation

	editor_type: COMMAND_TOOL

	clear_editor (ed: like editor_type) is
		do
			ed.clear
		end

end -- class COMMAND_TOOL_MGR
