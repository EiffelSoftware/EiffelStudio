indexing

	description: "Stone that has a color name.";
	date: "$Date$";
	revision: "$Revision $"

class COLOR_STONE 

inherit

	EC_STONE

creation

	make

feature -- Initialization

	make (a_name: STRING) is
			-- Set color_name  to `a_name'.
		require
			valid_a_name: a_name /= Void
		do
			color_name := a_name
		ensure
			color_name_set: color_name = a_name
		end;

feature -- Properties

	color_name: STRING;
			-- Color name

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with 
	--		-- Current stone during transport.
	--	do
	--	--	Result := Cursors.color_cursor
	--	end;

	data: DATA is
			-- No Data associated with stone
		do
		end;

	stone_type_pnd: EV_PND_TYPE is 
			-- Current stone type
		do
			Result := Stone_types.color_type_pnd
		end;

	destroy_command: DESTROY is
			-- Destroy command to remove Current stone and its
			-- data.
		do
		end;

feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		do
			Result := true;
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
			com.process_color (Current)
		end;


feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current.
		do
		end

end -- class COLOR_STONE
