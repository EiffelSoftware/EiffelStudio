indexing
	description: "This class represents a MS_WINDOWS push button"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ACCELERATOR_MANAGER_WINDOWS

feature {NONE} -- Implementation

	accelerators: ACCELERATORS_WINDOWS is
			-- Accelerators for the application
		once
			!! Result.make
		end

end -- class ACCELERATOR_MANAGER_WINDOWS
