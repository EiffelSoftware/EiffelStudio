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
			check
				not_available_with_gtk1_implementation: False
			end
		end

	initialize is
			-- 
		do
			
		end

feature
	
	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		do
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item a`a_position'
		do
		end

feature {NONE} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Implement me
		end

	destroy is
			-- 
		do
			
		end

	interface: EV_HEADER
	


end
