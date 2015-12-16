note
	description: "[
			Abstract of entity managed by CMS.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_CONTENT

inherit
	DEBUG_OUTPUT

feature -- Access

	identifier: detachable READABLE_STRING_32
			-- Optional identifier.
		deferred
		end

	title: detachable READABLE_STRING_32
			-- Title associated with Current content.
		deferred
		end

	content_type: READABLE_STRING_8
			-- Associated content type name.
			-- Page, Article, Blog, News, etc.
		deferred
		end

	format: detachable READABLE_STRING_8
			-- Format associated with `content' and `summary'.
			-- For example: text, mediawiki, html, etc
		deferred
		end

	link: detachable CMS_LOCAL_LINK
			-- Associated menu link.
		deferred
		end

feature -- Status report

	has_identifier: BOOLEAN
			-- Current content has identifier?
		do
			Result := identifier /= Void
		ensure
			Result implies identifier /= Void
		end

	is_typed_as (a_content_type: READABLE_STRING_GENERAL): BOOLEAN
			-- Is current node of type `a_content_type' ?
		do
			Result := a_content_type.is_case_insensitive_equal (content_type)
		end

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make_empty
			Result.append_character ('<')
			Result.append_string_general (content_type)
			Result.append_character ('>')
			if attached title as l_title then
				Result.append_character (' ')
				Result.append_character ('%"')
				Result.append (l_title)
				Result.append_character ('%"')
			end
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
