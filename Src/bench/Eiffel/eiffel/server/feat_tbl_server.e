indexing
	description: "Server for feature tables indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class
	FEAT_TBL_SERVER 

inherit
	COMPILER_SERVER [FEATURE_TABLE]
		redefine
			has, item
		end

creation
	make
	
feature -- Access

	cache: FEAT_TBL_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
		
	has (an_id: INTEGER): BOOLEAN is
			-- Has the current server or the associated temporary 
			-- server an item of id `an_id'.
		do
			Result := Tmp_feat_tbl_server.has (an_id) or else server_has (an_id)
		end;

	id (t: FEATURE_TABLE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.feat_tbl_id
		end

	item (an_id: INTEGER): FEATURE_TABLE is
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
