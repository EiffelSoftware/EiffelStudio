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
		local

			e: EV_EVENT
		do
			make_with_label (par, button_name)
			
			!!e.make ("clicked")
			add_command (e, cmd, args)
		end
	
end

	
