indexing

	description:	
		"Retarget the tool with the next target in history."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NEXT_TARGET_CMD

inherit
	EB_TEXT_TOOL_CMD

	EB_CONFIRM_SAVE_CALLBACK

creation
	make

feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
		do
			tool.text_area.disable_clicking
			execute_licensed
		end

feature -- Properties

--	active_symbol: EV_PIXMAP is
--			-- Symbol for the button
--		once
--			Result := Pixmaps.bm_Next_target
--		end

--	inactive_symbol: EV_PIXMAP is
--			-- Symbol for the button
--		once
--			Result := Pixmaps.bm_Disabled_next_target
--		end
	
--	name: STRING is
--			-- Name of the command
--		do
--			Result := Interface_names.f_Next_target
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Next_target
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := "Alt<Key>Right"
--		end

feature -- Execution

	execute is
			-- Execute the command, with parameter `argument'.
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

feature {NONE} -- Implementation

	execute_licensed is
			-- Retarget the tool with the next target in history.
		local
			history: STONE_HISTORY
		do
			history := tool.history
			if not (history.empty or else (history.islast or history.after)) then
				history.forth
				tool.set_stone_from_history
			end
		end

end -- class EB_NEXT_TARGET_CMD
