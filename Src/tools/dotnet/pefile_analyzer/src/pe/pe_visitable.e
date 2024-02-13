note
	description: "Summary description for {PE_VISITABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_VISITABLE

feature -- Visit

	accepts (v: PE_VISITOR)
		deferred
		end

end
