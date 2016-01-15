note
	description: "A rule that iterates backwards on the CFG."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_CFG_BACKWARD_RULE

inherit
	CA_CFG_RULE
		rename
			is_ready as is_empty
		end

	CA_CFG_BACKWARD_ITERATOR

end
