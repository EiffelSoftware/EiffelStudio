indexing
	description: "Displays open project box when the button %
				 %associated to Current command is pressed.";
	date: "$Date$";
	revision: "$Revision $"

class  
	OPEN_PROJECT 

inherit

	MAIN_PANEL_COM
		redefine
			execute	
		end

	WARNING_CALLER

	ONCES

creation 
	make

feature -- Creation

	make (w: like main_window) is
		do
			main_window := w
		end

feature -- Properties

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
		do
			Result := Pixmaps.open_pixmap
		end

	main_window: MAIN_WINDOW

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- If system has been saved popup project_load_box.
			-- Otherwise popup a warning box to confirm
			-- that the user wants popup the project_load_box.	
		do
			work (Void)
		end

	work (not_used: ANY) is 
		local
			project_load_box	: EV_FILE_OPEN_DIALOG

			retrieve_project: RETRIEVE_PROJECT
		do 
			project_load_box	:= windows_manager.open_file_browser (main_window)

			!! retrieve_project.make (main_window, project_load_box)
			project_load_box.add_ok_command (retrieve_project, Void)

			project_load_box.show 


			--retrieve_project.retrieve ("e:\kolli\support\uncompress\sample.ecr")
			--retrieve_project.retrieve ("e:\kolli\support\vision_precompile\system_architecture.ecr")
			--retrieve_project.retrieve ("e:\kolli\case_project\system_architecture.ecr")
		end;

feature {WARNING_WINDOWS} -- Implementation

	ok_action is
			-- Popup the project_load_box.
		do
--			work (Void)
--		ensure then
	--		project_load_box_is_up: Windows.project_load_box.is_popped_up
		end;

	cancel_action is
			-- Do nothing.
		do
		end;

end -- class OPEN_PROJECT
