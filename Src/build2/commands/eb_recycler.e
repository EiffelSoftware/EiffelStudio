indexing
	description	: "Recycler for recyclable objects"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_RECYCLER

feature -- Basic operations

	destroy is
			-- To be called when Current has became useless.
		do
			if managed_recyclable_items /= Void then
				from
					managed_recyclable_items.start
				until		
					managed_recyclable_items.after
				loop
					managed_recyclable_items.item.recycle
					managed_recyclable_items.remove
				end
			end
		end

	add_recyclable (a_recyclable_item: EB_RECYCLABLE) is
			-- Add `a_recyclable_items' to the list of managed recyclable
			-- items.
		do
			if managed_recyclable_items = Void then
				create managed_recyclable_items.make (2)
			end
			managed_recyclable_items.extend (a_recyclable_item)
		end

	remove_recyclable (a_recyclable_item: EB_RECYCLABLE) is
			-- Remove `a_recyclable_items' from the list.
		do
			if managed_recyclable_items /= Void then
				managed_recyclable_items.prune_all (a_recyclable_item)
			end
		end

feature {NONE} -- Implementation

	managed_recyclable_items: ARRAYED_LIST [EB_RECYCLABLE]
			-- Registered recyclable items.
	



end -- class EB_RECYCLABLE