note
	description: "Summary description for {CMS_FORMATS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FORMATS

feature -- Access

	format (a_name: like {CMS_FORMAT}.name): detachable CMS_FORMAT
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

	all_formats: LIST [CMS_FORMAT]
		once
			create {ARRAYED_LIST [CMS_FORMAT]} Result.make (3)
			Result.force (plain_text)
			Result.force (full_html)
			Result.force (filtered_html)
		end

	default_format: CMS_FORMAT
		do
			Result := plain_text --FIXME
		end

	plain_text: CMS_PLAIN_TEXT_FORMAT
		once
			create Result
		end

	full_html: CMS_FULL_HTML_FORMAT
		once
			create Result
		end

	filtered_html: CMS_FILTERED_HTML_FORMAT
		once
			create Result
		end


end
