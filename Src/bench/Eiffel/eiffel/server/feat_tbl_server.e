-- Server for routine tables associated to file ".FT"

class FEAT_TBL_SERVER 

inherit

	COMPILER_SERVER [FEATURE_TABLE, CLASS_ID]
		rename
			item as server_item,
			has as server_has
		export
			{ANY} server_item, server_has
		end;

	COMPILER_SERVER [FEATURE_TABLE, CLASS_ID]
		redefine
			has, item
		select
			has, item
		end

creation

	make
	
feature 

	Cache: FEAT_TBL_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	has (an_id: CLASS_ID): BOOLEAN is
			-- Has the current server or the associated temporary 
			-- server an item of id `an_id'.
		do
			Result := server_has (an_id) or else Tmp_feat_tbl_server.has (an_id)
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

	Size_limit: INTEGER is 200
			-- Size of the FEAT_TBL_SERVER file (200 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
