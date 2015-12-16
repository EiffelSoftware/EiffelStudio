note
	description: "Summary description for {CMS_WDOCS_CONTENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WDOCS_CONTENT

inherit
	CMS_CONTENT

create
	make

feature {NONE} -- Initialization

	make (wp: like page; a_id: READABLE_STRING_GENERAL)
		do
			create identifier.make_from_string_general (a_id)
			title  := wp.title
			page := wp
		end

	page: WIKI_PAGE

feature -- Access

	identifier: detachable IMMUTABLE_STRING_32
			-- Optional identifier.

	title: detachable READABLE_STRING_32
			-- Title associated with Current content.

	content_type: STRING_8 = "wdoc"
			-- Associated content type name.
			-- Page, Article, Blog, News, etc.

	format: detachable READABLE_STRING_8
			-- Format associated with `content' and `summary'.
			-- For example: text, mediawiki, html, etc
		do
		end

	link: detachable CMS_LOCAL_LINK
			-- Associated menu link.

feature -- Element change

	set_link (lnk: like link)
		do
			link := lnk
		end

end
