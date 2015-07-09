note
	description: "Summary description for {CMS_FORMATS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FORMATS

inherit
	ITERABLE [CMS_FORMAT]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make (nb)
		end

feature -- Access

	item (a_name: detachable READABLE_STRING_GENERAL): detachable CMS_FORMAT
		do
			if a_name /= Void then
				across
					items as c
				until
					Result /= Void
				loop
					if a_name.is_case_insensitive_equal (c.item.name) then
						Result := c.item
					end
				end
			end
		end

feature -- Element change

	extend (f: CMS_FORMAT)
			-- Add format `f' to available formats.
		do
			items.force (f)
		ensure
			has_format: item (f.name) = f
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [CMS_FORMAT]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Built-in formats

	default_format: CONTENT_FORMAT
		do
			Result := plain_text --FIXME
		end

	plain_text: PLAIN_TEXT_CONTENT_FORMAT
		once
			create Result
		end

	filtered_html: FILTERED_HTML_CONTENT_FORMAT
		once
			create Result
		end

feature {NONE} -- Implementation

	items: ARRAYED_LIST [CMS_FORMAT]

invariant
	items /= Void

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
