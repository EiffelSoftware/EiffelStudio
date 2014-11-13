note
	description: "[
			Abstraction to represent a link to a CMS resource.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_LOCAL_LINK

inherit
	CMS_LINK

	CMS_LINK_COMPOSITE
		rename
			items as children,
			extend as add_link,
			remove as remove_link
		end

create
	make

feature {NONE} -- Initialization

	make (a_title: detachable like title; a_location: like location)
			-- Create current local link with optional title `a_title' and location `a_location'.
		do
			if a_title /= Void then
				title := a_title
			else
				title := a_location
			end
			location := a_location
		end

feature -- Access

	permission_arguments: detachable ITERABLE [READABLE_STRING_8]
			-- Permissions required by current link resource.

	children: detachable LIST [CMS_LINK]
			-- <Precursor>

feature -- Status report

	is_active: BOOLEAN
			-- <Precursor>

	is_expanded: BOOLEAN
			-- <Precursor>	
		do
			Result := is_expandable and then internal_is_expanded
		end

	is_collapsed: BOOLEAN
			-- <Precursor>
		do
			Result := is_expandable and then internal_is_collapsed
		end

	is_expandable: BOOLEAN
			-- <Precursor>	
		do
			Result := internal_is_expandable or internal_is_expanded or has_children
		end

	has_children: BOOLEAN
			-- <Precursor>	
		do
			Result := attached children as l_children and then not l_children.is_empty
		end

feature -- Element change

	add_link (lnk: CMS_LINK)
			-- <Precursor>
		local
			lst: like children
		do
			lst := children
			if lst = Void then
				create {ARRAYED_LIST [CMS_LINK]} lst.make (1)
				children := lst
			end
			lst.force (lnk)
		end

	remove_link (lnk: CMS_LINK)
			-- <Precursor>	
		local
			lst: like children
		do
			lst := children
			if lst /= Void then
				lst.prune_all (lnk)
				if lst.is_empty then
					children := Void
				end
			end
		end

	set_children (lst: like children)
			-- Set `children' to `lst'.	
		do
			children := lst
		ensure
			children_set: children = lst
		end

	set_permission_arguments (args: like permission_arguments)
			-- Set `permission_arguments' to `args'.
		do
			permission_arguments := args
		ensure
			permission_arguments_set: permission_arguments = args
		end

feature -- Status change

	set_is_active (b: BOOLEAN)
			-- Set `is_active' to `b'.
		do
			is_active := b
		ensure
			is_active: is_active = b
		end

	set_expanded (b: like is_expanded)
			-- Set `is_expanded' to `b'.
		do
			if b then
				set_expandable (True)
				set_collapsed (False)
			end
			internal_is_expanded := b
		ensure
			is_expanded: is_expanded = b
		end

	set_collapsed (b: like is_collapsed)
			-- Set `is_collapsed' to `b'.
		do
			if b then
				set_expanded (False)
			end
			internal_is_collapsed := b
		ensure
			is_collapsed: is_collapsed= b
		end

	set_expandable (b: like is_expandable)
			-- Set `is_expandable' to `b'.	
		do
			internal_is_expandable := b
		ensure
			is_expandable: is_expandable = b
		end

feature {NONE} -- Implementation

	internal_is_expandable: BOOLEAN

	internal_is_expanded: BOOLEAN

	internal_is_collapsed: BOOLEAN

invariant

note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
