indexing
	description: "[
				Strategies for calculating several features for subsets containing
				HASHABLEs.
			  ]"
	external_name: "ISE.Base.SubsetStrategyHashable"

class 
	SUBSET_STRATEGY_HASHABLE [G] 

inherit

	SUBSET_STRATEGY [G]

feature -- Comparison

	disjoint (set1, set2: TRAVERSABLE_SUBSET [G]): BOOLEAN is
		indexing
			description: "Are `set1' and `set2' disjoint?"
		local
			hash: HASH_TABLE [G, INTEGER]
			c: INTEGER
			ptr: ANY
		do
			create hash.make (set1.count + set2.count)
			if set1.object_comparison then
				hash.compare_objects
			end
			from
				Result := True
				set1.start
				set2.start
			until
				not Result or else (set1.after and set2.after)
			loop
				if not set1.after then
					if set1.object_comparison then
						c := set1.item.get_hash_code
					else
						ptr := set1.item
						c := hash_code_from_pointer ($ptr)
					end
					Result := not hash.has (c)
					if Result then hash.put (set1.item, c) end
				end
				if Result and then not set2.after then
					if set2.object_comparison then
						c := set2.item.get_hash_code
					else
						ptr := set2.item
						c := hash_code_from_pointer ($ptr)
					end
					Result := not hash.has (c)
					if Result then hash.put (set2.item, c) end
				end
				set1.forth
				set2.forth
			end
		end
	
feature -- Basic operations

	symdif (set1, set2: TRAVERSABLE_SUBSET [G]) is
		indexing
			description: "[
						Remove all items of `set1' that are also in `set2', and add all
						items of `set2' not already present in `set1'.
					  ]"
		local
			hash: HASH_TABLE [G, INTEGER]
			c: INTEGER
			ptr: ANY
		do
			create hash.make (set1.count + set2.count)
			if set1.object_comparison then
				hash.compare_objects
			end
			from set1.start until set1.after loop
				if set1.object_comparison then
					c := set1.item.get_hash_code
				else
					ptr := set1.item
					c := hash_code_from_pointer ($ptr)
				end
				hash.put (set1.item, c)
				set1.forth
			end
			from set2.start until set2.after loop
				if set2.object_comparison then
					c := set2.item.get_hash_code
				else
					ptr := set2.item
					c := hash_code_from_pointer ($ptr)
				end
				if hash.has (c) then
					hash.remove (c)
				else
					hash.put (set2.item, c)
				end
				set2.forth
			end
			set1.wipe_out
			from hash.start until hash.after loop
				set1.extend (hash.item_for_iteration)
				hash.forth
			end	
		end
	
feature {NONE} -- Implementation

	hash_code_from_pointer (p: POINTER): INTEGER is
		indexing
			description: "Hash code of the address of `p'"
		do
			Result := p.get_hash_code
		end

end -- class SUBSET_STRATEGY_HASHABLE
