note
	description: "[
			Instance of CMS_CONTENT representing the minimal information
			for a CMS_CONTENT.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PARTIAL_CONTENT

inherit
	CMS_CONTENT

create
	make_empty

feature {NONE} -- Initialization

	make_empty (a_content_type: READABLE_STRING_8)
		require
			type_not_blank: not a_content_type.is_whitespace
		do
			content_type := a_content_type
		end

feature -- Access

	identifier: detachable READABLE_STRING_32
			-- <Precursor>

	title: detachable READABLE_STRING_32
			-- Title associated with Current content.

	content_type: READABLE_STRING_8
			-- Associated content type name.
			-- Page, Article, Blog, News, etc.

	format: detachable READABLE_STRING_8
			-- Format associated with `content' and `summary'.
			-- For example: text, mediawiki, html, etc

	link: detachable CMS_LOCAL_LINK
			-- Associated menu link.

feature -- Element change

	set_identifier (a_identifier: detachable READABLE_STRING_GENERAL)
		do
			if a_identifier = Void then
				identifier := Void
			else
				create {IMMUTABLE_STRING_32} identifier.make_from_string_general (a_identifier)
			end
		end

	set_title (a_title: detachable READABLE_STRING_GENERAL)
		do
			if a_title = Void then
				title := Void
			else
				create {STRING_32} title.make_from_string_general (a_title)
			end
		end

	set_format (a_format: like format)
			-- Assign `format' with `a_format'.
		do
			format := a_format
		ensure
			format_assigned: format = a_format
		end

	set_link (a_link: like link)
			-- Assign `link' with `a_link'.
		do
			link := a_link
		ensure
			link_assigned: link = a_link
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
