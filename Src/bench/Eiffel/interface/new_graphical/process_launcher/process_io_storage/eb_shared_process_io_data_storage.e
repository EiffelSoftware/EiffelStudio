indexing
	description: "Object that stores inter-thread information from c compiler and external command output"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_PROCESS_IO_DATA_STORAGE

feature

	freezing_storage: EB_PROCESS_IO_STORAGE is
			--
		indexing
			once_status: global
		once
			create Result.make
		end

	finalizing_storage: EB_PROCESS_IO_STORAGE is
			--
		indexing
			once_status: global
		once
			create Result.make
		end

	external_storage: EB_PROCESS_IO_STORAGE is
			--
		indexing
			once_status: global
		once
			create Result.make
		end

end
