indexing

	description: 
		"Command to change the value of multiplicity.";
	date: "$Date$";
	revision: "$Revision $"

class CHANGE_MULTIPLICITY

inherit

	EC_COMMAND

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Change multiplicity.
		local
			change_multiplicity: CHANGE_MULTIPLICITY_U
		do
		--	!!change_multiplicity.make (a_group.relation_window.clientele_link,
		--					a_group.multiple_scale.value,
		--					a_group.relation_window.reverse_side)
		end 

end -- class CHANGE_MULTIPLICITY
