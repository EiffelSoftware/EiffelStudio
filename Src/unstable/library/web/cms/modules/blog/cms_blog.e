note
	description: "Summary description for {CMS_BLOG}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOG

inherit
	CMS_NODE
		redefine
			make_empty
		end

create
	make_empty,
	make

feature {NONE} -- Initialization

	make_empty
		do
			Precursor
		end

feature -- Access

	content_type: READABLE_STRING_8
		once
			Result := {CMS_BLOG_NODE_TYPE}.name
		end

feature -- Access: node

	summary: detachable READABLE_STRING_32
			-- A short summary of the node.

	content: detachable READABLE_STRING_32
			-- Content of the node.

	format: detachable READABLE_STRING_8
			-- Format associated with `content' and `summary'.
			-- For example: text, mediawiki, html, etc

feature -- Element change: node

	set_content (a_content: like content; a_summary: like summary; a_format: like format)
		do
			content := a_content
			summary := a_summary
			format := a_format
		end

end

