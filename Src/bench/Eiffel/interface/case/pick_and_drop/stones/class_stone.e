indexing

	description: "Stone that has class data associated with it.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_STONE

inherit

	EC_STONE;
	NAMABLE;
	ONCES

creation

	make

feature -- Initialization

	make (a_data: like data) is
		do
			data := a_data
		end;

feature -- Properties

	data: CLASS_DATA;
			-- Associated class data

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with 
	--		-- Current stone during transport.
	--	do
		--	Result := Cursors.class_cursor
	--	end;

	stone_type_pnd: EV_PND_TYPE is 
			-- Current stone type
		do
			Result := stone_types.class_type_pnd
		end

	destroy_command: DESTROY_CLASS is
			-- Command to destroy a class
		do
			if data /= Void and then data.is_in_system then
				!! Result.make (data);
			end
		end;

feature -- Setting

	--set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	--	local
	--		cmd: CHANGE_NAME_U;
	--		cl: CLUSTER_DATA;
	--		txt: STRING
	--	do
	--		txt := namer.entered_text;
	--		txt.to_upper;
	--		cl := data.parent_cluster;
	--		if not txt.empty and then not txt.is_equal (data.name) then
	--			if cl.has_class (txt) then
	--				namer.display_error_message
	--					(Message_keys.class_exists_er,
	--					txt)
	--			else
	--				!! cmd.make (data, txt)
	--			end
	--		end
	--	end;

	--setup_namer (namer: NAMER_WINDOW) is
	--		-- Setup `namer' from data.
	--	do
	--		namer.set_up (False, False);		
	--		if data /= Void
	--		then
	--			namer.set_text (data.name);
	--		else
	--			namer.set_text ("");
	--		end
	--		namer.set_class_list_with_prefix;
	--	end;

feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		do
			if data /= Void then
				Result := data.is_in_system
			else
				Result := false;
			end;
		end

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
			com.process_class (Current)
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current.
		do
		end;

feature {DESTROY_CLUSTER} -- Implementation

	destroy_subclass_command: DESTROY_CLASS is
			-- Command to destroy a class within a cluster
		do
			if data /= Void and then data.is_in_system then
				!! Result.make_subclass (data);
			end
		end;

end -- class CLASS_STONE
