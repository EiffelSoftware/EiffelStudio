indexing

	description: "Display create project box when the button % 
		%to the Current command is pressed.";
	date: "$Date$";
	revision: "$Revision $"

class 
	CREATE_PROJECT 

inherit
	MAIN_PANEL_COM
		redefine
			execute   
		end

	WARNING_CALLER

creation
	make

feature -- Creation

	make (m: like main_window) is
		do
			main_window := m
		end

feature -- Properties

	symbol: EV_PIXMAP is
			-- Symbol representing Current button
		do
			Result := Pixmaps.create_pixmap
		end;

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Popup the create project box if project
			-- is saved. Otherwise, popup an error window.
		local
			warning: EV_WARNING_DIALOG
		do	
			if system.project_initialized then
				if system.saved then
					work (Void)
				else
					warning := windows_manager.warning (Message_keys.create_wa, Void, main_window)
				end
			else
				work (Void)
			end
		end;

	work (not_used: ANY) is 
			--  Popup the create project box 
		local
			directory_selector: EV_DIRECTORY_DIALOG

			store_project: STORE_PROJECT
			resize_com: AUTOMATIC_RESIZE_COM
		do 
			directory_selector := windows_manager.directory_selector (main_window)
			
			!! store_project.make (main_window, directory_selector)
			store_project.set_save_as (false)
			directory_selector.add_ok_command (store_project, Void)
			if directory_selector /= Void then
				directory_selector.show

				system.set_project_initialized

				history.wipe_out

				!! resize_com
				resize_com.execute(Void, Void)
			end
		end

feature -- Update

	ok_action is
			-- Popup project create box, after a click on 
			-- "ok" in the warning window
		do
			work (Void)
		end

	cancel_action is
			-- Do nothing, after a click on "cancel" in the warning 
			-- window 
		do
		end

feature -- Properties

	main_window: MAIN_WINDOW

end -- class CREATE_PROJECT
