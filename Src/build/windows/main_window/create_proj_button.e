indexing
	description: "Button to create a new project."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CREATE_PROJ_BUTTON

inherit
	EB_BUTTON_COM

	LICENCE_COMMAND
		redefine
			question_ok_action,
			question_cancel_action
		end

creation
	make

feature {NONE} -- Button

-- 	create_focus_label is
-- 		do
-- 			set_focus_string (Focus_labels.create_project_label)
-- 		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.create_project_pixmap
		end
	
feature {NONE} -- Command

	work (argument: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			if not main_window.project_initialized then
				popup_window
			else
				if history_window.saved_application then
					popup_window
				else
					question_dialog.popup (Current, Messages.create_project_qu,
										Void, False)
				end
			end
		end

	popup_window, question_ok_action is
		local
			dialog: EV_DIRECTORY_SELECTION_DIALOG
			cmd: CREATE_PROJECT
			arg: EV_ARGUMENT1 [EV_DIRECTORY_SELECTION_DIALOG]
		do
			create dialog.make_with_text (main_window,
							Widget_names.create_project_window)
			create cmd
			create arg.make (dialog)
			dialog.add_ok_command (cmd, arg)
			dialog.show
		end

	question_cancel_action is
		do
		end

end -- class CREATE_PROJ_BUTTON

