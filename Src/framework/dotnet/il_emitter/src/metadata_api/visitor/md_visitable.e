note
	description: "Summary description for {MD_VISITABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_VISITABLE

feature -- Visitor

	accepts (vis: MD_VISITOR)
		deferred
		end

end
