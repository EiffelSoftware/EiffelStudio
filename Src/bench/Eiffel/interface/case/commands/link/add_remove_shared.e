indexing

	description: 
		"Command to changed shared state for a link.";
	date: "$Date$";
	revision: "$Revision $" 

class ADD_REMOVE_SHARED

inherit

	--EC_COMMAND
	EV_COMMAND

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Add or remove shared values.
		local
			add_shared: ADD_SHARED_U;
			remove_shared: REMOVE_SHARED_U
		do
			--if a_group.shared.state then
			--	!!add_shared.make (a_group.relation_window.clientele_link,
			--				a_group.relation_window.reverse_side)
			--else
			--	!!remove_shared.make (a_group.relation_window.clientele_link,
			--		a_group.multiple_scale.value, a_group.relation_window.reverse_side)
			--end
		end 

end -- class ADD_REMOVE_SHARED
