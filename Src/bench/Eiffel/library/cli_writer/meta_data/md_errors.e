indexing
	description: "[
		List of possible errors when using Unmanaged Metadata API. List
		of errors can be found in <CorError.h>.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ERRORS

feature -- Access

	meta_s_duplicate: INTEGER is 0x131197
			-- Trying to define twice same member.

end -- class MD_ERRORS
