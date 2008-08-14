indexing
	description: "Objects represent mappings of addresses. [referrer, referee]"
	date: "$Date$"
	revision: "$Revision$"

class
	MA_REFERENCES_TABLE [G -> HASHABLE, H -> HASHABLE]

create
	make

feature {NONE} -- Initialization

	make (a_referee_count: INTEGER) is
			-- Init with `a_referee_count'
		do
			create relations.make (a_referee_count)
		end

feature -- Access

	references_by_referee (a_referee: H): HASH_TABLE [TUPLE [referee: H; data: ANY], G] is
			-- All relations by referee.
		require
			a_referee_not_void: a_referee /= Void
		do
			Result := relations.item (a_referee)
			if Result = Void then
				create Result.make (0)
			end
		ensure
			Result_not_void: Result /= Void
		end

	referee_count: INTEGER is
			-- Count for referees
		do
			Result := relations.count
		end

	count: INTEGER is
			-- Count for all references.
		local
			l_relations: like relations
		do
			from
				l_relations := relations
				l_relations.start
			until
				l_relations.after
			loop
				Result := Result + l_relations.item_for_iteration.count
				l_relations.forth
			end
		end

feature -- Element change

	extend (a_referrer: G; a_referee: H; data: ANY) is
			-- Add new relations
		require
			a_referrer_not_void: a_referrer /= Void
			a_referee_not_void: a_referee /= Void
		local
			l_hash: like references_by_referee
		do
			if not relations.has_key (a_referee) then
				create l_hash.make (20)
					-- Here we prevent extending pairs exsited or with equivalent key and value.
				relations.force (l_hash, a_referee)
			else
				l_hash := relations.found_item
			end
			l_hash.force ([a_referee, data], a_referrer)
		end

feature -- Removal

	remove (a_referrer: G; a_referee: H) is
			-- Remove relation between `'a_referrer' and `a_referee'.
		require
			a_referrer_not_void: a_referrer /= Void
			a_referee_not_void: a_referee /= Void
		local
			l_hash: like references_by_referee
		do
			if relations.has_key (a_referee) then
				l_hash := relations.found_item
				l_hash.remove (a_referrer)
				if l_hash.is_empty then
					relations.remove (a_referee)
				end
			end
		end

feature {NONE} -- Implementation

	relations: HASH_TABLE [like references_by_referee, H];

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
