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
			execute_licensed (Void, Void)
		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
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

	execute_licensed (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Retarget the tool with the previous target in history.
		local
			history: STONE_HISTORY
			s: STONE
			c: CLASS_STONE
			t: EB_CLASS_TOOL
			wd: EV_WARNING_DIALOG
		do
			history := tool.history
			if history.empty or else (history.isfirst or history.before) then
				create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_Beginning_of_history)
			else
				history.back
				history.set_do_not_update (True)
--|				tool.receive (history.item)
--| FIXME
--| Christophe, 2 nov 1999
--| beginning of `receive' remplacement (as receive does not exists)
				s := history.item
				t ?= tool
				if t /= Void then
					c ?= s
					if c /= Void then
						t.set_stone (c)	
					end
				end
--| end of `receive' remplacement
				history.set_do_not_update (False)
			end
		end

end -- class EB_PREVIOUS_TARGET_CMD
