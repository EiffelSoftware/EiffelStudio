indexing
	description: "EiffelBuild figure."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class
	EB_FIGURE

inherit
	EV_FIGURE

	CONSTANTS

feature -- Access

	data: ANY is
			-- Associated data.
		deferred
		end

	data_type: EV_PND_TYPE is
		deferred
		end

end -- class EB_FIGURE

