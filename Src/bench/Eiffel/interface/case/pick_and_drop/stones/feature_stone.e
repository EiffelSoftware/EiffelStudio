indexing

	description: "Stone that has a feature data associated with it.";
	date: "$Date$";
	revision: "$Revision $"

deferred class FEATURE_STONE

inherit

	STONE;
	NAMABLE

feature -- Properties

	data: FEATURE_DATA is
			-- Associated feature data
		deferred
		end;

	---stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with
	--		-- Current stone during transport
	--	do
		--	Result := Cursors.feature_cursor
	--	end;

	stone_type_pnd: EV_PND_TYPE is 
			-- Current stone type
		do
			Result := stone_types.feature_type_pnd
		end

	destroy_command: DESTROY_FEATURE is
		do
			--if data.class_container.is_in_system then
			--	!! Result.make (data.class_container, 
			--			data.class_container.find_clause (data).features,
			--			data);
			--end
		end;

feature -- Setting

	--set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	--	local
	--		cmd: CHANGE_NAME_U;
	--		txt: STRING;
	--		f_data: FEATURE_DATA
	--	do
	--		f_data := data;
	--		txt := namer.entered_text;
	--		txt.to_lower;
	--		if not txt.empty and then not txt.is_equal (f_data.name) then
	--			if f_data.class_container.has_feature (txt) then
	--				namer.display_error_message
	--					(Message_keys.feature_exists_er, 
	--					namer.entered_text)
	--			else
	--				!! cmd.make (f_data, txt);
	--			end
	--		end;
	--	end;

	--setup_namer (namer: NAMER_WINDOW) is
	--		-- Setup `namer' from data.
	--	do
	--		namer.set_up (False, False);
	--		namer.set_text (data.name);
	--	end;

feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		do
			Result := data.class_container.is_in_system and then 
				data.class_container.has_feature (data.name);
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
			com.process_feature (Current)
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current;
		local
			a_data: DATA;
			replace_command: REPLACE_DATA_U;
			f_data: FEATURE_DATA
		do
			f_data := data;
			a_data := clone (a_stone.data);
			!! replace_command.make (f_data.class_container,
					f_data, a_data);
		end;

feature -- Element change

	insert_before (a_stone: like Current) is
			-- Insert a_stone before Current;
		require
			valid_stone: a_stone /= Void;
			--compatible: a_stone.stone_type = stone_type
		local
			swap: SWAP_FEATURE_ELEMENT_U;
			features: FEATURE_LIST
		do
		--	if not data.class_container.is_in_server then
		--		data.class_container.request_for_information
		--	end;
		--	features := data.class_container.find_clause (data).features;
		--	!! swap.make (data.class_container, features, data, a_stone.data)
		end;

end -- class FEATURE_STONE
