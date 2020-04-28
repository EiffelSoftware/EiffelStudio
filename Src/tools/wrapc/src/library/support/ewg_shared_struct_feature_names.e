note

	description:

		"Shared access to EWG_STRUCT_FEATURE_NAMES"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_SHARED_STRUCT_FEATURE_NAMES

feature -- Singleton access

	struct_feature_names: EWG_STRUCT_FEATURE_NAMES 
			-- Singleton access to EWG_STRUCT_FEATURE_NAMES
		once
			create Result.make
		ensure
			names_not_void: Result /= Void
		end

end
