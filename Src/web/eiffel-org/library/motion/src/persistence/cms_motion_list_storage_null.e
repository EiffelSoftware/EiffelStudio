note
	description: "Summary description for {CMS_MOTION_LIST_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_LIST_STORAGE_NULL

inherit

	CMS_MOTION_LIST_STORAGE_I


feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Acess : WishList

	row_count_motion_list (a_category: INTEGER; a_status: STRING; a_filter: STRING; a_content:INTEGER ): INTEGER
			-- <Precursor>
		do
		end

	motion_list (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: STRING; a_column: READABLE_STRING_32; a_order: INTEGER; a_filter:STRING; a_content:INTEGER): LIST [CMS_MOTION_LIST]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_MOTION_LIST]} Result.make (0)
		end

	motion_by_id (a_wid: INTEGER_64): detachable CMS_MOTION_LIST
			-- <Precursor>
		do
		end

	motion_interactions (a_wid: INTEGER): detachable LIST [CMS_MOTION_LIST_INTERACTION]
			-- <Precursor>
		do
		end

	motion_attachments (a_wid: INTEGER_64; a_interaction_id: INTEGER_64): detachable LIST [CMS_MOTION_FILE]
			-- <Precursor>
		do
		end

	motion_author (a_wish: CMS_MOTION_LIST): detachable CMS_USER
			-- <Precursor>
		do
		end

	vote_motion (u: CMS_USER; a_wish: CMS_MOTION_LIST): INTEGER
			-- <Precursor>.
		do
		end


feature -- Change wish vote

	add_motion_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- User `a_user' add like to wish `a_wid'.
		do
		end

	add_motion_not_like (a_user: CMS_USER; a_wid: INTEGER_64)
			-- User `a_user' add not like to wish `a_wid'.
		do
		end


feature -- Change: WishList

	save_motion (a_wish: CMS_MOTION_LIST)
			-- <Precursor>
		do
		end

	save_motion_interaction (a_wish: CMS_MOTION_LIST_INTERACTION)
			-- Save a new wish `a_wish_interaction'.
		do
		end

	upload_motion_attachment  (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_size: INTEGER_64; a_content: READABLE_STRING_8; a_file_name: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
		end

	remove_motion_attachments (a_id: INTEGER_64; a_interaction_id: INTEGER_64)
			-- <Precursor>
		do
		end

	remove_motion_attachment_by_name (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_name: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
		end

feature -- Access: Categories

	categories_count: INTEGER_64
			-- <Precursor>
		do
		end

	recent_categories (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_MOTION_LIST_CATEGORY]
			-- <Precursor>.
		do
			create {ARRAYED_LIST [CMS_MOTION_LIST_CATEGORY]} Result.make (0)
		end

	categories: LIST [CMS_MOTION_LIST_CATEGORY]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_MOTION_LIST_CATEGORY]} Result.make (0)
		end

	category_by_id (a_id: INTEGER_64): detachable CMS_MOTION_LIST_CATEGORY
			-- <Precursor>.
		do
		end

	category_by_name (a_name: READABLE_STRING_32): detachable CMS_MOTION_LIST_CATEGORY
			-- <Precursor>.
		do
		end

feature -- Change: Category

	save_category (a_category: CMS_MOTION_LIST_CATEGORY)
			-- <Precursor>.
		do
		end



feature -- Access: Status

	status: LIST [CMS_MOTION_LIST_STATUS]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_MOTION_LIST_STATUS]} Result.make (0)
		end


end
