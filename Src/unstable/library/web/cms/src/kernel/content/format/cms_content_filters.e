note
	description: "Summary description for {CMS_CONTENT_FILTERS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CONTENT_FILTERS

inherit
	TABLE_ITERABLE [CONTENT_FILTER, READABLE_STRING_GENERAL]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make_caseless (5)
		end

feature -- Access

	item (a_name: detachable READABLE_STRING_GENERAL): detachable CONTENT_FILTER
		do
			if a_name /= Void then
				Result := items.item (a_name)
			end
		end

feature -- Element change

	extend (f: CONTENT_FILTER)
			-- Add format `f' to available formats.
		do
			items.force (f, f.name)
		ensure
			has_format: item (f.name) = f
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [CONTENT_FILTER, READABLE_STRING_GENERAL]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature {NONE} -- Implementation

	items: STRING_TABLE [CONTENT_FILTER]

invariant
	items /= Void

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
