indexing
	description: "Eiffel Vision checkable list. Implementation interface."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CHECKABLE_LIST_I
	
inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end
		
	EV_LIST_I
		redefine
			interface
		end
		
	EV_CHECKABLE_LIST_ACTION_SEQUENCES_I

feature -- Access

	checked_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- All items checked in `Current'.
		local
			original_position: INTEGER
		do
			original_position := interface.index
			create Result.make (0)
			from
				interface.start
			until
				interface.off
			loop
				if interface.is_item_checked (interface.item) then
					Result.extend (interface.item)
				end
				interface.forth
			end
			interface.go_i_th (original_position)
		ensure
			result_not_void: Result /= Void
		end

	is_item_checked (list_item: EV_LIST_ITEM): BOOLEAN is
			-- Is `list_item' currently checked?
		deferred
		end

feature -- Status setting

	check_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		deferred
		end


	uncheck_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- unchecked.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_LIST

end -- class EV_CHECKABLE_LIST_I
