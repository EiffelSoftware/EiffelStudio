indexing

	description: 
		"Shared instance of the last callback structure processed.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_CALLBACK_STRUCT

feature -- Access

	last_callback_struct: MEL_CALLBACK_STRUCT is
		do	
			Result := last_callback_struct_cell.item;
		end;

feature {NONE} -- Implementation

	last_callback_struct_cell: CELL [MEL_CALLBACK_STRUCT] is
		once
		 	!! Result.put (Void)
		end;

	set_last_callback_struct (an_struct: like last_callback_struct) is
		do
			last_callback_struct_cell.put (an_struct)
		end;

end -- class SHARED_CALLBACK_STRUCT
