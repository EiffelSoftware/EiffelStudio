indexing
	description:
		"This kind of format is long to process. Ask %
			%for a confirmation before executing it."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_LONG_FORMATTER

inherit
	EB_FILTERABLE
		rename
			process as process_format 
		redefine
			launch
		end

feature -- Commands

	launch (argument: STONE) is
			-- Ask for a confirmation before executing the format.
		local
--			mp: MOUSE_PTR
			md: EV_MESSAGE_DIALOG
		do
			if argument = Void then
				s2 := tool.stone
			else
				s2 ?= argument
			end
			if (s2 /= Void and then s2.clickable) then
--				not data.control_key_pressed then
--					-- click requires a confirmation, control-click doesn't.

				create md.make_with_text (
					"This format requires exploring the entire%N%
					%system and may take a long time...")
				md.set_title (Interface_names.t_Confirm)
				md.set_buttons (<<" Continue ", Interface_names.b_Cancel>>)
				md.button (" Continue ").select_actions.extend (~process)
				md.show_modal
			else
				process
			end
		end

feature {EB_CONFIRM_FORMATTING_DIALOG} -- callbacks

	process is
		local
			ed: EB_EDIT_TOOL
			csd: EB_CONFIRM_SAVE_DIALOG
		do
				-- The user wants to execute this format,
				-- even though it's a long format.
			ed ?= tool
			if ed /= Void then
				if ed.text_area.changed then
					create csd.make_and_launch (ed, Current)
				else
					process_format
				end
			else
				process_format
			end
		end

end -- class EB_LONG_FORMATTER
