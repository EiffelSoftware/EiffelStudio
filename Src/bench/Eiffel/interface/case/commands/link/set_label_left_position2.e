indexing

	description: 
		"Command to set the label left of the link.";
	date: "$Date$";
	revision: "$Revision $"

class SET_LABEL_LEFT_POSITION2

inherit

	COMMAND_RELATION_WINDOW
 
creation
	make

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the label to the left position.
		local
			change_position: CHANGE_LABEL_POSITION_U
		do
		--	if relation_window.label_page.has_text then
		--			!!change_position.make (relation_window.clientele_link,
		--					true,relation_window.reverse_side)
		--	end
		end 

end -- class SET_LABEL_LEFT_POSITION
