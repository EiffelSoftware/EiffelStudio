indexing
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

	f (x: DOUBLE): like expression_target is
		deferred
		end

end
