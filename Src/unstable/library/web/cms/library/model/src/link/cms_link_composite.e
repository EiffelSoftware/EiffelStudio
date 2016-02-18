note
	description: "[
				Abstraction to represent a links container in the CMS system.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_LINK_COMPOSITE

inherit
	ITERABLE [CMS_LINK]

feature -- Access	

	items: detachable LIST [CMS_LINK]
			-- Children links.
		deferred
		end

	item_by_title (a_title: READABLE_STRING_GENERAL): detachable CMS_LINK
			-- First link with title `a_title' if any.
		do
			if attached items as l_items then
				across
					l_items as ic
				until
					Result /= Void
				loop
					Result := ic.item
					if not a_title.is_case_insensitive_equal (Result.title) then
						Result := Void
					end
				end
			end
		ensure
			coherent_result: Result /= Void implies Result.title.is_case_insensitive_equal_general (a_title)
		end

	item_by_location (a_loc: READABLE_STRING_8): detachable CMS_LINK
			-- First link with location `a_loc' if any.
		do
			if attached items as l_items then
				across
					l_items as ic
				until
					Result /= Void
				loop
					Result := ic.item
					if not a_loc.same_string (Result.location) then
						Result := Void
					end
				end
			end
		ensure
			coherent_result: Result /= Void implies Result.location.same_string (a_loc)
		end

	new_composite_item (a_title: detachable READABLE_STRING_GENERAL; a_location: READABLE_STRING_8): CMS_LINK_COMPOSITE
			-- If exists, item with location `a_location' or title `a_title',
			-- otherwise create new local link and extend to Current.
		local
			lnk: CMS_LOCAL_LINK
		do
			if attached {CMS_LINK_COMPOSITE} item_by_location (a_location) as l_parent then
				Result := l_parent
			elseif a_title /= Void and then attached {CMS_LINK_COMPOSITE} item_by_title (a_title) as l_parent then
				Result := l_parent
			else
				create lnk.make (a_title, a_location)
				extend (lnk)
				Result := lnk
			end
			if attached {CMS_LOCAL_LINK} Result as l_local_lnk and then not l_local_lnk.is_expanded then
				l_local_lnk.set_expandable (True)
				l_local_lnk.set_collapsed (True)
			end
		end

feature -- Element change

	extend (lnk: CMS_LINK)
			-- Add `lnk' as a sub link.	
		deferred
		end

	extend_into (lnk: CMS_LINK; a_parent_title: detachable READABLE_STRING_GENERAL; a_parent_location: READABLE_STRING_8)
			-- Extend `lnk' into local link with location `a_parent_location'.
			-- If the parent is not found, create it with title `a_parent_title'.
		local
			l_parent: CMS_LINK_COMPOSITE
		do
			l_parent := new_composite_item (a_parent_title, a_parent_location)
			l_parent.extend (lnk)
		end

	remove (lnk: CMS_LINK)
			-- Remove link `lnk' from Current container.
		deferred
		end

	sort
			-- Sort `items' and also recursively in sub items.
		local
			l_sorter: QUICK_SORTER [CMS_LINK]
		do
			create l_sorter.make (create {COMPARABLE_COMPARATOR [CMS_LINK]})
			if attached items as lst then
				l_sorter.sort (lst)
				across
					lst as ic
				loop
					if
						attached {CMS_LINK_COMPOSITE} ic.item as l_composite and then
						not l_composite.is_empty
					then
						l_composite.sort
					end
				end
			end
		end

feature -- status report

	is_empty: BOOLEAN
			-- Is container empty?
		do
			Result := not attached items as l_items or else l_items.is_empty
		end

	count: INTEGER
			-- Number of immediate sub links.
		do
			if attached items as l_items then
				Result := l_items.count
			end
		end

note
	copyright: "2011-2016, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
