indexing

	description:
		"Shared mode value.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	SHARED_MODE
	
feature

	current_mode: INTEGER is
			-- Current execution/editing mode.
		do
			Result := current_mode_ref.item
		end

	set_mode (new_mode: INTEGER) is
			-- Set `current_mode' to `new_mode'.
		do
			current_mode_ref.set_item (new_mode)
		end

feature {NONE} -- Attribute

	current_mode_ref: INTEGER_REF is
			-- Current execution/editing mode.
		once
			!! Result
		end
		
end -- Class SHARED_MODE
