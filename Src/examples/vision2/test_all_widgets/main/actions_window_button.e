indexing

	description: 
	"actions window button for the application. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	ACTIONS_WINDOW_BUTTON
	
inherit
	
	EV_BUTTON
	
creation
	
	make_button
	
feature {NONE} --Initialization
	
	make_button (par: EV_CONTAINER; button_name: STRING; 
		     args: EV_ARGUMENTS; cmd: EV_COMMAND) is
		do
			make_with_text (par, button_name)
			
			add_click_command (cmd, args)
		end
	
end

	
