note
	description: "CMS Response returning a Wiki Doc page."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_PAGE_CMS_RESPONSE

inherit
	GENERIC_VIEW_CMS_RESPONSE

create
	make,
	make_with_page

feature {NONE} -- Initialization

	make_with_page (pg: like page; req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api)
		do
			make (req, res, a_api)
			set_page (pg)
		end

feature -- Access

	page: like {WDOCS_MANAGER}.page
			-- Associated page.

	book_name: detachable READABLE_STRING_GENERAL
			-- Associated book name.

	version_id: detachable READABLE_STRING_GENERAL
			-- Associated version id.

feature -- Element change

	set_page (pg: like page)
			-- Set `page' to `pg'.
		do
			page := pg
		end

	set_book_name (bn: like book_name)
			-- Set `book_name' to `bn'.
		do
			book_name := bn
		end

	set_version_id (v: like version_id)
			-- Set `version_id' to `v'.
		do
			version_id := v
		end

end
