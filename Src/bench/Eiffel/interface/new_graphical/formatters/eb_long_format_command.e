indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_LONG_FORMAT_COMMAND

inherit
	EB_FORMAT_COMMAND
		redefine
			execute
		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
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
			if s /= Void and then s.clickable then
--				not data.control_key_pressed then
--					-- click requires a confirmation, control-click doesn't.

				create cfd.make_default (Current)
			else
				process
			end
		end

feature {EB_CONFIRM_FORMATTING_DIALOG} -- callbacks

	process is
		do
				-- The user wants to execute this format,
				-- even though it's a long format.
			if not f.tool.text_window.changed then
--					create mp.set_watch_cursor
--					execute_licensed (s)
					f.format (s)
--					mp.restore
			else
--				create wd.make_with_text (f.tool_parent, Warning_messages.w_File_changed,
--					Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
			end
		end

	associated_window: EV_WINDOW is
		do
			Result := f.tool.parent_window
		end

feature -- Implementation

	s: STONE

end -- class EB_LONG_FORMAT_COMMAND
