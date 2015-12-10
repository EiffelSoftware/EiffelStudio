note
	description: "[
			Collection of CMS terms (see Taxonomy).
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_TERM_COLLECTION

inherit
	ITERABLE [CMS_TERM]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make (nb)
			items.compare_objects
		end

feature -- Access

	new_cursor: INDEXABLE_ITERATION_CURSOR [CMS_TERM]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

	count: INTEGER
			-- Number of terms.
		do
			Result := items.count
		end

feature -- Status report

	is_empty: BOOLEAN
		do
			Result := count = 0
		end

	has (a_term: CMS_TERM): BOOLEAN
			-- Has `a_term'?
		do
			Result := items.has (a_term)
		end

	term_by_id (tid: INTEGER_64): detachable CMS_TERM
			-- Term of id `tid' contained in Current, if any.
		do
			across
				items as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if Result.id /= tid then
					Result := Void
				end
			end
		end

feature -- Element change

	wipe_out
			-- Remove all items.
		do
			items.wipe_out
		ensure
			empty: count = 0
		end

	force, extend (a_term: CMS_TERM)
			-- Add term `a_term';
		do
			if not has (a_term) then
				items.force (a_term)
			end
		end

	remove (a_term: CMS_TERM)
			-- Remove term `a_term'.
		do
			items.prune_all (a_term)
		end

	sort
			--  Sort `items'
		local
			l_sorter: QUICK_SORTER [CMS_TERM]
		do
			create l_sorter.make (create {COMPARABLE_COMPARATOR [CMS_TERM]})
			l_sorter.sort (items)
		end

feature {NONE} -- Implementation

	items: ARRAYED_LIST [CMS_TERM]
			-- List of terms.			

;note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
