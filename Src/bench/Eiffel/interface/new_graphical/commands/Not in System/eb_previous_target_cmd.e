indexing

	description:	
		"Retarget the tool with the previous target in history."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREVIOUS_TARGET_CMD

inherit
	EB_TEXT_TOOL_CMD

	NEW_EB_CONSTANTS

	EB_CONFIRM_SAVE_CALLBACK

creation

	make

feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
		do
			tool.text_area.disable_clicking
			execute_licensed
		end

feature -- Execution

	execute is
			-- Execute the command.
		local
			ed: EB_EDIT_TOOL
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			ed ?= tool
			if ed /= Void then			
				if ed.text_area.changed then
					create csd.make_and_launch (ed, Current)
				else
					process
				end
			else
				process
			end
		end

feature -- Properties

--	symbol: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Previous_target
--		end

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Previous_target
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Previous_target
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := "Alt<Key>Left"
--		end

feature {NONE} -- Implementation

	execute_licensed is
			-- Retarget the tool with the previous target in history.
		local
			history: STONE_HISTORY
			wd: EV_WARNING_DIALOG
		do
			history := tool.history
			if history.empty or else (history.isfirst or history.before) then
				create wd.make_with_text (Warning_messages.w_Beginning_of_history)
				wd.show_modal
			else
				history.back
				tool.set_stone_from_history
			end
		end

end -- class EB_PREVIOUS_TARGET_CMD
