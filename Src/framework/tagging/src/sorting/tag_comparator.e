indexing
	description: "Summary description for {TAG_COMPARATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_COMPARATOR [G -> TAGABLE_I]

inherit
	KL_COMPARATOR [G]

	TAG_UTILITIES
		export
			{ANY} is_valid_tag
			{NONE} all
		end

create
	make

feature -- Initialization

	make, set_prefix (a_prefix: like tag)
			-- Set `tag' to `a_prefix'.
		require
			a_prefix_valid: is_valid_tag (a_prefix)
		do
			create tag.make_from_string (a_prefix)
		end

feature -- Access

	tag: !STRING
			-- Prefix used for comparing two items

feature -- Status report

	less_than (u, v: G): BOOLEAN
			-- <Precursor>
			--
			-- Note: This will collect the all the tags beginning with `tag' of both itmes and compare,
			--       which item has the least in terms of string comparison. A item having any tags is
			--       automatically less than an item having no tags. If both items least tag is equal,
			--       or both items have no tags, `less_than' will compare its names.
		local
			l_uleast, l_vleast: like tag
			l_usuff, l_vsuff: !DS_LINEAR [like tag]
			l_compare_names: BOOLEAN
		do
			l_usuff := tag_suffixes (u.tags, tag)
			l_vsuff := tag_suffixes (v.tags, tag)
			if l_vsuff.is_empty then
				if l_usuff.is_empty then
					l_compare_names := True
				else
					Result := True
				end
			elseif not l_usuff.is_empty then
				from
					l_usuff.start
					l_vsuff.start
					l_uleast := l_usuff.first
					l_vleast := l_vsuff.first
					Result := l_uleast < l_vleast
				until
					l_usuff.after or l_vsuff.after
				loop
					if Result then
						l_vsuff.forth
						if not l_vsuff.after and then l_vsuff.item_for_iteration < l_vleast then
							l_vleast := l_vsuff.item_for_iteration
							Result := l_uleast < l_vleast
						end
					else
						l_usuff.forth
						if not l_usuff.after and then l_usuff.item_for_iteration < l_uleast then
							l_uleast := l_usuff.item_for_iteration
							Result := l_uleast < l_vleast
						end
					end
				end
				if not Result then
					l_compare_names := l_uleast.is_equal (l_vleast)
				end
			else
				-- v has tags, u doesn't, so
				--
				-- v is less then u
			end
			if l_compare_names then
				Result := u.name < v.name
			end
		end

end
