indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_LONG_FORMAT_COMMAND

inherit
	EB_FORMAT_COMMAND
		rename
			process as process_format 
		redefine
			execute
		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [STONE]; data: EV_EVENT_DATA) is
			-- Ask for a confirmation before executing the format.
		local
--			mp: MOUSE_PTR
			cfd: EB_CONFIRM_FORMATTING_DIALOG
		do
			if argument = Void then
				s := f.tool.stone
			else
				s ?= argument.first
			end
			if (s /= Void and then s.clickable) and then not user_asked then
--				not data.control_key_pressed then
--					-- click requires a confirmation, control-click doesn't.

				create cfd.make_default (Current)
				user_asked := True
			else
				process
			end
		end

feature {EB_CONFIRM_FORMATTING_DIALOG} -- callbacks

	process is
		local
			csd: EB_CONFIRM_SAVE_DIALOG
		do
				-- The user wants to execute this format,
				-- even though it's a long format.
			if f.tool.text_window.changed then
				create csd.make_and_launch (f.tool, Current)
			else
				process_format
			end
		end

	associated_window: EV_WINDOW is
		do
			Result := f.tool.parent_window
		end

feature -- Implementation

	user_asked: BOOLEAN

end -- class EB_LONG_FORMAT_COMMAND
