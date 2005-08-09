indexing

	description:	
		"Command to manage exception handling."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXCEPTION_HANDLER_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_CONSTANTS

	SHARED_APPLICATION_EXECUTION

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
--			create accelerator.make_with_key_combination (
--				create {EV_KEY}.make_with_code (Key_constants.Key_f5),
--				True, False, True)
--			accelerator.actions.extend (agent execute)
		end

feature -- Formatting

--	dialog: ES_EXCEPTION_HANDLER_DIALOG

	execute is
			-- Pause the execution.
		local
			dlg: EV_DIALOG
			vb: EV_VERTICAL_BOX
			bt: EV_BUTTON
			lb: EV_LABEL
		do
			if application.is_dotnet then
--				create dialog
--				dialog.set_handler (application.exceptions_handler)
--				dialog.show
--				dlg := dialog

				create dlg
				create vb
				vb.set_border_width (5)
				vb.set_padding_width (5)
				create bt
				if Application.exceptions_handler.ignoring_external_exception then
					dlg.set_title ("Is ignoring external exceptions")
					bt.set_text ("Catch external exception")
				else
					dlg.set_title ("Is catching external exceptions")
					bt.set_text ("Ignore external exception")
				end
				bt.select_actions.extend (agent on_click (dlg, bt))
				vb.extend (bt)
				
					--| Close
				create bt.make_with_text_and_action ("Close", agent dlg.destroy)
				dlg.set_default_cancel_button (bt)
				vb.extend (bt)
				
				dlg.extend (vb)
			else		
				create dlg
				create vb
				
				create lb.make_with_text ("Not yet available for classic system")
				vb.extend (lb)
					--| Close
				create bt.make_with_text_and_action ("Close", agent dlg.destroy)
				dlg.set_default_cancel_button (bt)
				vb.extend (bt)
				dlg.extend (vb)
			end
			dlg.show_relative_to_window (window_manager.last_focused_window.window)
		end
		
	on_click (dlg: EV_DIALOG; bt: EV_BUTTON) is
		do
			application.exceptions_handler.ignore_external_exceptions (not Application.exceptions_handler.ignoring_external_exception)
			if Application.exceptions_handler.ignoring_external_exception then
				dlg.set_title ("Is ignoring external exceptions")				
				bt.set_text ("Catch external exception")
			else
				dlg.set_title ("Is catching external exceptions")				
				bt.set_text ("Ignore external exception")
			end		
		end

feature {NONE} -- Attributes

	description: STRING is
			-- What appears in the customize dialog box.
		do
			Result := tooltip
		end

	tooltip: STRING is
			-- Tooltip displayed on `Current's buttons.
		do
--			Result := Interface_names.e_Exec_stop
			Result := "Exception handling"
		end

	tooltext: STRING is
			-- Text displayed on `Current's buttons.
		do
			Result := "Exceptions"
		end

	name: STRING is "Exception_handler"
			-- Name of the command.

	menu_name: STRING is
			-- Menu entry corresponding to `Current'.
		once
--			Result := Interface_names.m_Debug_interrupt_new
			Result := "Exception handling"
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing `Current' on buttons.
		once
			Result := <<Pixmaps.icon_debugger_exception>>
		end

end
