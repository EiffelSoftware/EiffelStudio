indexing

	description: "Stone that is a new class stone.";
	date: "$Date$";
	revision: "$Revision $"

class 
	NEW_CLASS_STONE

inherit

	STONE
		redefine
		--	stone_type
		end

feature -- Properties

-- 	stone_cursor: SCREEN_CURSOR is
-- 			-- Cursor associated with
-- 			-- Current stone during transport
-- 		do
-- 			Result := Cursors.new_class_cursor
-- 		end;

	data: DATA is 
			-- Associated data
		do 
		end;

	stone_type_pnd: EV_PND_TYPE is
			-- Current stone type
		do
			Result := Stone_types.new_class_type_pnd
		end;

	destroy_command: DESTROY is 
			-- Return Void
		do 
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
			com.process_new_class
		end;

feature -- Element change

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

end -- class NEW_CLASS_STONE
