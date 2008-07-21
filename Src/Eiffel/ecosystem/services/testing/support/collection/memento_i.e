indexing
	description: "[
		Generic interface used to describe changed of an object
		
		{MEMENTO_I} is very general and is ment to provide more specific information through its
		implementors. In particular memento can be an earlier snapshot of `Current' or can describe the
		incremental changes that lead to its current state.	
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MEMENTO_I

inherit
	USABLE_I

end
