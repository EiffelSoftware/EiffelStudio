note
	description: "Collection of metadata (single or multiple value)."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_RESPONSE_METADATA

inherit
	ITERABLE [TUPLE [value: READABLE_STRING_32; key: READABLE_STRING_GENERAL]]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make (nb)
		end

feature -- Access

	item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			across
				items as ic
			until
				Result /= Void
			loop
				if k.is_case_insensitive_equal (ic.item.key) then
					Result := ic.item.value
				end
			end
		end

	multiple_items (k: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
		do
			across
				items as ic
			loop
				if k.is_case_insensitive_equal (ic.item.key) then
					if Result = Void then
						create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (1)
					end
					Result.force (ic.item.value)
				end
			end
		end

	new_cursor: ARRAYED_LIST_ITERATION_CURSOR [TUPLE [value: READABLE_STRING_32; key: READABLE_STRING_GENERAL]]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

feature -- Status report		

	is_empty: BOOLEAN
		do
			Result := items.is_empty
		end

	count: INTEGER
		do
			Result := items.count
		end

	has_keys (lst: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
		do
			across
				items as ic
			until
				Result
			loop
				Result := across lst as k_ic some ic.item.key.is_case_insensitive_equal (k_ic.item) end
			end
		end

	has_key (k: READABLE_STRING_GENERAL): BOOLEAN
		do
			across
				items as ic
			until
				Result
			loop
				Result := ic.item.key.is_case_insensitive_equal (k)
			end
		end

	is_multiple_value_metadata (k: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `k` the name of a multiple value metadata such as "article:tag" ?
		do
				-- FIXME: this is hardcoded!
			Result := k.is_case_insensitive_equal ("article:tag")
		end

feature -- Element change

	put (v: READABLE_STRING_32; k: READABLE_STRING_GENERAL)
		local
			lst: like items
			l_is_found: BOOLEAN
		do
			lst := items
			from
				lst.start
			until
				lst.after
			loop
				if k.is_case_insensitive_equal (lst.item.key) then
						-- Keep
					l_is_found := True
				else
					lst.forth
				end
			end
			if not l_is_found then
				lst.force ([v, k])
			end
		end

	force (v: READABLE_STRING_32; k: READABLE_STRING_GENERAL)
		local
			lst: like items
			l_is_found: BOOLEAN
		do
			lst := items
			from
				lst.start
			until
				lst.after
			loop
				if k.is_case_insensitive_equal (lst.item.key) then
					if l_is_found then
						lst.remove
					else
						lst.item.value := v
						l_is_found := True
					end
				else
					lst.forth
				end
			end
			if not l_is_found then
				lst.force ([v, k])
			end
		end

	add (v: READABLE_STRING_32; k: READABLE_STRING_GENERAL)
		do
			items.force ([v, k])
		end

	merge (md: CMS_RESPONSE_METADATA)
		do
			across
				md as ic
			loop
					-- handle multiple values...
				if is_multiple_value_metadata (ic.item.key) then
					add (ic.item.value, ic.item.key)
				else
					force (ic.item.value, ic.item.key)
				end
			end
		end

	remove (k: READABLE_STRING_GENERAL)
		local
			lst: like items
		do
			lst := items
			from
				lst.start
			until
				lst.after
			loop
				if k.is_case_insensitive_equal (lst.item.key) then
					lst.remove
				else
					lst.forth
				end
			end
		end

feature {NONE} -- Implementation

	items: ARRAYED_LIST [TUPLE [value: READABLE_STRING_32; key: READABLE_STRING_GENERAL]]

;note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
