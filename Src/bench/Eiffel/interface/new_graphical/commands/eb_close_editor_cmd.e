indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLOSE_EDITOR_CMD

inherit
	EB_CLOSE_TOOL_CMD
		redefine
			tool, execute
		end

	EB_SHARED_INTERFACE_TOOLS
	
	NEW_EB_CONSTANTS

creation

	make
	
feature -- Callbacks

	exit_anyway is
			-- The user has been warned that he will lose his stuff
		do
--			tool.destroy
			tool_supervisor.remove (tool)
		end

	save_changes (argument: ANY) is
		do
--			if tool.save_cmd /= Void then
--				tool.save_cmd.execute (Void)
--			end

			exit_anyway
		end

feature -- Properties

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Quit 
--		end

feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Quit cautiously a file.
		local
--			d: EV_DIALOG
			qd: EV_QUESTION_DIALOG
			cmd: EV_ROUTINE_COMMAND
		do
			if tool.text_window.changed then
				create qd.make_with_text (tool.parent, Interface_names.t_Warning, Warning_messages.w_File_changed)
				qd.show_yes_no_cancel_buttons
				qd.show
--				warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed,
--						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
			else
				exit_anyway
			end
		end

feature {NONE} -- Attributes

	tool: EB_EDITOR

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Exit
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Exit
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

end -- class EB_CLOSE_EDITOR_CMD
