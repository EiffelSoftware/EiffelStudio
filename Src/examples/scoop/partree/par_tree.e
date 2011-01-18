note
	description: "Summary description for {TREE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PAR_TREE [G]

feature

	comp_result: G

        compute_agents (init: G; 
                        trns: FUNCTION [ANY, TUPLE [G], G];
                        comb: FUNCTION [ANY, TUPLE [G,G], G]
                       )
                deferred
                end

	compute (init: G)
		deferred
		end

	trans (x: G): G
		deferred
		end

	combine (x,y: G): G
		deferred
		end


end
