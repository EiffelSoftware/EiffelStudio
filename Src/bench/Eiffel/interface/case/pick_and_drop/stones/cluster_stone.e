indexing

	description: 
		"Stone that has cluster data associated with it.";
	date: "$Date$";
	revision: "$Revision $"

class CLUSTER_STONE

inherit

	STONE;
	NAMABLE;
	ONCES

creation

	make

feature

feature -- Initialization

	make (a_data: like data) is
			-- Set data to `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end;

feature -- Properties

	data: CLUSTER_DATA;
			-- Associated cluster data

	--stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with 
			-- Current stone during transport.
	--	do
		--	Result := Cursors.cluster_cursor
	--	end;

	stone_type_pnd: EV_PND_TYPE is 
			-- Current stone type
		do
			Result := stone_types.cluster_type_pnd
		end


	destroy_command: DESTROY_CLUSTER is
			-- Command to destroy a cluster
		do
			if not data.is_root and then data.is_in_system then
				!! Result.make (data);
			end
		end;

feature -- Namable

	--set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	--	local
	---		cmd: CHANGE_NAME_U;
	--		txt: STRING
	--	do
	--		txt := namer.entered_text;
	--		txt.to_upper;
	--		if not txt.empty and then not txt.is_equal (data.name) then
	--			if System.has_cluster (txt) then
	--				namer.display_error_message
	--					(Message_keys.cluster_exists_er, txt)
	--			else
	--				!! cmd.make (data, txt);
	--			end
	--		end
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
			Result := data.is_in_system
		end

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
			com.process_cluster (Current)
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current.
		do
		end

feature {DESTROY_CLUSTER} -- Implementation

	destroy_subcluster_command: DESTROY_CLUSTER is
			-- Command to destroy cluster within a cluster
		do
			if not data.is_root and then data.is_in_system then
				!! Result.make_subcluster (data);
			end
		end;

end -- class CLUSTER_STONE
