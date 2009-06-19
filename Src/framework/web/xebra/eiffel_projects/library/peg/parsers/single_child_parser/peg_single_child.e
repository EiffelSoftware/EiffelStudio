note
	description: "[
		{PEG_SINGLE_CHILD}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PEG_SINGLE_CHILD

inherit
	PEG_ABSTRACT_PEG

feature -- Initialization

	make (a_child: PEG_ABSTRACT_PEG)
		do
			child := a_child
		end

feature {PEG_SINGLE_CHARACTER_PARSER} -- Access

	child: PEG_ABSTRACT_PEG
			-- Child parser of current

end
