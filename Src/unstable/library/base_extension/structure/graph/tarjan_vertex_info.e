note
	description: "Vertex"
	date: "$Date$"
	revision: "$Revision$"

class
	TARJAN_VERTEX_INFO

feature -- Access

	index: INTEGER
			-- Index

	low_link: INTEGER
			-- Low link

	start_index: INTEGER = 1
			-- The first valid index

feature -- Query

	is_index_defined: BOOLEAN
			-- Is `index' defined?
		do
			Result := index /= 0
		end

	is_low_link_defined: BOOLEAN
			-- Is `low_link' defined?
		do
			Result := low_link /= 0
		end

feature -- Element Change

	set_index (a_index: like index)
			-- Set `a_index' with `a_index'.
		do
			index := a_index
		ensure
			index_set: index = a_index
		end

	set_low_link (a_low_link: like low_link)
			-- Set `a_low_link' with `a_low_link'.
		do
			low_link := a_low_link
		ensure
			low_link_set: low_link = a_low_link
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
