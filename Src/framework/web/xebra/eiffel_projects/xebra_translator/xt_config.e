note
	description: "[
		Contains all configuartion info for the translator
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_CONFIG

feature -- Access

	xebra_library_path: SETTABLE_STRING
			-- The path to the xebra libraries

feature -- Status setting

	set_xebra_library_path (a_xebra_library_path: STRING)
			-- Setts xebra_library_path.
		require
			a_xebra_library_path_attached: a_xebra_library_path /= Void
		do
			xebra_library_path := a_xebra_library_path
		ensure
			xebra_library_path_set: equal (xebra_library_path, a_xebra_library_path)
		end


end
