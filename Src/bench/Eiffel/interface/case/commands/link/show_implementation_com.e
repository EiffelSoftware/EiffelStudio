indexing

	description: 
		"Command to show/hide the implementation of a link.";
	date: "$Date$";
	revision: "$Revision $"

class SHOW_IMPLEMENTATION_COM

inherit

	--EC_COMMAND

	EV_COMMAND

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the implementation for relation.
		local
			show_imp: SHOW_IMPLEMENTATION_U;
		do
		--	if relation_w.entity /= Void then
		--		!! show_imp.make 
		--				(relation_w.entity,
		--				relation_w.show_implementation_t.state)
		--	end
		end 

end -- class SHOW_IMPLEMENTATION_COM
