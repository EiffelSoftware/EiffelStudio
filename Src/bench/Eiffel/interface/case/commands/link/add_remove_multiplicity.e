indexing

	description: "Command to add/remove multiplicity.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_REMOVE_MULTIPLICITY

inherit

	--EC_COMMAND

	EV_COMMAND

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Add or remove multiplicity.
		local
			add_multiplicity: ADD_MULTIPLICITY_U;
			remove_multiplicity: REMOVE_MULTIPLICITY_U
		do
		--	if a_group.multiple.state then
		--		!!add_multiplicity.make (a_group.relation_window.clientele_link,
		--						a_group.relation_window.reverse_side)
		--	else
		--		!!remove_multiplicity.make (a_group.relation_window.clientele_link,
		--			a_group.multiple_scale.value, a_group.relation_window.reverse_side)
		--	end
		end 

end -- class ADD_REMOVE_MULTIPLICITY
