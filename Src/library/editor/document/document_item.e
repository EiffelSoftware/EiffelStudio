indexing
	description	: "Document Item"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	DOCUMENT_ITEM

inherit
	ANY
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialize Current with `name' set to `a_name'.
		do
			name := a_name			
		end

feature -- Access

	name: STRING
			-- Name
			
	previous: like Current
	
	next: like Current

feature -- Status setting

	set_previous (a_prev: like previous) is
			-- Set `previous'		
		do
			previous := a_prev
			update_position
		ensure
			prev_set: previous = a_prev
		end
		
	set_next (a_next: like next) is
			-- Set `next'
		require
			a_next_not_void: a_next /= Void
		do
			next := a_next
			update_position
		ensure
			next_set: next = a_next
		end

feature -- Status

	is_equal (other: like Current): BOOLEAN is
			-- Compare the names
		do
			Result := (other /= Void) and then
				(name.is_equal (other.name))
		end
		
feature {NONE} -- Implementation

	update_position is
			-- Update position
		deferred
		end		

end -- class DOCUMENT_ITEM
