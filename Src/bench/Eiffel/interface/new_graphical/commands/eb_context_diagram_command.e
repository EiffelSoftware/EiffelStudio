indexing
	description	: "Commands applicable to the context diagram."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_CONTEXT_DIAGRAM_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_TARGET_COMMAND
		rename
			target as tool
		redefine
			tool,
			make
		end

feature {NONE} -- Initialization

	make (a_target: like tool) is
			-- Initialize the command with target `a_target'.
		do
			Precursor (a_target)
			history := tool.history
			disable_sensitive
		end

feature -- Access

	tool: EB_CONTEXT_EDITOR
			-- Associated with `Current'.

	history: EB_HISTORY_DIALOG
			-- History of undoable commands.
	
	menu_name: STRING is
			-- Name on corresponding menu items
		do
			Result := "Diagram command"
		end
		

end -- class EB_CONTEXT_DIAGRAM_COMMAND


