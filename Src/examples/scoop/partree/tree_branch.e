note
	description: "Summary description for {TREE_BRANCH}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TREE_BRANCH [G]

inherit
	PAR_TREE [G]

feature

	left, right: separate PAR_TREE [G]

        compute_agents (init: G;
                 trns: FUNCTION [G, G];
                 comb: FUNCTION [G,G, G]
                )
                do
                        comp_result := compute_agents_sub (init, trns, comb, left, right)
                end

        compute_agents_sub (init: separate G;
                        trns: separate FUNCTION [G, G];
                        comb: separate FUNCTION [G,G, G];
                        l, r: separate PAR_TREE [G]
                       ): G
                do
                        l.compute_agents (init, trns, comb)
                        r.compute_agents (init, trns, comb)

                        Result := comb.item ([l.comp_result, r.comp_result])
                end

	compute (init: G)
		do
			comp_result := sub_compute (init, left, right)
		end

	sub_compute (init: G; l, r: separate PAR_TREE [G]): G
		do
			l.compute (init)
			r.compute (init)

			Result := combine (l.comp_result, r.comp_result)
		end

end
