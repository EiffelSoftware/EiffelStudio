indexing

	description: "Stone that has view name.";
	date: "$Date$";
	revision: "$Revision$"

class VIEW_NAME_STONE

inherit

	STONE
		redefine
			destroy_data
		end;
	NAMABLE;
	ONCES;

creation

	make

feature -- Initialization

	make (a_data: like data; i: like view_id; view_n: like view_name) is
		require
			valid_a_data: a_data /= Void;
			valid_view_n: view_n /= Void;
			valid_id: i > 0
		do
			data := a_data;
			view_id := i;
			view_name := view_n
		ensure
			data_set: data = a_data
			view_id_set: view_id = i 
			view_name_set: view_name = view_n
		end;

feature -- Properties

	data: SYSTEM_DATA;
		-- Associated system data

	view_id: INTEGER;
		-- View id of Current project

	view_name: STRING
		-- View name

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with
	--		-- Current stone during transport
	--	do
	--	--	Result := Cursors.comment_cursor
	--	end;

	stone_type_pnd: EV_PND_TYPE is 
			-- Current stone type
		do
			Result := stone_types.view_name_type_pnd
		end

	destroy_command: DESTROY is
			-- Do nothing
		do
			--!! Result.make (data);
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current.
		do
		end;

feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		do
			Result  := True
		end;

feature -- Setting

	--set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	--	local
	--		cmd: CHANGE_NAME_U;
	----		txt: STRING;
	--		list: SYSTEM_VIEW_LIST;
	--	do
	--		txt := namer.entered_text;
	--		if not txt.empty then
	--			if not txt.is_equal (data.view_name) then
	--				list := System.retrieve_view_list;
	--				if list /= Void then
	--					if list.has_view_name (namer.entered_text) then
	--						Windows.error (Windows.main_graph_window, -- 1812
	--							Message_keys.view_name_exists_er, 
	--							namer.entered_text);
	--					else
	--						!! cmd.make (data, txt)
	--					end
	--				else
	--					!! cmd.make (data, txt)
	--				end
	--			end
	--		end
	--	end;

	--setup_namer (namer: NAMER_WINDOW) is
	--		-- Setup `namer' from data.
	--	do
	--		namer.set_up (False, False);		
	--		namer.set_text (data.view_name);
	--	end;

feature -- Removal

	destroy_data is
			-- Do nothing.
		do
		end;

end -- class VIEW_NAME_STONE

