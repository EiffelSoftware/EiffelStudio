note
	description: "Summary description for {TREE_LEAF}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TREE_LEAF [G]

inherit
	PAR_TREE [G]

feature
	list: SPECIAL [G]

        compute_agents (init: G; 
                        trns: FUNCTION [ANY, TUPLE [G], G];
                        comb: FUNCTION [ANY, TUPLE [G,G], G]
                       )
                local
                        i: INTEGER
                do
                        from
                                i := 0
                                comp_result := init
                        until
                                i >= list.count
                        loop
                                comp_result := comb.item ([comp_result,
                                                           trns.item ([list[i]])
                                                          ])
                                i := i + 1
                        end
                end

	compute (init: G)
		local
			i: INTEGER
		do
			from
				i := 0
				comp_result := init
			until
				i >= list.count
			loop
				comp_result := combine (comp_result, trans (list[i]))
				i := i + 1
			end
		end

end
