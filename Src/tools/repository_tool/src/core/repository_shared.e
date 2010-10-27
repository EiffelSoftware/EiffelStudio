note
	description: "Summary description for {REPOSITORY_SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPOSITORY_SHARED

feature -- Access

	common_data_folder: STRING
		do
			Result := common_data_folder_cell.item
		end

	log_sorter: QUICK_SORTER [REPOSITORY_LOG]
		once
			create Result.make (create {COMPARABLE_COMPARATOR [REPOSITORY_LOG]})
		end

feature {NONE} -- Implementation

	set_common_data_folder (s: STRING)
		require
			s_not_empty: s /= Void and then not s.is_empty
		do
			common_data_folder_cell.replace (s)
		end

	common_data_folder_cell: CELL [STRING]
		once
			create Result.put ("data")
		end

end
