indexing
	description: "Button in a command editor to create a new command. %
				% New command is created in current page of command catalog."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	NEW_COMMAND_BUTTON

inherit
	PUSH_B
		undefine
			init_toolkit
		redefine
			make
		end

	COMMAND

	WINDOWS

creation
	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			Precursor (a_name, a_parent)
			add_activate_action (Current, Void)
		end

	set_command_editor (cmd_editor: COMMAND_EDITOR) is
		do
			parent_command_editor := cmd_editor
		end

feature {NONE} -- Implementation

	execute  (arg: ANY) is
		local
			cmd: USER_CMD
		do
			!! cmd.make
			cmd.set_internal_name ("")
			cmd.set_eiffel_text (cmd.template)
			cmd.overwrite_text
			command_catalog.add (cmd)
			if parent_command_editor /= Void then
				parent_command_editor.set_command_tool_command (cmd)
			end
		end

	parent_command_editor: COMMAND_EDITOR
			-- Parent command editor
	
end -- class NEW_COMMAND_BUTTON
