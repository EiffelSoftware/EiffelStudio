indexing

	description: "Displays save_as project box when the button %
				 %associated to Current command is pressed.";
	date: "$Date$";
	revision: "$Revision $"

class 
	SAVE_AS_PROJECT 

inherit

	MAIN_PANEL_COM
		redefine
			--license_checked
		end

create
	make

feature -- Creation

	make (m: like main_window) is 
		do
			main_window := m
		end

feature -- Properties

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated (at the beggining).
		do
			Result := Pixmaps.save_as_pixmap
		end;

	main_window: MAIN_WINDOW

feature -- Execution (work)

	work (not_used: ANY) is
			-- Display a window to ask the user the path and name 
			-- to save the current project
		local
			directory_selector: EV_DIRECTORY_DIALOG

			store_project: STORE_PROJECT
		do
			directory_selector := windows_manager.directory_selector (main_window)
			
			!! store_project.make (main_window, directory_selector)
			store_project.set_save_as (true)
			directory_selector.add_ok_command (store_project, Void)
			if directory_selector /= Void then
				directory_selector.show

				System.set_light_save ( FALSE )
			end
		end;

feature {NONE} -- Implementation

	license_checked: BOOLEAN is True
			-- Is license checked?
			--| True, so as to always allow the user to save his/her project, 
			--| even if his/her licence has expired

end -- class SAVE_AS_PROJECT







