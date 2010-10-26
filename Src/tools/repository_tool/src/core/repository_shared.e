note
	description: "Summary description for {REPOSITORY_SHARED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPOSITORY_SHARED

feature -- Access

	common_data_folder: STRING
		local
			args: ARGUMENTS
		once
			create args
			if
				attached args.separate_word_option_value ("config") as s and then
				not s.is_empty
			then
				Result := s
			else
				Result := "data"
			end
		end

	log_sorter: QUICK_SORTER [REPOSITORY_LOG]
		once
			create Result.make (create {COMPARABLE_COMPARATOR [REPOSITORY_LOG]})
		end

end
