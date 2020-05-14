note
	description: "Summary description for {CMS_FORMAT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FORMAT

inherit
	CONTENT_FORMAT

	DEBUG_OUTPUT

create
	make,
	make_from_format

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8; a_title: detachable READABLE_STRING_8)
		do
			default_create
			name := a_name
			set_title (a_title)
			create filters.make (0)
		end

	make_from_format (a_format: CONTENT_FORMAT)
		do
			make (a_format.name, a_format.title)
			import_filters_from_format (a_format)
		end

feature -- Access

	name: READABLE_STRING_8
			-- <Precursor>

	title: READABLE_STRING_8
			-- <Precursor>

	filters: ARRAYED_LIST [CONTENT_FILTER]
			-- <Precursor>

	filter (a_name: READABLE_STRING_GENERAL): detachable CONTENT_FILTER
			-- Filter named `a_name' if any.
		do
			across
				filters as ic
			until
				Result /= Void
			loop
				if a_name.is_case_insensitive_equal (ic.item.name) then
					Result := ic.item
				end
			end
		end

feature -- Status report

	has_filter_by_name (f_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Has filter named `f_name`?
		do
			across
				filters as ic
			until
				Result
			loop
				Result := f_name.is_case_insensitive_equal (ic.item.name)
			end
		end

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (name)
			if not title.same_string (name) then
				Result.append_character (' ')
				Result.append_character ('"')
				Result.append (title)
				Result.append_character ('"')
			end
			Result.append_character (' ')
			across
				filters as ic
			loop
				Result.append_character ('+')
				Result.append (ic.item.name)
			end
		end

feature -- Element change

	set_title (a_title: detachable READABLE_STRING_8)
			-- Set `title' according to `a_title' or `name' if `a_title' is blank.
		do
			if a_title = Void or else a_title.is_whitespace then
				create {STRING_8} title.make_from_string (name)
			else
				title := a_title
			end
		end

	import_filters_from_format (f: CONTENT_FORMAT)
		do
			across
				f.filters as ic
			loop
				add_filter (ic.item)
			end
		end

	add_filter (f: CONTENT_FILTER)
		require
			has_no_such_filter: filter (f.name) = Void
		do
			filters.extend (f)
		ensure
			has_filter: filter (f.name) = f
		end

	remove_filter_by_name (a_name: READABLE_STRING_GENERAL)
			-- Remove filter named `a_name' if any.
		local
			lst: like filters
		do
			from
				lst := filters
				lst.start
			until
				lst.after
			loop
				if a_name.is_case_insensitive_equal (lst.item.name) then
					lst.remove
				else
					lst.forth
				end
			end
		ensure
			filter_removed: filter (a_name) = Void
		end


note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
