note
	description: "Node object representing the CMS_NODE data in database."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PARTIAL_NODE

inherit
	CMS_NODE
		rename
			make_empty as make_empty_node,
			set_content as set_all_content
		end

create
	make_empty

feature {NONE} -- Initialization

	make_empty (a_content_type: READABLE_STRING_8)
		require
			type_not_blank: not a_content_type.is_whitespace
		do
			content_type := a_content_type
			make_empty_node
		end

feature -- Access: code

	content_type: READABLE_STRING_8
			-- <Precursor>

feature -- Access: content			

	summary: detachable READABLE_STRING_32
			-- A short summary of the node.

	content: detachable READABLE_STRING_32
			-- Content of the node.

	format: detachable READABLE_STRING_8
			-- Format associated with `content' and `summary'.
			-- For example: text, mediawiki, html, etc	

feature -- Element change

	set_all_content (a_content: like content; a_summary: like summary; a_format: like format)
			-- <Precursor>
		do
			set_content (a_content)
			set_summary (a_summary)
			set_format (a_format)
		end

	set_content (a_content: like content)
			-- Assign `content' with `a_content', and set the associated `format'.
		do
			content := a_content
		ensure
			content_assigned: content = a_content
		end

	set_summary (a_summary: like summary)
			-- Assign `summary' with `a_summary'.
		do
			summary := a_summary
		ensure
			summary_assigned: summary = a_summary
		end

	set_format (a_format: like format)
			-- Assign `format' with `a_format'.
		do
			format := a_format
		ensure
			format_assigned: format = a_format
		end

invariant

note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
