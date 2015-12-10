note
	description: "[
			Collection of CMS vocabularies (see Taxonomy).
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_VOCABULARY_COLLECTION

inherit
	ITERABLE [CMS_VOCABULARY]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make (nb)
			items.compare_objects
		end

feature -- Access

	item_by_name (a_voc_name: READABLE_STRING_GENERAL): detachable CMS_VOCABULARY
			-- Vocabulary from current collection associated with name `a_voc_name', if any.
		do
			across
				items as ic
			until
				Result /= Void
			loop
				if ic.item.name.is_case_insensitive_equal_general (a_voc_name) then
					Result := ic.item
				end
			end
		end

	item_by_id (a_id: INTEGER_64): detachable CMS_VOCABULARY
			-- Vocabulary of id `a_id' contained in Current, if any.
		do
			across
				items as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if Result.id /= a_id then
					Result := Void
				end
			end
		end

	new_cursor: INDEXABLE_ITERATION_CURSOR [CMS_VOCABULARY]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

	count: INTEGER
			-- Number of vocabularies.
		do
			Result := items.count
		end

feature -- Status report

	is_empty: BOOLEAN
		do
			Result := count = 0
		end

	has (a_vocabulary: CMS_VOCABULARY): BOOLEAN
			-- Has `a_vocabulary'?
		do
			Result := items.has (a_vocabulary)
		end

feature -- Element change

	force, extend (a_vocabulary: CMS_VOCABULARY)
			-- Add vocabulary `a_vocabulary';
		do
			if not has (a_vocabulary) then
				items.force (a_vocabulary)
			end
		end

	remove (a_vocabulary: CMS_VOCABULARY)
			-- Remove vocabulary `a_vocabulary'.
		do
			items.prune_all (a_vocabulary)
		end

	sort
			--  Sort `items'
		local
			l_sorter: QUICK_SORTER [CMS_VOCABULARY]
		do
			create l_sorter.make (create {COMPARABLE_COMPARATOR [CMS_VOCABULARY]})
			l_sorter.sort (items)
		end

feature {NONE} -- Implementation

	items: ARRAYED_LIST [CMS_VOCABULARY]
			-- List of vocabularies.			

;note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
