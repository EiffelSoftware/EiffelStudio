indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_IMP

inherit

	EV_HEADER_I
		redefine
			interface
		end
		
	EV_ITEM_LIST_IMP [EV_HEADER_ITEM]
		redefine
			interface,
			initialize
		end
	
	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			destroy
		end
		
	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_HEADER_ACTION_SEQUENCES_IMP

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create an empty Tree.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_event_box_new)
		end

	initialize is
			-- 
		do
			Precursor {EV_ITEM_LIST_IMP}
			set_is_initialized (True)
		end

feature
	
	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_HEADER_ITEM_IMP
		do
			item_imp ?= v.implementation
			child_array.go_i_th (i)
			child_array.put_left (v)
				-- Fixme IEK: Insert node object in to parent
			item_imp.set_parent_imp (Current)
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item a`a_position'
		local
			item_imp: EV_HEADER_ITEM_IMP
		do
			child_array.go_i_th (a_position)
			item_imp ?=item.implementation
			item_imp.set_parent_imp (Void)
				-- Fixme IEK: Remove node object from parent.
			child_array.remove
		end

feature {NONE} -- Implementation

	pointed_divider_index: INTEGER is
			-- Index of divider currently beneath the mouse pointer, or
			-- 0 if none.
		do
		end

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Implement me
		end

	destroy is
			-- 
		do
			set_is_destroyed (True)
		end

	interface: EV_HEADER
		-- Interface object of `Current'.
	


end
