class SAVE_AS_BUTTON 

inherit

	PUSH_B
		undefine
			init_toolkit
		redefine
			make
		end
		
	LICENCE_COMMAND

	QUEST_POPUPER

	
creation

	make

feature {NONE} 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			{PUSH_B} Precursor (a_name, a_parent)
			set_callbacks
		end

	set_callbacks is
		do
			add_activate_action (Current, Void)
		end

	work (argument: ANY) is
		do
			if not main_panel.project_initialized then
				popup_window
			else
				if history_window.saved_application then
					popup_window
				else
					question_box.popup (Current, app_not_save_qu, Void)
				end
			end
		end
  
	app_not_save_qu: STRING is
		do
			Result := Messages.save_as_project_qu
		end

	question_cancel_action is
		do
		end

	question_ok_action is
		do
			popup_window
		end

	popup_window is
		local
			pw: SAVE_AS_PROJ_WIN
		do
			if main_panel.project_initialized then
				!!pw.make (main_panel.base)
				pw.popup
			end
		end

	popuper_parent: COMPOSITE is
		do
			Result := main_panel.base
		end

end -- class SAVE_AS_BUTTON
