note
	description: "Summary description for {CMS_WISH_LIST_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WISH_LIST_STORAGE_NULL

inherit

	CMS_WISH_LIST_STORAGE_I


feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Acess : WishList

	row_count_wish_list (a_category: INTEGER; a_status: STRING; a_filter: STRING; a_content:INTEGER ): INTEGER
			-- <Precursor>
		do
		end

	wish_list (a_page_number: INTEGER; a_rows_per_page: INTEGER; a_category: INTEGER; a_status: STRING; a_column: READABLE_STRING_32; a_order: INTEGER; a_filter:STRING; a_content:INTEGER): LIST [CMS_WISH_LIST]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_WISH_LIST]} Result.make (0)
		end

	wish_by_id (a_wid: INTEGER): detachable CMS_WISH_LIST
			-- <Precursor>
		do
		end

	wish_interactions (a_wid: INTEGER): detachable LIST [CMS_WISH_LIST_INTERACTION]
			-- <Precursor>
		do
		end

	wish_attachments (a_wid: INTEGER_64; a_interaction_id: INTEGER_64): detachable LIST [CMS_WISH_FILE]
			-- <Precursor>
		do
		end

	wish_author (a_wish: CMS_WISH_LIST): detachable CMS_USER
			-- <Precursor>
		do
		end

feature -- Change: WishList

	save_wish (a_wish: CMS_WISH_LIST)
			-- <Precursor>
		do
		end

	save_wish_interaction (a_wish: CMS_WISH_LIST_INTERACTION)
			-- Save a new wish `a_wish_interaction'.
		do
		end

	upload_wish_attachment  (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_size:INTEGER_64; a_content: READABLE_STRING_32; a_file_name: READABLE_STRING_32)
			-- <Precursor>
		do
		end

	remove_wish_attachments (a_id: INTEGER_64; a_interaction_id: INTEGER_64)
			-- <Precursor>
		do
		end

	remove_wish_attachment_by_name (a_id: INTEGER_64; a_interaction_id: INTEGER_64; a_name: READABLE_STRING_32)
			-- <Precursor>
		do
		end

feature -- Access: Categories

	categories: LIST [CMS_WISH_LIST_CATEGORY]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_WISH_LIST_CATEGORY]} Result.make (0)
		end

feature -- Access: Status

	status: LIST [CMS_WISH_LIST_STATUS]
			-- <Precursor>
		do
			create {ARRAYED_LIST [CMS_WISH_LIST_STATUS]} Result.make (0)
		end


end
