indexing

	description: 
	"main window button for the application. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW_BUTTON
	
inherit
	
	EV_BUTTON
	
creation
	
	make_button
	
feature {NONE} --Initialization
	
	make_button (main_w: MAIN_WINDOW; button_name: STRING; cmd: EV_COMMAND) is
		local

			e: EV_EVENT
			a: EV_ARGUMENT1[MAIN_WINDOW]
		do
			make (main_w.container)
			set_text (button_name)
			
			!!e.make ("clicked")
			!!a.make (main_w)
			add_command (e, cmd, a)
		end
	
end

	
