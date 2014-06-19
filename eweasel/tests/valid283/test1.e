class TEST1 [G -> PARENT]
feature

	new_relation
			-- Returns a new relation from the relation store
		do
			table_relation_store.new_relation (parent)
		end

	table_relation_store: TEST3 [G]
		do
			check False then end
		end


	parent: detachable ANY

end
