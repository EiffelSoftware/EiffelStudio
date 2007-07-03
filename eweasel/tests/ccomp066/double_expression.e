indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOUBLE_EXPRESSION [reference G]

inherit
	ROSE_EXPRESSION [G]

feature
	at (a_target : like expression_target) : DOUBLE is
		deferred
		end
end
