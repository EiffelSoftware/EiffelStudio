note
	description: "[
			Abstraction to represent a URI link in the CMS system.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_LINK

inherit
	REFACTORING_HELPER
		undefine
			is_equal
		end

	DEBUG_OUTPUT
		undefine
			is_equal
		end

	ITERABLE [CMS_LINK]
		undefine
			is_equal
		end

	COMPARABLE

feature -- Access	

	title: READABLE_STRING_32
			-- Associated title.

	location: READABLE_STRING_8
			-- Associated url location.

	weight: INTEGER
			-- Optional weight used for order.

	query_string: detachable READABLE_STRING_8
			-- Query string from `location'.
		local
			i: INTEGER
			loc: like location
			s: STRING_8
		do
			loc := location
			i := loc.index_of ('?', 1)
			if i > 0 then
				s := loc.substring (i + 1, loc.count).to_string_8
				i := loc.last_index_of ('#', loc.count)
				if i > 0 then
					s.keep_head (i - 1)
				end
				Result := s
			end
		end

	fragment_string: detachable READABLE_STRING_8
			-- Query string from `location'.
		local
			i: INTEGER
			loc: like location
		do
			loc := location
			i := loc.last_index_of ('#', loc.count)
			if i > 0 then
				Result := loc.substring (i + 1, loc.count)
			end
		end

feature -- Element change

	add_query_parameter (a_encoded_name: READABLE_STRING_8; a_encoded_value: detachable READABLE_STRING_8)
			-- Add query parameter "$a_encoded_name=$a_encoded_value" to `location'.
			-- note: the argument must already be url encoded!
		local
			q: STRING_8
			f: detachable READABLE_STRING_8
			i,j: INTEGER
			loc: STRING_8
		do
			create loc.make_from_string (location)

			j := loc.last_index_of ('#', loc.count)
			if j > 0 then
				f := loc.substring (j, loc.count)
				loc.keep_head (j - 1)
			end
			i := loc.index_of ('?', 1)
			if i > 0 then
				q := loc.substring (i + 1, loc.count)
				loc.keep_head (i)
			else
				create q.make_empty
			end

			if not q.is_empty then
				q.append_character ('&')
			end

			q.append (a_encoded_name)
			if a_encoded_value /= Void then
				q.append_character ('=')
				q.append (a_encoded_value)
			end

			loc.append_character ('?')
			loc.append (q)
			if f /= Void then
				loc.append (f)
			end
			location := loc
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			if weight = other.weight then
				Result := title < other.title
			else
				Result := weight < other.weight
			end
		end

feature -- Status report

	is_active: BOOLEAN
			-- Is current link active?
			-- i.e: related to requested url.
		deferred
		end

	is_expanded: BOOLEAN
			-- Is expanded and visually expanded?
		deferred
		end

	is_collapsed: BOOLEAN
			-- Is expanded, but visually collapsed?
		deferred
		ensure
			Result implies is_expandable
		end

	is_expandable: BOOLEAN
			-- Is expandable?	
		deferred
		end

	has_children: BOOLEAN
			-- Has sub link?
		deferred
		end

feature -- Security

	is_forbidden: BOOLEAN
			-- Is Current link forbidden?
			-- Current link could be disabled for current CMS user.
		deferred
		end

feature -- Element change

	set_title (a_title: detachable READABLE_STRING_GENERAL)
			-- Set `title' to `a_title' or `location'.
		do
			if a_title /= Void then
				title := a_title.as_string_32
			else
				title := location.as_string_32
			end
		end

	set_location (a_loc: READABLE_STRING_8)
			-- Set `location' to `a_loc'.
		do
			location := a_loc
		end

	set_weight (a_weight: INTEGER)
			-- Set `weight' to `a_weight'.
		do
			weight := a_weight
		ensure
			weight_set: weight = a_weight
		end

feature -- Query

	parent: detachable CMS_LINK
			-- Optional parent link.

	children: detachable LIST [CMS_LINK]
			-- Optional children links.
			-- Useful to have a non flat menu.
		deferred
		end

feature -- Option visual properties

	extended_css_class (a_class: READABLE_STRING_8): READABLE_STRING_8
			-- `a_class` extended with potential `css_class` value.
		do
			if attached css_class as cl and then not cl.is_whitespace then
				if a_class.is_whitespace then
					Result := cl
				else
					Result := a_class + " " + cl
				end
			else
				Result := a_class
			end
		end

	css_class: detachable READABLE_STRING_8
			-- Optional css class value.

	set_css_class (a_css_cl: detachable READABLE_STRING_8)
		do
			css_class := a_css_cl
		end

	add_css_class (a_css_cl: READABLE_STRING_8)
		local
			cl: detachable READABLE_STRING_8
		do
			cl := css_class
			if cl = Void then
				css_class := a_css_cl
			else
				css_class := cl + " " + a_css_cl
			end
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [CMS_LINK]
			-- Fresh cursor associated with current structure
		do
			if attached children as lst then
				Result := lst.new_cursor
			else
				Result := (create {ARRAYED_LIST [CMS_LINK]}.make (0)).new_cursor
			end
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (title)
			Result.append_string_general (" -> ")
			Result.append_string_general (location)
			Result.append_string_general (" [")
			Result.append_integer (weight)
			Result.append_string_general ("]")
		end

note
	copyright: "2011-2020, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
