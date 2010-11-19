note
	description: "Summary description for {REPOSITORY_STORAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPOSITORY_STORAGE

--feature -- Initialization

--	set_data (a_data: REPOSITORY_DATA)
--		deferred
--		end

feature -- Load

	archive_loaded_log (a_id: STRING; a_data: REPOSITORY_DATA): like loaded_log
		deferred
		end

	loaded_log (a_id: STRING; a_data: REPOSITORY_DATA): detachable REPOSITORY_LOG
		deferred
		end

	diff (a_log: REPOSITORY_LOG): detachable STRING
		deferred
		end

	review (a_log: REPOSITORY_LOG): detachable REPOSITORY_LOG_REVIEW
		require
			review_exists: review_exists (a_log)
		deferred
		end


	load_logs (a_data: REPOSITORY_DATA)
		deferred
		end

	load_unread_logs (a_data: REPOSITORY_DATA)
		deferred
		end

feature -- Store

	archive_log (a_log: REPOSITORY_LOG)
		deferred
		end

	delete_log (a_log: REPOSITORY_LOG)
		deferred
		end

	store_unread_logs (a_data: REPOSITORY_DATA)
		deferred
		end

	store_diff (r: REPOSITORY_LOG; a_diff: STRING)
		deferred
		end

	store_review (a_log: REPOSITORY_LOG; a_review: REPOSITORY_LOG_REVIEW)
		deferred
		end

feature -- status		

	has_unread_logs: BOOLEAN
		deferred
		end

	review_exists (a_log: REPOSITORY_LOG): BOOLEAN
		deferred
		end

	diff_exists (a_log: REPOSITORY_LOG): BOOLEAN
		deferred
		end

end
