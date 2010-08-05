note
	description: "Summary description for {REPOSITORY_SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPOSITORY_SHARED

feature -- Access

	common_data_folder: STRING = "data"

	log_sorter: QUICK_SORTER [REPOSITORY_LOG]
		once
			create Result.make (create {COMPARABLE_COMPARATOR [REPOSITORY_LOG]})
		end

end
