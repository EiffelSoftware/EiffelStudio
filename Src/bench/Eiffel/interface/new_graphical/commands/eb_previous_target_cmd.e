indexing

	description:	
		"Retarget the tool with the previous target in history."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREVIOUS_TARGET_CMD

inherit
	EB_EDITOR_COMMAND

--	WARNER_CALLBACKS
--		rename
--			execute_warner_ok as save_changes,
--			execute_warner_help as loose_changes
--		end

creation

	make

feature -- Callbacks

--	loose_changes is
--			-- Useless here
--		do
--			text_window.disable_clicking
--			execute_licensed (Void)
--		end
--
--	save_changes (argument: ANY) is
--			-- The changes will be lost.
--		do
--			text_window.disable_clicking
--			if tool /= Void then
--				tool.save_cmd_holder.associated_command.execute (Void)
--			end
--			execute_licensed (Void)
--		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute the command.
		do
			if not tool.text_window.changed then
				execute_licensed (argument, data)
			 else
--				warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed,
--					Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
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
			c: CLASSC_STONE
			ci: CLASSI_STONE
			t: EB_CLASS_TOOL
		do
			history := tool.history
			if history.empty or else (history.isfirst or history.before) then
--				warner (popup_parent).gotcha_call (Warning_messages.w_Beginning_of_history)
			else
				history.back
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

end -- class EB_PREVIOUS_TARGET_CMD
