indexing
	description: "Stone representing a system."
	date: "$Date$"
	revision: "$Revision $"

class
	SYSTEM_STONE 

inherit
	SHARED_EIFFEL_PROJECT

	FILED_STONE

feature -- Access

	file_name: STRING is
			-- Name of the lace file
		do
			Result := Eiffel_ace.file_name
		end
 
	click_list: CLICK_STONE_ARRAY is
		do
			!! Result.make (Eiffel_ace.click_list, Void)
		end
 
	stone_signature: STRING is
		do
			if Eiffel_project.initialized and then Eiffel_project.system_defined then
				Result := Eiffel_system.name
			else
				-- FIXME: `stone_signature' is asked only when system 
				-- is compiled, and therefore `system_name' exists.
				Result := "Uncompiled"
			end
		end

	icon_name: STRING is "Ace"

	header: STRING is "Ace"
 
	stone_type: INTEGER is 
		do 
			Result := System_type 
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
			Result := Interface_names.s_System 
		end
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := Eiffel_ace.click_list /= Void
		end

feature -- Setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name' of lace.
		do
			Eiffel_ace.set_file_name (s)
		end
 
feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_system (Current)
		end

end -- class SYSTEM_STONE
