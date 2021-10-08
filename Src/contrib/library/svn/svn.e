note
	description: "[
			Interface for the svn commands:
				- status
				- info
				- diff 
				- logs
				- cat
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SVN

feature -- Access: working copy

	statuses (a_path: READABLE_STRING_GENERAL; is_verbose, is_recursive, is_remote: BOOLEAN; a_options: detachable SVN_OPTIONS): detachable LIST [SVN_STATUS_INFO]
			-- Statuses of nodes under `a_path'.	
			-- Also process subfolders is `is_recursive' is True.
			-- If `is_remote' then display remote information.
		deferred
		end

feature -- Operations: working copy

	checkout (a_location: READABLE_STRING_GENERAL; a_path: READABLE_STRING_GENERAL; a_rev: detachable SVN_RANGE_INDEX; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- Checkout repository `a_location' in working copy at `a_path', and return information about command execution.
		deferred
		end

	update (a_changelist: SVN_CHANGELIST; a_rev: detachable SVN_RANGE_INDEX; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- Update working copy at `a_changelist', and return information about command execution.
		deferred
		end

	add (a_changelist: SVN_CHANGELIST; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- Add items from `a_changelist', and return information about command execution.
		deferred
		end

	delete (a_changelist: SVN_CHANGELIST; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- Delete items from `a_changelist', and return information about command execution.
		deferred
		end

	move (a_location, a_new_location: READABLE_STRING_GENERAL; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- Move from `a_location' to `a_new_location', and return information about command execution.
		deferred
		end

	commit (a_changelist: SVN_CHANGELIST; a_log_message: detachable READABLE_STRING_GENERAL; a_options: detachable SVN_OPTIONS): SVN_RESULT
			-- Commit changes for locations `a_changelist', and return information about command execution.
		deferred
		end

	commit_from_location (a_changelist: SVN_CHANGELIST; a_log_message: detachable READABLE_STRING_GENERAL; a_options: detachable SVN_OPTIONS; a_location: PATH): SVN_RESULT
			-- Commit changes for locations `a_changelist', and return information about command execution.
		deferred
		end

feature -- Access

	repository_info (a_location: READABLE_STRING_GENERAL; a_options: detachable SVN_OPTIONS): detachable SVN_REPOSITORY_INFO
			-- Remote repository information located at `a_location',
			-- or remote repository information related to working copy at path `a_location'.
		deferred
		end

	logs (a_location: READABLE_STRING_GENERAL; is_verbose: BOOLEAN; a_start, a_end: detachable SVN_RANGE_INDEX; a_limit: INTEGER; a_options: detachable SVN_OPTIONS): detachable LIST [SVN_REVISION_INFO]
			-- Logs for `a_location' between `a_start' and `a_end' if provided, with a limit of `a_limit' entries.
		deferred
		end

	diff (a_location: READABLE_STRING_GENERAL; a_start, a_end: detachable SVN_RANGE_INDEX; a_options: detachable SVN_OPTIONS): detachable SVN_RESULT
			-- Difference for `a_location', between `a_start' and `a_end' if provided.
		deferred
		end

	content (a_location: READABLE_STRING_GENERAL; a_rev: detachable SVN_RANGE_INDEX; a_options: detachable SVN_OPTIONS): detachable STRING
			-- Content of `a_location', at revision `a_rev' if provided.
		deferred
		end

note
	copyright: "Copyright (c) 2003-2015, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
