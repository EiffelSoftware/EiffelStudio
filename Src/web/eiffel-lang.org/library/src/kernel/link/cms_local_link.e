note
	description: "Summary description for {CMS_LOCAL_MENU}."
	author: ""
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
		do
			if a_title /= Void then
				title := a_title
			else
				title := a_location
			end
			location := a_location
		end

feature -- Status report

	is_active: BOOLEAN

	is_expanded: BOOLEAN
		do
			Result := is_expandable and then internal_is_expanded
		end

	is_expandable: BOOLEAN
		do
			Result := internal_is_expandable or internal_is_expanded or has_children
		end

	has_children: BOOLEAN
		do
			Result := attached children as l_children and then not l_children.is_empty
		end

	permission_arguments: detachable ITERABLE [READABLE_STRING_8]

	children: detachable LIST [CMS_LINK]

	internal_is_expandable: BOOLEAN

	internal_is_expanded: BOOLEAN

feature -- Element change

	add_link (lnk: CMS_LINK)
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
		do
			children := lst
		end

	set_expanded (b: like is_expanded)
		do
			internal_is_expanded := b
		end

	set_expandable (b: like is_expandable)
		do
			internal_is_expandable := b
		end

	get_is_active (req: WSF_REQUEST)
		local
			qs: STRING
		do
			create qs.make_from_string (req.path_info)
			is_active := qs.same_string (location)
			if not is_active then
				if attached req.query_string as l_query_string and then not l_query_string.is_empty then
					qs.append_character ('?')
					qs.append (l_query_string)
				end
				is_active := qs.same_string (location)
			end
		end

	set_permission_arguments (args: like permission_arguments)
		do
			permission_arguments := args
		end

	set_options (opts: like options)
		do
			options := opts
		end

end
