note
	description: "Summary description for {WDOCS_TIMELINE_PAGE_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_TIMELINE_PAGE_EVENT

inherit
	WDOCS_TIMELINE_PATH_EVENT

create
	make

feature {NONE} -- Initialization

	make (a_base_dir: PATH; a_page_path: PATH; a_page: WIKI_PAGE; a_rev: WDOCS_REVISION_INFO; a_date: DATE_TIME)
		require
			attached a_page.path as p implies a_page_path.same_as (p)
		do
			base_dir := a_base_dir
			location := a_page_path
			page := a_page
			revision := a_rev
			date := a_date
		end

feature -- Access

	page: WIKI_PAGE

	title: READABLE_STRING_32
		do
			Result := page.title
		end

end
