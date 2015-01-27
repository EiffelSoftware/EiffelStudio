note
	description: "Summary description for {CMS_FORMATS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FORMATS

feature -- Access

	format (a_name: like {CONTENT_FORMAT}.name): detachable CONTENT_FORMAT
		do
			across
				all_formats as c
			until
				Result /= Void
			loop
				if c.item.name.same_string (a_name) then
					Result := c.item
				end
			end
		end

	all_formats: LIST [CONTENT_FORMAT]
		once
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
