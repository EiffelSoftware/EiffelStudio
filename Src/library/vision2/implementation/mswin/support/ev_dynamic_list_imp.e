--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision widget list, mswin implementation."
	status: "See notice at end of class"
	id: "$Id:"
	date: "$Date:"
	revision: "$Revision:"

deferred class
	EV_DYNAMIC_LIST_IMP

inherit
	EV_DYNAMIC_LIST_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DYNAMIC_LIST

end -- class EV_DYNAMIC_LIST_IMP
