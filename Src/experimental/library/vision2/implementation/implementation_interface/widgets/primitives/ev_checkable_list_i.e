note
	description: "Eiffel Vision checkable list. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	checked_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- All items checked in `Current'.
		local
			original_position: INTEGER
		do
			original_position := index
			create Result.make (0)
			from
				start
			until
				off
			loop
				if is_item_checked (interface_item) then
					Result.extend (interface_item)
				end
				forth
			end
			go_i_th (original_position)
		ensure
			result_not_void: Result /= Void
		end

	is_item_checked (list_item: EV_LIST_ITEM): BOOLEAN
			-- Is `list_item' currently checked?
		deferred
		end

feature -- Status setting

	check_item (list_item: EV_LIST_ITEM)
			-- Ensure check associated with `list_item' is
			-- checked.
		deferred
		end


	uncheck_item (list_item: EV_LIST_ITEM)
			-- Ensure check associated with `list_item' is
			-- unchecked.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_CHECKABLE_LIST note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_CHECKABLE_LIST_I








