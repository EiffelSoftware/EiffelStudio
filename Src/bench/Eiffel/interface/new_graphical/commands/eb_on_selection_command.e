indexing
	description: "Command on selected text"
	author: "Etienne AMODEO"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ON_SELECTION_COMMAND

inherit

	EB_STANDARD_CMD
		rename
			make as make_standard
		redefine
			executable, initialize
		end

	EB_DEVELOPMENT_WINDOW_COMMAND
		redefine
			executable, make
		end


	TEXT_OBSERVER
		redefine
			on_selection_begun, on_selection_finished
		end

create
	make

feature {NONE} -- initialization

	make (a_target: EB_DEVELOPMENT_WINDOW) is
			-- creation function
		do
			make_standard
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND} (a_target)
		end

	initialize is
		do	
			Precursor
			disable_sensitive
		end


feature -- Execution

	executable: BOOLEAN is
		do
			Result := is_sensitive
		end


feature {NONE}-- Implementation

	editor: EB_EDITOR is
			-- Editor corresponding to Current
		do
			Result := target.editor_tool.text_area
		end

	on_selection_begun is
			-- make the command sensitive
		do
			enable_sensitive
		end

	on_selection_finished is
			-- make the command insensitive
		do
			disable_sensitive
		end


end -- class EB_COMMENT_COMMAND
