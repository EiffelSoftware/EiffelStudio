note
	description: "Summary description for {CMS_PAGE_NODE_TYPE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGE_NODE_TYPE

inherit
	CMS_NODE_TYPE [CMS_PAGE]
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create {ARRAYED_LIST [like available_formats.item]} available_formats.make (3)
			available_formats.extend (create {PLAIN_TEXT_CONTENT_FORMAT})
			available_formats.extend (create {FILTERED_HTML_CONTENT_FORMAT})
			available_formats.extend (create {FULL_HTML_CONTENT_FORMAT})
		end

feature -- Access

	name: STRING = "page"
			-- Internal name.

	title: STRING_32 = "Page"
			-- Human readable name.

	description: STRING_32 = "Use basic pages for your content, such as an 'About us' page."
			-- Optional description

feature -- Access

	available_formats: LIST [CONTENT_FORMAT]
			-- Available formats for Current type.

feature -- Factory

	new_node_with_title (a_title: READABLE_STRING_32; a_partial_node: detachable CMS_NODE): like new_node
			-- New node with `a_title' and fill from partial `a_partial_node' if set.
		do
			create Result.make (a_title)
			if a_partial_node /= Void then
				Result.import_node (a_partial_node)
				Result.set_title (a_title)
			end
		end

	new_node (a_partial_node: detachable CMS_NODE): CMS_PAGE
			-- New node based on partial `a_partial_node', or from none.
		do
			create Result.make_empty
			if a_partial_node /= Void then
				Result.import_node (a_partial_node)
			end
		end

end
