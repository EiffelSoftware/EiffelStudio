indexing
	description: "Stone representing a dynamic_lib."
	date: "$Date$"
	revision: "$Revision $"

class
	DYNAMIC_LIB_STONE 

inherit
	SHARED_EIFFEL_PROJECT

	FILED_STONE

feature -- Access

	file_name: FILE_NAME is
			-- Name of the DEF file
		do
			create Result.make_from_string (Eiffel_dynamic_lib.file_name)
		end
 
	stone_signature: STRING is
		do
			Result := ""
		end

	history_name: STRING is
		do
			Result := "Dynamic library"
		end

	header: STRING is "Dynamic Lib"
 
	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Cluster
		end
 
	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_cluster
		end
 
feature -- Setting

	set_file_name (new_filename: FILE_NAME) is
			-- Assign `s' to `file_name' of lace.
		do
			Eiffel_dynamic_lib.set_file_name (new_filename)
		end

end -- class DYNAMIC_LIB_STONE

