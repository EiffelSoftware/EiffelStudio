indexing

	description: 
		"Class stone that has an element data associated with it.";
	date: "$Date$";
	revision: "$Revision $"

class ELEMENT_STONE

inherit

	EC_STONE;
	NAMABLE
		redefine
			illegal_characters
		end;

creation

	make

feature -- Initialization

	make (a_data: like data; data_cont: like data_container) is
			-- Set data to `a_data' and data_container to `data_cont'.
		do
			data := a_data;
			data_container := data_cont;
		ensure
			set: data = a_data and then
				data_container = data_cont
		end;

feature -- Properties

	data: ELEMENT_DATA;
			-- Associated element data

	data_container: DATA;
			-- Container that has data

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with 
	--		-- Current stone during transport.
	--	do
	--	--	Result := data.stone_cursor
	--	end;

	stone_type_pnd: EV_PND_TYPE is 
		do
			Result := stone_types.element_type_pnd
		end

	destroy_command: DESTROY is
			-- Command that destroys the data element
		do
			Result := data.destroy_command (data_container);
		end

feature -- Setting

--	set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	--	local
	--		a_data: like data;
	--		replace_command: REPLACE_DATA_U
	--	do
	--	--	a_data := deep_clone (data);
	--	--	a_data.update_from_namer (namer);
	--	--	!! replace_command.make (data_container,
	--	--			data, a_data);
	--	end;

--	setup_namer (namer: NAMER_WINDOW) is
	--		-- Setup `namer' from data.
	--	do
	--		data.setup_namer (namer)
	--	end;
--
feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		do
			Result := data.is_valid_for (data_container);
		end;

	illegal_characters (tag, text: STRING): BOOLEAN is
		do
			Result := data.illegal_characters (tag, text);
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
			com.process_element (Current)
		end;

feature -- Element change

	insert_before (a_stone: like Current) is
			-- Insert a_stone before Current;
		require
			valid_stone: a_stone /= Void;
			--compatible: a_stone.stone_type = stone_type
		do
			data.insert_before (data_container, a_stone.data);			
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current;
		local
			a_data: DATA;
			replace_command: REPLACE_DATA_U
		do
			a_data := clone (a_stone.data);
			!! replace_command.make (data_container,
					data, a_data);
		end;

end -- class ELEMENT_STONE
