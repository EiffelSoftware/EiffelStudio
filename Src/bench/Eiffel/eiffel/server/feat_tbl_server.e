-- Server for routine tables associated to file ".FT"

class FEAT_TBL_SERVER 

inherit

	SERVER [FEATURE_TABLE]
		rename
			item as server_item,
			has as server_has
		export
			{ANY} server_item, server_has
		end;

	SERVER [FEATURE_TABLE]
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

	has (an_id: INTEGER): BOOLEAN is
			-- Has the current server or the associated temporary 
			-- server an item of id `an_id'.
		do
			Result := 	server_has (an_id)
						or else
						Tmp_feat_tbl_server.has (an_id)
		end;

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

	Size_limit: INTEGER is 40;

end
