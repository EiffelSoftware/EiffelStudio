-- Server for replicated features 

class REP_SERVER 

inherit

	SERVER [REP_FEATURES]
		rename
			item as server_item,
			has as server_has,
			disk_item as disk_server_item
		export
			{ANY} server_item
		end;
	SERVER [REP_FEATURES]
		redefine
			disk_item, has, item
		select
			has, item, disk_item
		end

creation

	make

feature 

	Cache: REP_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	item (an_id: INTEGER): REP_FEATURES is
			-- Replicate features of class id `an_id'. 
			-- Look first in the temporary rep feat server.
		require else
			has_an_id: has (an_id);
		do
			if Tmp_rep_server.has (an_id) then
				Result := Tmp_rep_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		end;

	disk_item (an_id: INTEGER): REP_FEATURES is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_rep_server.has (an_id) then
				Result := Tmp_rep_server.disk_item (an_id);
			else
				Result := disk_server_item (an_id);
			end;
		end;

	has (an_id: INTEGER): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_rep_feat_server' or
			-- Current ?
		require else
			positive_id: an_id > 0;
		do
			Result := server_has (an_id) or else Tmp_rep_server.has (an_id);
		end;

	Size_limit: INTEGER is 750000;

end
