note
	description: "Summary description for {CMS_FORMATS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FORMATS

feature -- Access

	item (a_name: detachable READABLE_STRING_GENERAL): detachable CONTENT_FORMAT
		do
			if a_name /= Void then
				across
					all_formats as c
				until
					Result /= Void
				loop
					if a_name.same_string (c.item.name) then
						Result := c.item
					end
				end
			end
		end

	all_formats: LIST [CONTENT_FORMAT]
		once
				-- Can we provide an external file to read the
				-- supported formats?
			create {ARRAYED_LIST [CONTENT_FORMAT]} Result.make (3)
			Result.force (plain_text)
			Result.force (full_html)
			Result.force (filtered_html)
		end

	default_format: CONTENT_FORMAT
		do
			Result := plain_text --FIXME
		end

	plain_text: PLAIN_TEXT_CONTENT_FORMAT
		once
			create Result
		end

	full_html: FULL_HTML_CONTENT_FORMAT
		once
			create Result
		end

	filtered_html: FILTERED_HTML_CONTENT_FORMAT
		once
			create Result
		end


note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
