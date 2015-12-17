note
	description: "Summary description for {TREE_LEAF}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TREE_LEAF [G]

inherit
	PAR_TREE [G]

feature
	list: separate SPECIAL [G]

	compute_agents (init: G; trns: FUNCTION [G, G]; comb: FUNCTION [G,G, G])
		do
			compute_agents_imp (init, trns, comb, list)
		end

	compute_agents_imp (init: G; trns: FUNCTION [G, G]; comb: FUNCTION [G,G, G]; a_list: separate SPECIAL [G])
		local
			i: INTEGER
		do
			from
				i := 0
				comp_result := init
			until
				i >= a_list.count
			loop
				comp_result := comb.item ([comp_result,
										trns.item ([a_list[i]])
																])
				i := i + 1
			end
		end

	compute (init: G)
		do
			compute_imp (init, list)
		end

	compute_imp (init: G; a_list: separate SPECIAL [G])
		local
			i: INTEGER
		do
			from
				i := 0
				comp_result := init
			until
				i >= a_list.count
			loop
				comp_result := combine (comp_result, trans (a_list[i]))
				i := i + 1
			end
		end

end
