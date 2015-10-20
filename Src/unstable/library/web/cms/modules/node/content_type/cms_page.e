note
	description: "A page node."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGE

inherit
	CMS_NODE
		redefine
			make_empty,
			import_node
		end

create
	make_empty,
	make

feature {NONE} -- Initialization

	make_empty
		do
			Precursor
		end

feature -- Conversion

	import_node (a_node: CMS_NODE)
			-- <Precursor>
		do
			Precursor (a_node)
			if attached {CMS_PAGE} a_node as l_page then
				set_parent (l_page.parent)
			end
		end

feature -- Access

	content_type: READABLE_STRING_8
		once
			Result := {CMS_PAGE_NODE_TYPE}.name
		end

feature -- Access: content

	summary: detachable READABLE_STRING_32
			-- A short summary of the node.

	content: detachable READABLE_STRING_32
			-- Content of the node.

	format: detachable READABLE_STRING_8
			-- Format associated with `content' and `summary'.
			-- For example: text, mediawiki, html, etc

	parent: detachable CMS_PAGE
			-- Eventual parent page.
			--| Used to describe a book structure.

feature -- Element change

	set_content (a_content: like content; a_summary: like summary; a_format: like format)
		do
			content := a_content
			summary := a_summary
			format := a_format
		end

	set_parent (a_page: detachable CMS_PAGE)
			-- Set `parent' to `a_page'
		require
			Current_is_not_parent_of_a_page: not is_parent_of (a_page)
		do
			parent := a_page
		end

feature -- Status report

	is_parent_of (a_page: detachable CMS_PAGE): BOOLEAN
			-- Is Current page, a parent of `a_page' ?
		do
			if
				a_page /= Void and then
				attached a_page.parent as l_parent
			then
				if l_parent.same_node (a_page) then
					Result := True
				else
					Result := is_parent_of (l_parent)
				end
			end
		end

end
