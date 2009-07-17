note
	description: "[
		Data container for sending XC_SERVER_MODULES over sockets.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_SERVER_MODULE_BEAN

inherit
	XC_SERVER_MODULE

create
	make_from_module

feature {NONE} -- Initialization

	make_from_module (a_module: XC_SERVER_MODULE)
			-- Initializes current
		require
			a_module_attached: a_module /= Void
		do
			launched := a_module.launched
			running := a_module.running
			name := a_module.name
		end

feature -- Status setting

	shutdown
			-- <Precursor>.
		do
		end

	launch
			-- <Precursor>.
		do
		end

	join
			-- <Precursor>.
		do
		end

end

