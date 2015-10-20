note
	description: "Summary description for {CMS_BLOG}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOG

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
			if attached {CMS_BLOG} a_node as l_blog then
				if attached l_blog.tags as l_tags then
					across
						l_tags as ic
					loop
						add_tag (ic.item)
					end
				end
			end
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

feature -- Access: blog

	tags: detachable ARRAYED_LIST [READABLE_STRING_32]
			-- Optional tags

feature -- Element change: node

	set_content (a_content: like content; a_summary: like summary; a_format: like format)
		do
			content := a_content
			summary := a_summary
			format := a_format
		end

feature -- Element change: blog		

	add_tag (a_tag: READABLE_STRING_32)
			-- Set `parent' to `a_page'
		require
			not a_tag.is_whitespace
		local
			l_tags: like tags
		do
			l_tags := tags
			if l_tags = Void then
				create l_tags.make (1)
				tags := l_tags
			end
			l_tags.force (a_tag)
		end

	set_tags_from_string (a_tags: READABLE_STRING_32)
		local
			t: STRING_32
		do
			tags := Void
			across
				a_tags.split (',') as ic
			loop
				t := ic.item
				t.left_adjust
				t.right_adjust
				if not t.is_whitespace then
					add_tag (t)
				end
			end
		end

end

