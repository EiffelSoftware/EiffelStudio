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

	file_name: STRING is
			-- Name of the DEF file
		do
			Result := Eiffel_dynamic_lib.file_name
		end
 
	click_list: CLICK_STONE_ARRAY is
		do
--			!! Result.make (Eiffel_ace.click_list, Void)
		end
 
	signature: STRING is
		do
			Result := ""
		end

	icon_name: STRING is "Dynamic Lib"

	header: STRING is "Dynamic Lib"
 
	stone_type: INTEGER is 
		do 
			Result := Dynamic_lib_type 
		end

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_System
		end
 
	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_system
		end
 
	stone_name: STRING is 
		do 
			Result := Interface_names.s_Dynamic_lib_stone 
		end
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
--			Result := Eiffel_ace.click_list /= Void
			Result := False
		end

feature -- Setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name' of lace.
		do
			Eiffel_dynamic_lib.set_file_name (s)
		end

 
feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
--			hole.process_dynamic_lib (Current)
		end

end -- class DYNAMIC_LIB_STONE

