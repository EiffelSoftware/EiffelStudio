indexing
	description	: "Recyclable object"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_RECYCLABLE

feature {EB_RECYCLER} -- Basic operations

	recycle is
			-- To be called when the button has became useless.
		deferred
		end

end -- class EB_RECYCLABLE