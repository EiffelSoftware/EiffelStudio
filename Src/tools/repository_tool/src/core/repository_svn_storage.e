note
	description: "Summary description for {REPOSITORY_SVN_STORAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPOSITORY_SVN_STORAGE

inherit
	REPOSITORY_STORAGE

feature -- Subversion specific

	revision_first_known: INTEGER
		deferred
		end

	revision_last_known: INTEGER
		deferred
		end

	last_stored_rev: INTEGER
		deferred
		end

	log_from_revision (r: SVN_REVISION_INFO; a_data: REPOSITORY_SVN_DATA): attached like loaded_log
		deferred
		end

	store_svn_revision_info (r: SVN_REVISION_INFO; a_data: REPOSITORY_SVN_DATA)
		deferred
		end


feature -- load

	loaded_log (a_id: STRING; a_data: REPOSITORY_DATA): detachable REPOSITORY_SVN_LOG
		deferred
		end

	import_archive_logs (a_data: REPOSITORY_DATA)
		deferred
		end

	archive_loaded_log (a_id: STRING; a_data: REPOSITORY_DATA): like loaded_log
		deferred
		end

end
