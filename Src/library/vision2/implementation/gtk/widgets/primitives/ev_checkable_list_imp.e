indexing
	description: "Eiffel Vision checkable list. Gtk implementation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_LIST_IMP
	
inherit
	EV_CHECKABLE_LIST_I
		undefine
			wipe_out,
			pixmaps_size_changed,
			selected_items
		redefine
			interface
		end
	
	EV_LIST_IMP
		redefine
			interface
		end
		
	EV_CHECKABLE_LIST_ACTION_SEQUENCES_IMP
	
creation
	make

feature -- Status report

	is_item_checked (list_item: EV_LIST_ITEM): BOOLEAN is
			--
		do
		end

feature -- Status setting

	check_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		do
		end

	uncheck_item (list_item: EV_LIST_ITEM) is
			-- Ensure check associated with `list_item' is
			-- checked.
		do
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_LIST
	
invariant
	invariant_clause: True -- Your invariant here

end -- class EV_CHECKABLE_LIST_IMP
