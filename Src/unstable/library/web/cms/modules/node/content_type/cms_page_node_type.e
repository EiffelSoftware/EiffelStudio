note
	description: "[
			Interface defining a CMS page type.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGE_NODE_TYPE

inherit
	CMS_NODE_TYPE [CMS_PAGE]

feature -- Access

	name: STRING = "page"
			-- Internal name.

	title: STRING_32 = "Page"
			-- Human readable name.

	description: STRING_32 = "Use basic pages for your content, such as an 'About us' page."
			-- Optional description

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
