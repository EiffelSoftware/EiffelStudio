note
	description: "[
		{XEL_XRPC_CLASS_ELEMENT}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XEL_XRPC_CLASS_ELEMENT

inherit
	XEL_SERVLET_CLASS_ELEMENT
		redefine
			make_with_constants
		end

create
	make_with_constants

feature -- Initialization

	make_with_constants (a_name: STRING; a_const_class: XEL_CONSTANTS_CLASS_ELEMENT)
		do
			Precursor (a_name, a_const_class)
			features.wipe_out
		end

end
