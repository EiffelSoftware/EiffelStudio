indexing
	description: "Stone representing a cluster"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_STONE

inherit
	SHARED_EIFFEL_PROJECT

	STONE

feature -- Access

	cluster_i: CLUSTER_I

	cluster_name: STRING is
		do
			Result := cluster_i.cluster_name
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

	icon_name: STRING is
		do
			Result := cluster_i.cluster_name
		end

	header: STRING is
		do
			Result := cluster_i.cluster_name
		end
 
	stone_type: INTEGER is 
		do 
			Result := System_type 
		end

--	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
--		do
--			Result := Cursors.cur_System
--		end
 
--	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
--		do
--			Result := Cursors.cur_X_system
--		end
 
	stone_name: STRING is
			--| Fixme
			--| Christophe, 1 nov 1999
			--| to be changed later.
		do 
			Result := Interface_names.s_System 
		end
 
feature -- Update

--	process (hole: HOLE) is
--			-- Process Current stone dropped in hole `hole'.
--		do
--			hole.process_system (Current)
--		end

end -- class CLUSTER_STONE
