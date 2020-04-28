note

	description:

		"Shared access to EWG_EIFFEL_COMPILER_NAMES"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_SHARED_EIFFEL_COMPILER_NAMES

feature -- Singleton access

	eiffel_compiler_names: EWG_EIFFEL_COMPILER_NAMES 
		once
			create Result.make
		end

end
