-- Server for routine tables associated to file ".FT"

class
	FEAT_TBL_SERVER 

inherit
	COMPILER_SERVER [FEATURE_TABLE, CLASS_ID]
		redefine
			has, item, make
		end

creation
	make

feature -- Initialisation

	make is
		-- Creation
		do
			{COMPILER_SERVER}Precursor
			!! cache.make
		end

	
feature -- Access

	cache: FEAT_TBL_CACHE 
			-- Cache for routine tables
		
	has (an_id: CLASS_ID): BOOLEAN is
			-- Has the current server or the associated temporary 
			-- server an item of id `an_id'.
		do
			Result := Tmp_feat_tbl_server.has (an_id) or else server_has (an_id)
		end;

	id (t: FEATURE_TABLE): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.feat_tbl_id
		end

	item (an_id: CLASS_ID): FEATURE_TABLE is
			-- Feature table of id `an_id'. Look first in the temporary
			-- feature table server. It not present, look in itself.
		do
			if Tmp_feat_tbl_server.has (an_id) then
				Result := Tmp_feat_tbl_server.item (an_id);
			else
				Result := server_item (an_id);
			end; 
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 400
			-- Size of the FEAT_TBL_SERVER file (400 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
