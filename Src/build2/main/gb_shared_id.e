indexing
	description: "Objects that handle object id's in Build."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_ID

feature -- Status setting

	reset_id_counter is
			-- Reset `counter' to 1.
			-- This forces object ids to start
			-- at one again. Should be performed
			-- when closing an open project.
		do
			set_current_id_counter (1)
		end

feature -- Basic operations

	new_id: INTEGER is
			-- `Result' is a new id, guaranteed
			-- not to be already contained in `current_ids'.
		do
			Result := internal_counter.item
			set_current_id_counter (internal_counter.item + 1)
		end
		
	set_current_id_counter (value: INTEGER) is
			-- Set `value' to `internal_counter'.
		do
			internal_counter.set_item (value)
		end
		
	current_id_counter: INTEGER is
			-- `Result' is value of `internal_counter'.
		do
			Result := internal_counter.item
		end

feature {NONE} -- Implementation
		
	internal_counter: INTEGER_REF is
			-- Counter to set unique id's to items.
		once
			create Result
			Result.set_item (1)
		end

end -- class GB_SHARED_ID
