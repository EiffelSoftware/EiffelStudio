indexing

	description: "Stone that is a new cluster stone.";
	date: "$Date$";
	revision: "$Revision $"

class 
	NEW_CLUSTER_STONE

inherit

	EC_STONE
		redefine
		--	stone_type
		end

feature -- Properties

-- 	stone_cursor: SCREEN_CURSOR is
-- 			-- Cursor associated with
-- 			-- Current stone during transport
-- 		do
-- 			Result := Cursors.new_cluster_cursor
--		end;

	data: DATA is 
			-- Associated data (Void by default)
		do 
		end;

	stone_type_pnd: EV_PND_TYPE is
			-- Current stone_type
		do
			Result := Stone_types.new_cluster_type_pnd
		end

	destroy_command: DESTROY is 
			-- Return Void
		do
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current.
		do
		end

feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		do
			Result := true
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
			com.process_new_cluster
		end;

end -- class NEW_CLUSTER_STONE





