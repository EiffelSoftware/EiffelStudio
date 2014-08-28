note
	description: "Summary description for {CMS_MENU}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MENU

inherit
	CMS_LINK_COMPOSITE

create
	make,
	make_with_title

feature {NONE} -- Initialization

	make (a_name: like name; n: INTEGER)
		do
			name := a_name
			create items.make (n)
		end

	make_with_title (a_name: like name; a_title: READABLE_STRING_32; n: INTEGER)
		do
			make (a_name, n)
			set_title (a_title)
		end

feature -- Access

	name: READABLE_STRING_8

	title: detachable READABLE_STRING_32

	items: ARRAYED_LIST [CMS_LINK]

	extend (lnk: CMS_LINK)
		do
			items.extend (lnk)
		end

	remove (lnk: CMS_LINK)
		do
			items.prune_all (lnk)
		end

feature -- status report

	is_empty: BOOLEAN
		do
			Result := items.is_empty
		end

feature -- Element change

	set_title (t: like title)
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

end
