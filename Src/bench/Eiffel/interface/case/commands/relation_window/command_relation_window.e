indexing

	description: 
		"Ancestor of the commands to set the label of the link.";
	date: "$Date$";
	revision: "$Revision $"

deferred class COMMAND_RELATION_WINDOW 

inherit

	--COMMAND

	EV_COMMAND
	

feature
	make ( r : like relation_window ) is
	do
	
		relation_window := r
	end

	
	relation_window : EC_RELATION_WINDOW
 
	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
 deferred end

end -- class COMMAND_RELATION_WINDOW 
