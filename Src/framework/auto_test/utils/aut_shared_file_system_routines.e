indexing
	description: "Shared access to AUT_FILE_SYSTEM_ROUTINES"
	author: "Ilinca Ciupa and Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class AUT_SHARED_FILE_SYSTEM_ROUTINES

feature -- Singleton Access

	file_system_routines: AUT_FILE_SYSTEM_ROUTINES is
			-- Registry singleton
		once
			create Result.make
		ensure
			routines_not_void: Result /= Void		
		end

end
