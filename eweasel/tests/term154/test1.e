class TEST1 [G, H]

create
	make


feature {NONE} -- Initialization

	make (a_creator: like list_creator) is
		do
			set_list_creator (a_creator)
		end

	make_default is
		local
			l_agents: 	TEST2 [H]
		do
			create l_agents
			make (agent l_agents.list_creator)
		end

feature -- Access

	list_creator: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], ARRAY [H]]

feature -- Status setting

	set_list_creator (a_creator: like list_creator) is
		do
			list_creator := a_creator
		end

end

