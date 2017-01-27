note
	description: "Summary description for {CMS_COMMENTS_STORAGE_NULL}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_COMMENTS_STORAGE_NULL

inherit
	CMS_COMMENTS_STORAGE_I

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create error_handler.make
		end

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.

feature -- Access

	comment (a_cid: INTEGER_64): detachable CMS_COMMENT
		do
		end

	comments_for (a_content: CMS_CONTENT): detachable LIST [CMS_COMMENT]
			-- Comments for `a_content`.
		do
		end

feature -- Change

	save_comment (a_comment: CMS_COMMENT)
			-- Save `a_comment`.
		do
		end

end
