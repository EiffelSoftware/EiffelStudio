indexing

	description: 
		"Stone representing a system.";
	date: "$Date$";
	revision: "$Revision $"

class SYSTEM_STONE 

inherit

	SHARED_EIFFEL_PROJECT;
	FILED_STONE;
	INTERFACE_W

feature -- Access

	file_name: STRING is
			-- Name of the lace ifle
		do
			Result := Eiffel_project.lace_file_name
		end;
 
	click_list: CLICK_STONE_ARRAY is
		do
			!! Result.make (Eiffel_project.lace_click_list, Void)
		end;
 
	signature: STRING is
		do
			if Eiffel_project.initialized and then
				Eiffel_project.system_defined then
				Result := Eiffel_system.name
			else
				-- FIXME: `signature' is asked only when system 
				-- is compiled, and therefore `system_name' exists.
				Result := "Uncompiled"
			end
		end;

	icon_name: STRING is "Ace";

	header: STRING is "Ace";
 
	stone_type: INTEGER is do Result := System_type end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with
			-- Current stone during transport.
		do
			Result := cur_System
		end;
 
	stone_name: STRING is do Result := l_System end;
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := true
		end

feature -- Setting

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name' of lace.
		do
			Eiffel_project.set_lace_file_name (s)
		end;
 
feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_system (Current)
		end;

end -- class SYSTEM_STONE
