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

	DEBUG_OUTPUT

	ITERABLE [CMS_LINK]

feature -- Access	

	title: READABLE_STRING_32
			-- Associated title.

	location: READABLE_STRING_8
			-- Associated url location.

feature -- status report	

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

feature -- Query

	parent: detachable CMS_LINK
			-- Optional parent link.

	children: detachable LIST [CMS_LINK]
			-- Optional children links.
			-- Useful to have a non flat menu.
		deferred
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
		end

note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
