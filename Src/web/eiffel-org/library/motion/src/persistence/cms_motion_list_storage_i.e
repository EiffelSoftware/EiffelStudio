note
	description: "[
		API to handle Motion List storage
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MOTION_LIST_STORAGE_I

inherit
	SHARED_LOGGER

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end


feature -- Access : Motion	

	row_count_motion_list (a_category: INTEGER; a_status: STRING; a_filter: STRING; a_content:INTEGER ): INTEGER
			-- Row count for motion list
		deferred
		end

	motion_list (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: STRING; a_column: READABLE_STRING_32; a_order: INTEGER; a_filter:STRING; a_content:INTEGER): LIST [CMS_MOTION_LIST]
			-- All motion items, filter by page `a_page_numer' and rows per page `a_row_per_page'
		deferred
		end

	motion_by_id (a_wid: INTEGER_64): detachable CMS_MOTION_LIST
			-- Motion list item for the given id `a_wid', if any.
		deferred
		end

	motion_interactions (a_wid: INTEGER): detachable LIST [CMS_MOTION_LIST_INTERACTION]
			-- Motion list interactions for a given wish `a_wid', if any.
		deferred
		end

	motion_attachments (a_wid: INTEGER_64; a_interaction_id: INTEGER_64): detachable LIST [CMS_MOTION_FILE]
			--  Motion list attachments for a given wish `a_wid', if any.
		deferred
		end

	motion_author (a_motion: CMS_MOTION_LIST): detachable CMS_USER
			-- Motion's author. if any.
		require
			valid_motion: a_motion.has_id
		deferred
		end

	vote_motion (u: CMS_USER; a_motion: CMS_MOTION_LIST): INTEGER
			-- Has the user `u' vote for the wish `a_motion'.
		require
			valid_motion: a_motion.has_id
			valid_user: a_motion.has_id
		deferred
		end

feature -- Change Motion Vote

	add_motion_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- User `a_user' add like to motion `a_wid'.
		deferred
		end

	add_motion_not_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- User `a_user' add not like to motion `a_wid'.
		deferred
		end

feature -- Change: Motion

	save_motion (a_motion: CMS_MOTION_LIST)
			-- Save a new motion `a_motion'.
		deferred
		end

	save_motion_interaction (a_motion: CMS_MOTION_LIST_INTERACTION)
			-- Save a new motion `a_motion_interaction'.
		deferred
		end

	upload_motion_attachment  (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_size: INTEGER_64; a_content: READABLE_STRING_8; a_file_name: READABLE_STRING_GENERAL)
			-- Upload a file for a motion list item `a_id' with file name `a_file_name', content `a_content' and length `a_size'.
		deferred
		end

	remove_motion_attachments (a_id: INTEGER_64; a_interaction_id: INTEGER_64)
			-- Remove all attachments associated with `a_id'.
		deferred
		end

	remove_motion_attachment_by_name (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_name: READABLE_STRING_GENERAL)
			-- Remove attachment with name `a_name' associated motion wish `a_id'.
		deferred
		end

feature -- Access: Categories

	categories_count: INTEGER_64
			-- Number of categories.
		deferred
		end

	recent_categories (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_MOTION_LIST_CATEGORY]
			-- List of recent `a_count' users motion an offset of `lower'.
		deferred
		end

	categories: LIST [CMS_MOTION_LIST_CATEGORY]
			-- List of motion list categories.
		deferred
		end

	category_by_id (a_id: INTEGER_64): detachable CMS_MOTION_LIST_CATEGORY
			-- Category id for the given id `a_id', if any.
		deferred
		end


	category_by_name (a_name: READABLE_STRING_32): detachable CMS_MOTION_LIST_CATEGORY
			-- Category for the given name`a_name', if any.
		deferred
		end

feature -- Change: Category

	save_category (a_category: CMS_MOTION_LIST_CATEGORY)
			-- Save category `a_category'.
		deferred
		end

feature -- Access: Status

	status: LIST [CMS_MOTION_LIST_STATUS]
			-- List of motion list status.
		deferred
		end


end
