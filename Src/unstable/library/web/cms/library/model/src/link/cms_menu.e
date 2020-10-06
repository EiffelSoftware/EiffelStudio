note
	description: "[
				Abstraction to represent a MENU in the CMS system.
				It has items as sub menu/link.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MENU

inherit
	CMS_LINK_COMPOSITE
		redefine
			is_empty
		end

	DEBUG_OUTPUT

create
	make,
	make_with_title

feature {NONE} -- Initialization

	make (a_name: like name; a_capacity: INTEGER)
			-- Create menu with name `a_name' and a capacity of `a_capacity'.
		do
			name := a_name
			create items.make (a_capacity)
		ensure
			name_set:  name = a_name
			items_set: items.capacity = a_capacity
		end

	make_with_title (a_name: like name; a_title: READABLE_STRING_32; a_capacity: INTEGER)
			-- Create menu with name `a_name' and a capacity of `a_capacity', and title `a_title'
		do
			make (a_name, a_capacity)
			set_title (a_title)
		ensure
			name_set: name = a_name
			title_set: title = a_title
			items_set: items.capacity = a_capacity
		end

feature -- Access

	name: READABLE_STRING_8
			-- Identifier for Current menu.

	title: detachable READABLE_STRING_32
			-- Optional title.

	items: ARRAYED_LIST [CMS_LINK]
			-- <Precursor>

feature -- Status report

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := items.is_empty
		end

	has (lnk: CMS_LINK): BOOLEAN
			-- Has the current Menu a link `lnk'.
		do
			across
				items as ic
			until
				Result
			loop
				Result := ic.item.location.same_string (lnk.location)
			end
		end

	debug_output: STRING_32
		do
			create Result.make_from_string_general (name)
			if attached title as t then
				Result.append_character (' ')
				Result.append_character ('%"')
				Result.append (t)
				Result.append_character ('%"')
			end
			if items.count > 0 then
				Result.append ("%/8230/")
			end
		end

feature -- Element change

	extend (lnk: CMS_LINK)
			-- <Precursor>	
		do
			items.extend (lnk)
		end

	remove (lnk: CMS_LINK)
			-- <Precursor>
		do
			items.prune_all (lnk)
		end

	set_title (t: like title)
			-- Set `title' with `t'.
		do
			title := t
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [CMS_LINK]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

invariant

note
	copyright: "2011-2016, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
