indexing

	description:	
		"Retarget the tool with the next target in history."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_NEXT_TARGET_CMD

inherit
	EB_EDITOR_COMMAND

	EB_CONFIRM_SAVE_CALLBACK

creation
	make

feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
		do
			tool.text_window.disable_clicking
			execute_licensed (Void, Void)
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

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute the command, with parameter `argument'.
		local
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if tool.text_window.changed then
				create csd.make_and_launch (tool, Current)
			else
				process
			end
		end

feature {NONE} -- Implementation

	execute_licensed (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Retarget the tool with the next target in history.
		local
			history: STONE_HISTORY
			s: STONE
			c: CLASSC_STONE
			ci: CLASSI_STONE
			t: EB_CLASS_TOOL
		do
			history := tool.history
			if not (history.empty or else (history.islast or history.after)) then
				history.forth
				history.set_do_not_update (True)
--				tool.receive (history.item)
-- beginning of receive remplacement (as receive does not exists)
				s := history.item
				t ?= tool
				if t /= Void then
					c ?= s
					ci ?= s
					if c /= Void then
						t.process_class (c)	
					else
						t.process_classi (ci)	
					end
				end
-- end of receive remplacement
				history.set_do_not_update (False)
			end
		end

end -- class EB_NEXT_TARGET_CMD
