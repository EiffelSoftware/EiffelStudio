note
	description: "Summary description for {MD_DISPENSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_DISPENSER

feature -- Definition

	emitter (md_ui: MD_UI): MD_EMIT
			-- Create new scope and returns an emitter.
		deferred
		end

end
