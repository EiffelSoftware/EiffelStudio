indexing
	description: "Status of current compilation."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_COMPILATION_MODES

feature -- Access

	compilation_modes: COMPILATION_MODES is
			-- Status of current compilation
		once
			!! Result
		end

end -- class SHARED_COMPILATION_MODES
