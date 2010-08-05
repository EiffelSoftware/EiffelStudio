note
	description: "Summary description for {REPOSITORY_LOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	REPOSITORY_LOG

inherit
	COMPARABLE

feature -- Access

	parent: REPOSITORY_DATA
		deferred
		end

	id: STRING
		deferred
		end

	date: STRING
		deferred
		end

	author: STRING
		deferred
		end

	message: STRING
		deferred
		end

	single_line_message: like message
		do
			Result := message.string
			Result.left_adjust
			Result.right_adjust
			if Result.occurrences ('%N') > 0 then
				Result.replace_substring_all ("%N", "%%N")
			end
		end

	paths: LIST [TUPLE [path: STRING; kind: NATURAL_8; action: STRING]]
		deferred
		end

	common_parent_path: STRING
		deferred
		end

feature -- Element change

	mark_read
		do
			parent.mark_log_read (id)
		end

	mark_unread
		do
			parent.mark_log_unread (id)
		end

	delete
		do
			mark_read
			parent.delete_log (Current)
		end

	archive
		do
			mark_read
			parent.archive_log (Current)
		end

feature -- Status report

	unread: BOOLEAN
		do
			Result := parent.is_unread_log (Current)
		end

feature -- Review report		

	has_review: BOOLEAN
		do
			Result := parent.review_exists (Current)
		end

	review: detachable REPOSITORY_LOG_REVIEW
		do
			if attached parent.review (Current) as r then
				Result := r
			end
		end

feature -- Diff report

	has_diff: BOOLEAN
		do
			Result := parent.diff_exists (Current)
		end

	diff: STRING
		do
			if attached parent.diff (Current) as d then
				Result := d
			else
				create Result.make_empty
			end
		end

end
